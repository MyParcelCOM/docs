+++
title = "Address rules"
description = "A list of requirements for matching an address."
weight = 5
+++

Address rules are objects that contain a list of requirements for matching an address in order to be able to use this service.<br>
The address rules are used for the `regions_from` and `regions_to` attributes on the `service` resource.
They determine where a service can ship to and from, so if a service for instance can ship to England the value of the `country_code` will be `GB`.

## Attributes

Attribute      | Type       | Description                                                          | Required   
---------------|------------|----------------------------------------------------------------------|------------
country_code   | string    | The country codes to match in order to be accepted | ✓
region_code    | string    | The region codes to match in order to be accepted | 

## Example

```json
{
   "country_code": "GB",
   "region_code": "ENG"
}
```
