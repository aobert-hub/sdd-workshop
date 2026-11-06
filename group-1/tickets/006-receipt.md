# 006 · Receipt

## GOAL
Every closed sale gets a receipt with its own number, so the customer can bring it back for a return.

## SCOPE
May write: `app/index.html`, `app/checkout.js`, `app/test/receipt.test.html` (new).
May not write: anything else.

## CONTEXT
- Requirement "Receipt" in `openspec/changes/shop-checkout/specs/payment/spec.md`.
- Decision in `DOMAIN.md`: returns only with the receipt, so the receipt number is what a return starts from.
- Missing today: a closed sale leaves no receipt.
- Depends on tickets 003, 004 and 005 (VAT total and both payment methods).

## ACCEPTANCE
1. Receipt of a sale: when a sale is closed, a receipt is shown with a number no other receipt has, the lines, the total, the VAT total and the payment method.

## VERIFY
`sh app/check.sh test` and `sh app/check.sh lint`, both green. The test `app/test/receipt.test.html` closes two sales and checks the receipt content and that the two numbers differ, one `ok` line each.

## FORBIDDEN
No return and no closing totals. Do not change the amounts of a sale. No new dependency. Never weaken or delete a test.

## REPORT
Done or blocked; the files changed; the tests that ran; the last lines of `sh app/check.sh test`.
