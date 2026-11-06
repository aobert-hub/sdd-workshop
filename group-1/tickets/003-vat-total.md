# 003 · VAT total of a sale

## GOAL
Every sale shows its VAT total, worked out line by line from each product's own VAT rate, so Élodie can file the quarter's VAT.

## SCOPE
May write: `app/index.html`, `app/checkout.js`, `app/test/vat.test.html` (new).
May not write: anything else.

## CONTEXT
- Requirement "VAT total of a sale" in `openspec/changes/shop-checkout/specs/basket/spec.md`.
- Decisions in `DOMAIN.md`: prices include VAT. Decision of the group: the VAT rate is defined on each product.
- Missing today: no product has a rate and no VAT is shown.
- Depends on tickets 001 and 002. The VAT is worked out from the discounted price.

## ACCEPTANCE
1. VAT of a discounted line: one line of 35.00 on a product at 20 % gives a VAT total of 5.83 and a total without VAT of 29.17.
2. Two products with different rates: a line of 20.00 at 20 % and a line of 11.00 at 10 % give a VAT total of 4.33.

## VERIFY
`sh app/check.sh test` and `sh app/check.sh lint`, both green. The test `app/test/vat.test.html` checks the two scenarios, one `ok` line each.

## FORBIDDEN
No payment, receipt, return or closing. No fixed VAT rate in the code: the rate comes from the product. No new dependency. Never weaken or delete a test.

## REPORT
Done or blocked; the files changed; the tests that ran; the last lines of `sh app/check.sh test`.
