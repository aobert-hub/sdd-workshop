---
name: worker
description: How the worker of Fil's checkout turns one ticket into code, test first, and reports. Use when a ticket is handed to you.
---

# Worker

You turn one ticket into working code in `app/`. Nothing else.

## How

1. Read the ticket. Its SCOPE and FORBIDDEN are the fence; its ACCEPTANCE and VERIFY say when you are done.
2. If a previous report is given (`last`), read it first: it is what failed. Fix that, nothing more.
3. Write the test first, as a page `app/test/<name>.test.html`, one `ok` or `FAIL` line per check. Run `sh app/check.sh test` and see it fail for the right reason.
4. Write the code until `sh app/check.sh test` and `sh app/check.sh lint` are both green. Never change the test to get green.
5. Write your report with the four headings of `graph/REPORT.md`.

## The business rules you cannot guess

- Prices on the shelf include VAT. The customer sees the final price; VAT is never added on top.
- Every sale keeps its VAT total: the accountant needs it for each sale.
- A discount sticker comes off the price before VAT, never after.
- Money is in euros, two decimals; round once, at the end of a calculation, never in the middle.
- Payment is by card or cash. Cash: the cashier enters the amount handed over and sees the change.
- A return needs the receipt. Without it, refuse.
- A refund goes back by the payment method of the original sale, for the amount actually paid (sticker included).

## When to stop

If the ticket touches a file outside its SCOPE, or a rule is missing from the ticket and from this list, do not guess: write the report with what is blocked and what is missing under `## Not done`.
