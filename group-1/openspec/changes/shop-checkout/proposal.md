## Why

Fil, three small clothing shops in Lyon, runs on twelve-year-old tills the vendor no longer supports. Discounts are worked out on a calculator, returns are written on paper notes (6 of last month's 41 were refunded with the wrong amount), and at closing the drawer does not match the sales. Fil needs a checkout on a tablet at every counter before the January sales.

## What Changes

- A cashier adds products to a basket and sees the total, with VAT included.
- A discount sticker comes off a product's price before VAT.
- Every sale records its VAT total, for the accountant.
- A sale is paid by card or by cash.
- A closed sale gets a receipt.
- A customer can return part of a sale, only with the receipt; the refund is the amount that was paid for those items, by the payment method of the original sale.
- At closing, the screen shows the totals the drawer and the card terminal must match.

Out: returns without a receipt, other payment methods, anything the group did not ask for.

## Capabilities

### New Capabilities
- `basket`: products, sticker discount, total with VAT included, VAT total of the sale.
- `payment`: closing a sale by card or by cash, and the receipt.
- `returns`: partial return of a sale, only with its receipt.
- `closing`: the totals of the day the drawer must match.

### Modified Capabilities
None.

## Impact

`app/` only: the page, its script and its tests. Decisions behind it are in `DOMAIN.md` (payment: card and cash; VAT included; returns only with the receipt).
