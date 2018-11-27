+++
title = "Pickup Location"
description = "The place where the recipient can pick up their shipment."
weight = 1
+++

This is a place where the recipient can pick up their shipment. See the [pickup-dropoff-locations](/api/resources/pickup-dropoff-locations) resource page for more information.

## Attributes

| Attributes | Type                                                | Description                                                     | Required |
|------------|-----------------------------------------------------|-----------------------------------------------------------------|----------|
| code       | string                                              | A unique code identifying the location with the carrier.        | ✓        |
| address    | [address](/api/resources/common-objects/addresses/) | The address of the location the shipment can be picked up from. | ✓        |

## Example

```json
{
  "code": "205604",
  "address": {
    "street_1": "Baker Street",
    "street_2": "Marylebone",
    "street_number": 221,
    "street_number_suffix": "B",
    "postal_code": "NW1 6XE",
    "city": "London",
    "region_code": "ENG",
    "country_code": "GB",
    "first_name": "Sherlock",
    "last_name": "Holmes",
    "company": "Holmes Investigations",
    "phone_number": "+31 234 567 890"
  }
}
```
