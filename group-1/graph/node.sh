#!/bin/sh
# The node: one program for every step of the path. sh graph/node.sh <step-folder>
# The contract is graph/NODE.md. Run it from the group folder.
step=${1:-}
if [ -z "$step" ] || [ ! -f "$step/input.json" ]; then
  echo "node.sh: usage: sh graph/node.sh <step-folder> (with an input.json)" >&2
  exit 2
fi
here=$(cd "$(dirname "$0")" && pwd)
. "$here/lib.sh"

job=$step/input.json
started=$(date +%H:%M:%S)

# finish <green|red> <why>: writes output.json, prints the answer and exits with its colour.
finish() {
  fi_why=$(json_escape "$2")
  printf '{"status":"%s","why":"%s","started":"%s","ended":"%s"}\n' \
    "$1" "$fi_why" "$started" "$(date +%H:%M:%S)" > "$step/output.json"
  printf '%s: %s\n' "$1" "$2"
  if [ "$1" = green ]; then exit 0; fi
  exit 1
}

# reject <why>: a bad job: report.md says why, nothing runs.
reject() {
  printf '# Bad job\n\n%s\n' "$1" > "$step/report.md"
  finish red "bad job: $1, see $step/report.md"
}

# count <key>: how many times the key appears in the raw job
count() { grep -o "\"$1\"[[:space:]]*:" "$job" | wc -l | tr -d ' '; }

kind=$(json_get "$job" kind)
dir=$(json_get "$job" dir)
if [ "$(count kind)" != 1 ]; then reject '"kind" must appear exactly once'; fi
case $kind in
  commands) if [ "$(count run)" != 1 ]; then reject '"run" must appear exactly once'; fi ;;
  agent) if [ "$(count ticket)" != 1 ]; then reject '"ticket" must appear exactly once'; fi ;;
  *) reject "unknown kind \"$kind\": it is commands or agent" ;;
esac
if [ -z "$dir" ]; then reject '"dir" is missing'; fi
if [ ! -d "$dir" ]; then reject "dir $dir does not exist"; fi

if [ "$kind" = commands ]; then
  run=$(json_get "$job" run)
  code=0
  sh -c "$run" > "$step/report.md" 2>&1 < /dev/null || code=$?
  if [ "$code" = 0 ]; then finish green "commands passed, output in $step/report.md"; fi
  finish red "commands failed (exit $code), see $step/report.md"
fi

ticket=$(json_get "$job" ticket)
agent=$(json_get "$job" agent)
limit=$(json_get "$job" limit)
skill=$(json_get "$job" skill)
model=$(json_get "$job" model)
last=$(json_get "$job" last)
[ -n "$agent" ] || agent=graph/copilot.sh
[ -n "$limit" ] || limit=180
if [ -n "$skill" ]; then export SKILL=$skill; fi
if [ -n "$model" ]; then export MODEL=$model; fi
if [ -n "$last" ]; then export LAST=$last; fi

prefix=$(git rev-parse --show-prefix 2> /dev/null || true)
before=$(git status --porcelain -uall 2> /dev/null | sort)

code=0
run_limited "$limit" "$(pwd)" "$step/agent.log" \
  "sh '$agent' '$ticket' '$dir' '$step/report.md'" || code=$?

if [ "$code" = 124 ]; then finish red "agent cut after $limit s"; fi
if [ "$code" != 0 ]; then finish red "agent failed (exit $code), see $step/agent.log"; fi
if [ ! -f "$step/report.md" ]; then finish red "agent left no report"; fi
for heading in Ticket Changed Checked 'Not done'; do
  if ! grep -q "^## $heading" "$step/report.md"; then finish red "report.md lacks ## $heading"; fi
done

# Paths that changed during the run, as the group sees them (git prints them from the root).
after=$(git status --porcelain -uall 2> /dev/null | sort)
outside=$(
  printf '%s\n' "$after" | while IFS= read -r line; do
    [ -n "$line" ] || continue
    if printf '%s\n' "$before" | grep -qxF -- "$line"; then continue; fi
    p=${line#???}
    p=${p#"$prefix"}
    case $p in
      "$dir"/* | graph/runs/*) ;;
      *) printf '%s ' "$p" ;;
    esac
  done
)
if [ -n "$outside" ]; then finish red "agent touched outside $dir: ${outside% }"; fi

if grep -q '^Verdict: block' "$step/report.md"; then
  why=$(awk 'f { print; exit } /^Verdict: block/ { f = 1 }' "$step/report.md")
  finish red "reviewer blocked: $why"
fi
finish green "agent finished, report.md written"
