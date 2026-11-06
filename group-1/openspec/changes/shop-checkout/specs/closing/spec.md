## ADDED Requirements

### Requirement: Closing totals
At closing time the app SHALL show the totals the drawer and the card terminal must match: the cash taken, the cash refunded, the cash that must be in the drawer (cash taken minus cash refunded), the card taken, the card refunded, the card total (card taken minus card refunded), and the VAT total of the day.

#### Scenario: A day with sales and returns
- **WHEN** the day had one cash sale of 35.00, one card sale of 55.50, a cash refund of 35.00 and a card refund of 20.00
- **THEN** the closing shows cash taken 35.00, cash refunded 35.00, cash in the drawer 0.00, card taken 55.50, card refunded 20.00, card total 35.50

#### Scenario: A day with no sale
- **WHEN** nothing was sold
- **THEN** every total of the closing reads 0.00
