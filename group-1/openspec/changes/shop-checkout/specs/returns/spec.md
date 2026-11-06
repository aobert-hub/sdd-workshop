## ADDED Requirements

### Requirement: Partial return
A customer SHALL be able to return part of a sale. The refund SHALL be the amount that was paid for the returned items, discount included.

#### Scenario: Return one of two shirts
- **WHEN** a sale had two shirts at 35.00 each after the sticker, and the cashier returns one
- **THEN** the refund reads 35.00

#### Scenario: Return more than was bought
- **WHEN** the cashier returns two shirts of a sale that had one
- **THEN** the return is refused and the app says so

### Requirement: Refund by the original payment method
A refund SHALL go back by the payment method of the original sale: in cash for a cash sale, to the card for a card sale.

#### Scenario: Return of a cash sale
- **WHEN** the cashier returns an item of a sale paid in cash
- **THEN** the refund is recorded as paid in cash

#### Scenario: Return of a card sale
- **WHEN** the cashier returns an item of a sale paid by card
- **THEN** the refund is recorded as paid to the card

### Requirement: Returns only with the receipt
A return SHALL be accepted only with the receipt number of the sale. A return without a receipt SHALL be refused.

#### Scenario: Known receipt
- **WHEN** the cashier starts a return with the number of an existing receipt
- **THEN** the lines of that sale are shown to choose from

#### Scenario: No receipt
- **WHEN** the cashier starts a return without a receipt number, or with a number no sale has
- **THEN** the return is refused and the app says a receipt is required
