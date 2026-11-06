# 002 · Sticker discount

## GOAL
A product can carry a discount sticker, a percentage, and the cashier no longer works it out on a calculator: the discount comes off the price before VAT.

## SCOPE
May write: `app/index.html`, `app/checkout.js`, `app/test/sticker.test.html` (new).
May not write: anything else.

## CONTEXT
- Requirement "Sticker discount" in `openspec/changes/shop-checkout/specs/basket/spec.md`.
- Decisions in `DOMAIN.md`: prices include VAT; a sticker comes off before VAT, never after. The sticker is a percentage on one product.
- Missing today: no product has a sticker.
- Depends on ticket 001 (the basket).

## ACCEPTANCE
1. Shirt with a 30 % sticker: a shirt at 50.00 with a 30 % sticker gives a line of 35.00 and a basket total of 35.00.
2. Product without sticker: a product at 20.00 with no sticker gives a line of 20.00.

## VERIFY
`sh app/check.sh test` and `sh app/check.sh lint`, both green. The test `app/test/sticker.test.html` checks the two scenarios, one `ok` line each.

## FORBIDDEN
No VAT amounts, payment, receipt, return or closing. No change to the basket total of products without sticker. No new dependency. Never weaken or delete a test.

## REPORT
Done or blocked; the files changed; the tests that ran; the last lines of `sh app/check.sh test`.
