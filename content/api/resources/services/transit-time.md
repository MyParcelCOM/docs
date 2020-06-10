+++
title = "Transit time"
description = "The time frame in which the shipment will be delivered with a service."
weight = 2
+++

The time frame in which the shipment will be delivered with a service.

## Attributes

Attribute      | Type       | Description                                                          | Required   
---------------|------------|----------------------------------------------------------------------|------------
min            | integer    | The minimum amount of days the shipment is in transit with a service | 
max            | integer    | The maximum amount of days the shipment is in transit with a service | 

## Example

```json
{
  "min": 3,
  "max": 4
}
```
