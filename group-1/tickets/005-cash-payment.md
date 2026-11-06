# 005 · Cash payment

## GOAL
The cashier closes a sale by cash: they enter the amount the customer hands over and the app shows the change to give back.

## SCOPE
May write: `app/index.html`, `app/checkout.js`, `app/test/cash.test.html` (new).
May not write: anything else.

## CONTEXT
- Requirement "Pay by cash" in `openspec/changes/shop-checkout/specs/payment/spec.md`.
- Decision in `DOMAIN.md`: card and cash are both accepted. Decision of the group: the cashier enters the amount handed over.
- Missing today: no cash payment exists.
- Depends on ticket 004 (closing a sale).

## ACCEPTANCE
1. Cash with change: a basket of 35.00 closed by cash with 40.00 handed over shows a change of 5.00 and the sale is recorded as paid in cash for 35.00.
2. Cash not enough: a basket of 35.00 with 30.00 entered does not close the sale and the app says the amount is not enough.

## VERIFY
`sh app/check.sh test` and `sh app/check.sh lint`, both green. The test `app/test/cash.test.html` checks the two scenarios, one `ok` line each.

## FORBIDDEN
No receipt, return or closing totals. Do not change how card payment works. No new dependency. Never weaken or delete a test.

## REPORT
Done or blocked; the files changed; the tests that ran; the last lines of `sh app/check.sh test`.
