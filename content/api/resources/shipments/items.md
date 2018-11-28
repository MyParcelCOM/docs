+++
title = "Items"
description = "The contents of a shipment."
weight = 3
+++

An array of items describing the contents of the shipment.

## Attributes

| Attributes          | Type                                           | Description                                                                                | Required                             |
|---------------------|------------------------------------------------|--------------------------------------------------------------------------------------------|--------------------------------------|
| description         | string                                         | A description of the item.                                                                 | ✓                                    |
| quantity            | integer                                        | The number of this type of item.                                                           | ✓                                    |
| item_value          | [price](/api/resources/common-objects/prices/) | The value of an individual item.                                                           | Required for international shipments |
| nett_weight         | integer                                        | The nett weight of the item in grams.                                                      | Required for international shipments |
| origin_country_code | string                                         | The country code in [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) format for the country where the item was produced. | Required for international shipments |
| hs_code             | string                                         | [Harmonized System code](https://www.tariffnumber.com/) used by customs.                   | Required for international shipments |
| sku                 | string                                         | Internal Stock Keeping Unit.                                                               |                                      |

## Example

```json
[
  {
    "description": "OnePlus X",
    "quantity": 2,
    "item_value": {
      "amount": 995,
      "currency": "EUR"
    },
    "nett_weight": 135,
    "origin_country_code": "CN",
    "hs_code": "8517.12.00",
    "sku": "5011100385"
  }
]
```
