# 001 · Basket total

## GOAL
A cashier adds products to a basket and sees the basket total, in euros, with VAT included. Today the page only shows a title.

## SCOPE
May write: `app/index.html`, `app/checkout.js` (new), `app/test/basket.test.html` (new).
May not write: anything else, in particular `openspec/`, `graph/` and other tests.

## CONTEXT
- Requirement "Basket total" in `openspec/changes/shop-checkout/specs/basket/spec.md`.
- Decision in `DOMAIN.md`: prices include VAT.
- Missing today: `app/index.html` has no basket and no `app/checkout.js` exists.
- Depends on nothing. Keep the page title and the heading "Shop checkout".

## ACCEPTANCE
1. Add two products: a product at 20.00 and a product at 35.50 give a basket total of 55.50.
2. Empty basket: the basket total reads 0.00.

## VERIFY
`sh app/check.sh test` and `sh app/check.sh lint`, both green. The test `app/test/basket.test.html` checks the two scenarios above, one `ok` line each.

## FORBIDDEN
No sticker, VAT amounts, payment, receipt, return or closing. No new dependency. Never weaken or delete a test.

## REPORT
Done or blocked; the files changed; the tests that ran; the last lines of `sh app/check.sh test`.
