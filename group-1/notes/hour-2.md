# Hour 2 · The node

- **Decided:** group 1 decided that an agent may run 3 minutes (180 s) before the node cuts it; that it may touch `app` only; and that an agent that ends without a report is red. Reason not given for any. The group signed ticket 000 and, after reading the three limits in `graph/node.sh` and the cases in the test, confirmed them ("ok").
- **Done:** a worker wrote `graph/tests/test-node.sh` first, red (58 failures), then `graph/node.sh` until it was green: 63 `ok` checks, no `FAIL`, the test unchanged. The group ran the test and read the result. The first four launches of the worker failed because the Copilot CLI was missing, then not logged in; the fifth ran.
- **Pending:** the node has only met the fake agent, never a real model. The first real agent comes in hour 3, when the path hands ticket 001 to a worker. The worker went without a skill this hour; the worker skill is hour 3.
