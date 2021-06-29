+++
title = "Address rules"
description = "A list of requirements for matching an address."
weight = 1
+++

Address rules are objects that contain a list of requirements for matching an address in order to be able to use this service.
The address rules are used for the `regions_from` and `regions_to` attributes on the `service` resource.
They determine where a service can ship to and from, so if a service for instance can ship to the United Kingdom the value of the `country_code` will be `GB`.

## Attributes

Attribute     | Type   | Description                                                                          | Required
--------------|--------|--------------------------------------------------------------------------------------|---------
country_code  | string | The country code to match in order to be accepted                                    | ✓
~~region_code~~ | ~~string~~ | ~~The region code to match in order to be accepted~~                           | **Deprecated**. Everything is based on the `postal_code` regular expression.
postal_code   | string | The postal codes to match in order to be accepted, presented as a regular expression |

## Example

```json
{
   "country_code": "GB",
   "postal_code": "^((GY|JE).*|TR2[1-5]) ?[0-9]{1}[A-Z]{2}$"
}
```

{{% notice info %}}
The regular expression in the example will match all postal codes for the Channel Islands region, by matching UK postal codes starting with GY or JE or TR21 until TR25.
{{% /notice %}}

{{% notice warning %}}
Instead of fetching all services and using local functions to filter on the `postal_code` regex, you should use the address filters when calling the [GET /services](https://api-specification.myparcel.com/#tag/Services/paths/~1services/get) endpoint.
{{% /notice %}}
