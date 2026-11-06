# 009 · Closing totals

## GOAL
At closing time the screen shows the totals the drawer and the card terminal must match, so Claire no longer spends Sunday morning finding out why they differ.

## SCOPE
May write: `app/index.html`, `app/checkout.js`, `app/test/closing.test.html` (new).
May not write: anything else.

## CONTEXT
- Requirement "Closing totals" in `openspec/changes/shop-checkout/specs/closing/spec.md`.
- Goal in `DOMAIN.md`: the drawer matches the screen at closing time. Decision of the group: refunds go back by the original payment method, so cash and card are counted separately.
- Missing today: no totals of the day.
- Depends on tickets 003, 005 and 007.

## ACCEPTANCE
1. A day with sales and returns: one cash sale of 35.00, one card sale of 55.50, a cash refund of 35.00 and a card refund of 20.00 show cash taken 35.00, cash refunded 35.00, cash in the drawer 0.00, card taken 55.50, card refunded 20.00, card total 35.50.
2. A day with no sale: every total of the closing reads 0.00.

## VERIFY
`sh app/check.sh test` and `sh app/check.sh lint`, both green. The test `app/test/closing.test.html` checks the two scenarios, one `ok` line each; the closing also shows the VAT total of the day, which is the sum of the sales' VAT totals.

## FORBIDDEN
No change to sales, receipts or returns. No new dependency. Never weaken or delete a test.

## REPORT
Done or blocked; the files changed; the tests that ran; the last lines of `sh app/check.sh test`.
