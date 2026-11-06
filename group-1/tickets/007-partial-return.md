# 007 · Partial return and refund

## GOAL
A customer returns part of a sale and the refund is exactly what was paid for those items, by the payment method of the original sale. Today this is a paper note, and 6 of last month's 41 returns were refunded with the wrong amount.

## SCOPE
May write: `app/index.html`, `app/checkout.js`, `app/test/return.test.html` (new).
May not write: anything else.

## CONTEXT
- Requirements "Partial return" and "Refund by the original payment method" in `openspec/changes/shop-checkout/specs/returns/spec.md`.
- Decisions: the refund is the amount paid for the items, discount included; it goes back by the payment method of the original sale.
- Missing today: no return exists.
- Depends on ticket 006 (the receipt).

## ACCEPTANCE
1. Return one of two shirts: a sale of two shirts at 35.00 each after the sticker, one returned, refunds 35.00.
2. Return more than was bought: returning two shirts of a sale that had one is refused and the app says so.
3. Return of a cash sale: the refund is recorded as paid in cash.
4. Return of a card sale: the refund is recorded as paid to the card.

## VERIFY
`sh app/check.sh test` and `sh app/check.sh lint`, both green. The test `app/test/return.test.html` checks the four scenarios, one `ok` line each.

## FORBIDDEN
No receipt check (that is ticket 008) and no closing totals. Do not change how a sale is closed. No new dependency. Never weaken or delete a test.

## REPORT
Done or blocked; the files changed; the tests that ran; the last lines of `sh app/check.sh test`.
