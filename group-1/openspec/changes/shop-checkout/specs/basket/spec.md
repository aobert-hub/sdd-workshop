## ADDED Requirements

### Requirement: Basket total
The app SHALL let the cashier add products to a basket and SHALL show the basket total, with VAT included, in euros.

#### Scenario: Add two products
- **WHEN** the cashier adds a product at 20.00 and a product at 35.50
- **THEN** the basket total reads 55.50

#### Scenario: Empty basket
- **WHEN** no product has been added
- **THEN** the basket total reads 0.00

### Requirement: Sticker discount
A product MAY carry a discount sticker, a percentage. The discount SHALL come off the price before VAT, never after, and the price on screen SHALL include VAT.

#### Scenario: Shirt with a 30 % sticker
- **WHEN** the cashier adds a shirt at 50.00 with a 30 % sticker
- **THEN** the line reads 35.00 and the basket total reads 35.00

#### Scenario: Product without sticker
- **WHEN** the cashier adds a product at 20.00 with no sticker
- **THEN** the line reads 20.00

### Requirement: VAT total of a sale
Each product SHALL carry its own VAT rate. The app SHALL work out the VAT of every line from its discounted price and its own rate, and the VAT total of the sale SHALL be the sum of the lines, so the accountant can read it.

#### Scenario: VAT of a discounted line
- **WHEN** a basket has one line of 35.00 with VAT included, on a product with a VAT rate of 20 %
- **THEN** the VAT total of the sale reads 5.83 and the total without VAT reads 29.17

#### Scenario: Two products with different rates
- **WHEN** a basket has a line of 20.00 on a product at 20 % and a line of 11.00 on a product at 10 %
- **THEN** the VAT total of the sale reads 4.33
