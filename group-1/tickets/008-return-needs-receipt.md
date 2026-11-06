# 008 · A return only with the receipt

## GOAL
A return starts from the receipt number and is refused without one, so Fil never refunds clothes that were not bought in its shops.

## SCOPE
May write: `app/index.html`, `app/checkout.js`, `app/test/receipt-return.test.html` (new).
May not write: anything else.

## CONTEXT
- Requirement "Returns only with the receipt" in `openspec/changes/shop-checkout/specs/returns/spec.md`.
- Decision in `DOMAIN.md`: returns only with the receipt (1 return in 5 comes without one; two last year were for clothes bought elsewhere).
- Missing today: a return can start without any receipt.
- Depends on tickets 006 and 007.

## ACCEPTANCE
1. Known receipt: a return started with the number of an existing receipt shows the lines of that sale to choose from.
2. No receipt: a return started without a receipt number, or with a number no sale has, is refused and the app says a receipt is required.

## VERIFY
`sh app/check.sh test` and `sh app/check.sh lint`, both green. The test `app/test/receipt-return.test.html` checks the two scenarios, one `ok` line each.

## FORBIDDEN
No way to return without a receipt, not even a hidden one. No closing totals. No new dependency. Never weaken or delete a test.

## REPORT
Done or blocked; the files changed; the tests that ran; the last lines of `sh app/check.sh test`.
