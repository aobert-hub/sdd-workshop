# 000 · The node

Signed: group 1, 10:58

## GOAL

One program, `graph/node.sh`, runs any step of the graph from a job written in a folder:
commands (grey) or an agent with a ticket (blue). It always answers green or red with the
reason, so nobody has to read a log to know what happened.

## SCOPE

May write: `graph/node.sh` and `graph/tests/test-node.sh`.
May not write: `graph/lib.sh`, `graph/copilot.sh`, `graph/tests/fake-agent.sh`,
`graph/REPORT.md`, `graph/NODE.md`, `app/`, `tickets/`, `openspec/`.

## CONTEXT

The contract is `graph/NODE.md`, and the OpenSpec change `openspec/changes/generic-node/`.
Proof it is missing: `sh graph/node.sh graph/runs/try/step-1` prints
`node.sh: not written yet, see graph/NODE.md` and exits 2, and there is no
`graph/tests/test-node.sh`. Given and ready: `graph/lib.sh` (`json_get`, `json_valid`,
`json_escape`, `run_limited`), `graph/tests/fake-agent.sh` (the agent of the tests) and
`graph/REPORT.md` (the four headings of an agent's report).

## ACCEPTANCE

1. Commands that pass: green, exit 0, and `report.md` has their output.
2. Commands that fail: red, exit 1, and the why names `report.md`.
3. The agent finishes with a four-heading report: green.
4. The agent fails, or runs past its `limit` (`"limit":2`, ticket `slow.md`): red, and the why says which.
5. The agent writes outside `dir`: red, and the why names the path.
6. A malformed job (two `kind`, three `ticket`, no `dir`, an unknown `kind`): red, nothing run, nothing written but `output.json` and `report.md`.
7. `Verdict: block` in the report is red; `Verdict: pass` is green.

The group's decisions, in force in every case above:
8. The default limit for an agent is 180 seconds (3 minutes): when `limit` is absent the node uses 180, not 300.
9. The agent may touch `app` only: a real job has `"dir":"app"`, and anything it changes in `tickets/` or elsewhere is red.
10. An agent that ends without `report.md` is red, and the why says so.

## VERIFY

`sh graph/tests/test-node.sh`: one `  ok` line per check, no `  FAIL`, exit 0. It builds a
throwaway group folder and uses `graph/tests/fake-agent.sh`: no model is called.

## FORBIDDEN

Calling a real model from the test. Editing `fake-agent.sh` or `lib.sh` to make a case
pass. A node file per step, or a second program for agents: one node.

## REPORT

Done or blocked, the files you changed, and the full output of `sh graph/tests/test-node.sh`.
