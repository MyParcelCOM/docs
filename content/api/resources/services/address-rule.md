+++
title = "Address rule"
description = "A list of requirements for matching an address."
weight = 5
+++

These are objects that contain a list of requirements for matching an address in order to be able to use this service.<br>
They all contain a valid regular expression. For a service that can ship to The Netherlands and England for instance there will be a country_code of `NL|GB`.
These are used for the `regions_from` and `regions_to` of the `service` resource.

## Optional attributes

Attribute      | Type       | Description                                                          | Required   
---------------|------------|----------------------------------------------------------------------|------------
country_code   | regular expression    | The country codes to match in order to be accepted | ✓
region_code    | regular expression    | The region codes to match in order to be accepted | 
postal_code    | regular expression    | The postal codes to match in order to be accepted | 

## Example

```json
{
   "country_code": "GB",
   "region_code": "ENG",
   "postal_code": "NW1.*"
}
```
