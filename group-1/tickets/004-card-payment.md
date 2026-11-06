# 004 · Card payment

## GOAL
The cashier closes a sale by card and the sale is recorded as paid by card.

## SCOPE
May write: `app/index.html`, `app/checkout.js`, `app/test/card.test.html` (new).
May not write: anything else.

## CONTEXT
- Requirement "Pay by card" in `openspec/changes/shop-checkout/specs/payment/spec.md`.
- Decision in `DOMAIN.md`: card and cash are both accepted.
- Missing today: a basket cannot be closed.
- Depends on ticket 001.

## ACCEPTANCE
1. Card payment: closing a basket of 55.50 by card closes the sale, recorded as paid by card for 55.50.

## VERIFY
`sh app/check.sh test` and `sh app/check.sh lint`, both green. The test `app/test/card.test.html` checks the scenario, one `ok` line.

## FORBIDDEN
No cash, receipt, return or closing totals. No new dependency. Never weaken or delete a test.

## REPORT
Done or blocked; the files changed; the tests that ran; the last lines of `sh app/check.sh test`.
