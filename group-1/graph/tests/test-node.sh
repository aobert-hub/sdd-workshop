#!/bin/sh
# Tests of graph/node.sh. Builds a throwaway group folder (group-9/ inside a throwaway git
# repository, like a real group) and runs the node there with the fake agent: no model is called.
here=$(cd "$(dirname "$0")" && pwd)
graph=$(dirname "$here")
fails=0

ok() { printf '  ok   %s\n' "$1"; }
bad() { printf '  FAIL %s\n' "$1"; fails=$((fails + 1)); }
# check <case> <command...>: ok when the command succeeds
check() {
  c_name=$1; shift
  if "$@"; then ok "$c_name"; else bad "$c_name"; fi
}
has() { grep -F -q -- "$2" "$1"; }
lacks() { ! grep -F -q -- "$2" "$1"; }

root=$(mktemp -d)
trap 'rm -rf "$root"' EXIT
g=$root/group-9
mkdir -p "$g/graph/tests" "$g/graph/runs" "$g/app" "$g/tickets"
cp "$graph/node.sh" "$graph/lib.sh" "$g/graph/" 2> /dev/null
cp "$here/fake-agent.sh" "$g/graph/tests/"
for t in good fail slow outside no-report bad-report block pass; do
  printf '# %s\n' "$t" > "$g/tickets/$t.md"
done
printf 'app\n' > "$g/app/index.html"
(
  cd "$root" && git init -q . \
    && git add -A \
    && git -c user.name=t -c user.email=t@t commit -q -m start
) > /dev/null 2>&1

n=0
# job <json>: a new step folder with that input.json; its path is in $step
job() {
  n=$((n + 1))
  step=graph/runs/t/step-$n
  mkdir -p "$g/$step"
  printf '%s\n' "$1" > "$g/$step/input.json"
}
# node: runs the node on $step from the group folder; output in $out, exit code in $code
node() {
  out=$g/$step/stdout.txt
  code=0
  (cd "$g" && sh graph/node.sh "$step") > "$out" 2>&1 || code=$?
}
status() { json_status=$(sed -n 's/.*"status":"\([a-z]*\)".*/\1/p' "$g/$step/output.json"); [ "$json_status" = "$1" ]; }
agent() { printf '{"kind":"agent","dir":"app","ticket":"tickets/%s.md","agent":"graph/tests/fake-agent.sh"%s}' "$1" "${2:+,$2}"; }

echo "node.sh"

if [ ! -f "$g/graph/node.sh" ]; then bad "graph/node.sh exists"; fi

# 1. commands that pass
job '{"kind":"commands","dir":"app","run":"echo hello-from-grey"}'
node
check "commands that pass: green, exit 0" sh -c "[ $code = 0 ]"
check "commands that pass: output.json is green" status green
check "commands that pass: printed green:" has "$out" "green:"
check "commands that pass: report.md has the output" has "$g/$step/report.md" "hello-from-grey"

# 2. commands that fail
job '{"kind":"commands","dir":"app","run":"echo boom; exit 3"}'
node
check "commands that fail: red, exit 1" sh -c "[ $code = 1 ]"
check "commands that fail: output.json is red" status red
check "commands that fail: the why names report.md" has "$g/$step/output.json" "report.md"
check "commands that fail: report.md has the output" has "$g/$step/report.md" "boom"

# 3. the agent finishes
job "$(agent good)"
node
check "agent finishes: green, exit 0" sh -c "[ $code = 0 ]"
check "agent finishes: output.json is green" status green
check "agent finishes: agent.log is in the step folder" test -f "$g/$step/agent.log"
check "agent finishes: report.md written" has "$g/$step/report.md" "## Not done"
check "agent finishes: output.json has started and ended" has "$g/$step/output.json" '"ended"'

# 4. the agent fails, or runs past its limit
job "$(agent fail)"
node
check "agent fails: red, exit 1" sh -c "[ $code = 1 ]"
check "agent fails: the why says it failed" has "$g/$step/output.json" "agent failed"

job "$(agent slow '"limit":2')"
start=$(date +%s)
node
elapsed=$(($(date +%s) - start))
check "agent past its limit: red, exit 1" sh -c "[ $code = 1 ]"
check "agent past its limit: the why says it was cut after 2 s" has "$g/$step/output.json" "agent cut after 2 s"
check "agent past its limit: stopped well before the 30 s of the agent" sh -c "[ $elapsed -lt 20 ]"

