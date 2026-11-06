## Context

The client's brief and the group's decisions are in `DOMAIN.md`. The app is the page that `STANDING.md` describes.

## Goals / Non-Goals

**Goals:** a cashier closes a basket with a sticker and a partial return in under a minute; the drawer matches the screen at closing.

**Non-Goals:** returns without a receipt; payment methods other than card and cash.

## Decisions

- Payments: card and cash (decision 1 of `DOMAIN.md`).
- Prices on screen include VAT; each product carries its own VAT rate, and the VAT total of each sale is also kept for the accountant (decision 2 and the group's answer on rates).
- A sticker discount comes off the price before VAT, never after.
- A return needs the receipt of the sale (decision 3).
- Plumbing: the app runs in a browser and nowhere else: HTML, CSS and JavaScript exactly as a browser loads them.

## Risks / Trade-offs

None identified.
