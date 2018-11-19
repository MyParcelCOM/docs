+++
title = "Prices"
description = "Amount and currency representing a price."
+++

Technically, a price is not a resource, but it is often used withing our API and follows the
following structure:

| Attribute | Type    | Description                                                                 | Required |
|-----------|---------|-----------------------------------------------------------------------------|----------|
| amount    | integer | The price in cents/pence.                                                   | ✓        |
| currency  | string  | Currency code in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217) format. | ✓        |

## Example

```json
{
  "amount": 150,
  "currency": "EUR"
}
```