# 5. the agent writes outside dir
job "$(agent outside)"
node
check "agent writes outside dir: red, exit 1" sh -c "[ $code = 1 ]"
check "agent writes outside dir: the why says it touched outside app" has "$g/$step/output.json" "agent touched outside app"
check "agent writes outside dir: the why names the path" has "$g/$step/output.json" "tickets/outside.txt"
check "agent writes outside dir: the group prefix is taken off" lacks "$g/$step/output.json" "group-9/tickets"
rm -f "$g/tickets/outside.txt"

# 6. a malformed job: red, nothing run, nothing written but output.json and report.md
before=$(cd "$g" && find . -type f -not -path './graph/runs/*' | sort | tr '\n' ' ')
malformed() {
  m_name=$1
  job "$2"
  node
  check "malformed job ($m_name): red, exit 1" sh -c "[ $code = 1 ]"
  check "malformed job ($m_name): output.json is red" status red
  check "malformed job ($m_name): report.md says why" test -s "$g/$step/report.md"
  m_files=$(cd "$g/$step" && ls | grep -v -e '^stdout.txt$' | tr '\n' ' ')
  check "malformed job ($m_name): nothing written but output.json and report.md" test "$m_files" = "input.json output.json report.md "
}
malformed "two kind" '{"kind":"commands","kind":"agent","dir":"app","run":"echo ran > app/ran.txt"}'
malformed "three ticket" '{"kind":"agent","dir":"app","ticket":"tickets/good.md","ticket":"tickets/good.md","ticket":"tickets/good.md","agent":"graph/tests/fake-agent.sh"}'
malformed "no dir" '{"kind":"commands","run":"echo ran > app/ran.txt"}'
malformed "dir that does not exist" '{"kind":"commands","dir":"nowhere","run":"echo ran > app/ran.txt"}'
malformed "unknown kind" '{"kind":"magic","dir":"app","run":"echo ran > app/ran.txt"}'
malformed "two run" '{"kind":"commands","dir":"app","run":"echo a","run":"echo b > app/ran.txt"}'
after=$(cd "$g" && find . -type f -not -path './graph/runs/*' | sort | tr '\n' ' ')
check "malformed jobs: nothing ran, the group folder is unchanged" test "$before" = "$after"
check "malformed jobs: no app/ran.txt" test ! -e "$g/app/ran.txt"

# the agent's other red cases
job "$(agent no-report)"
node
check "agent without report: red" status red
check "agent without report: the why says so" has "$g/$step/output.json" "agent left no report"

job "$(agent bad-report)"
node
check "report without headings: red" status red
check "report without headings: the why names the heading" has "$g/$step/output.json" "report.md lacks ## Checked"

# decisions of the group
check "default limit: node.sh says 180 seconds" has "$g/graph/node.sh" "180"
check "default limit: node.sh does not say 300" lacks "$g/graph/node.sh" "300"

# 7. the reviewer's verdict
job "$(agent block)"
node
check "Verdict: block is red, exit 1" sh -c "[ $code = 1 ]"
check "Verdict: block: the why says the reviewer blocked" has "$g/$step/output.json" "reviewer blocked"
check "Verdict: block: the why has the line after it" has "$g/$step/output.json" "zero price"

job "$(agent pass)"
node
check "Verdict: pass is green, exit 0" sh -c "[ $code = 0 ]"
check "Verdict: pass: output.json is green" status green

# the plug receives SKILL, MODEL and LAST
job "$(agent good '"skill":"worker","model":"m-1","last":"graph/runs/t/step-1"')"
node
check "the plug receives SKILL" has "$g/$step/report.md" "Skill: worker"
check "the plug receives MODEL" has "$g/$step/report.md" "Model: m-1"

# the answer is one line of valid JSON
. "$graph/lib.sh"
check "output.json is one valid JSON line" json_valid "$g/$step/output.json"

# other fields of the job are kept
job '{"kind":"commands","dir":"app","run":"true","step":3,"on_red":"stop"}'
node
check "other fields: ignored by the node" status green

if [ "$fails" -gt 0 ]; then
  echo "$fails failed"
  exit 1
fi
