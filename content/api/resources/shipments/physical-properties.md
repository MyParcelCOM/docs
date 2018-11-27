+++
title = "Physical Properties"
description = "Weight and dimentions of the shipment."
weight = 2
+++

The physical properties for the shipment.

## Attributes

| Attribute | Type    | Description                                 | Required |
|-----------|---------|---------------------------------------------|----------|
| weight    | integer | The weight of the shipment in grams.        | ✓        |
| width     | integer | The width of the shipment in millimeters.   |          |
| height    | integer | The height of the shipment in millimeters.  |          |
| length    | integer | The length of the shipment in millimeters.  |          |
| volume    | integer | The volume of the shipment in liters. (dm3) |          |

## Example

```json
{
  "weight": 5000,
  "width": 300,
  "height": 150,
  "length": 500,
  "volume": 22.5
}
```
