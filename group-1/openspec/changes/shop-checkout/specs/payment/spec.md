## ADDED Requirements

### Requirement: Pay by card
The cashier SHALL be able to close a sale by card.

#### Scenario: Card payment
- **WHEN** the cashier closes a basket of 55.50 by card
- **THEN** the sale is closed and recorded as paid by card for 55.50

### Requirement: Pay by cash
The cashier SHALL be able to close a sale by cash, entering the amount the customer hands over, and the app SHALL show the change to give back.

#### Scenario: Cash with change
- **WHEN** the cashier closes a basket of 35.00 by cash and the customer hands over 40.00
- **THEN** the change reads 5.00 and the sale is recorded as paid in cash for 35.00

#### Scenario: Cash not enough
- **WHEN** the cashier closes a basket of 35.00 by cash and enters 30.00
- **THEN** the sale is not closed and the app says the amount is not enough

### Requirement: Receipt
Every closed sale SHALL get a receipt with a number, its lines, its total, its VAT total and its payment method.

#### Scenario: Receipt of a sale
- **WHEN** a sale is closed
- **THEN** a receipt is shown with a number no other receipt has, the lines, the total, the VAT total and the payment method
