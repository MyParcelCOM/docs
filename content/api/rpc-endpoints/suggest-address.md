+++
title = "Suggest address"
description = "Retrieve address suggestions"
weight = 7
+++

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/RPC/post_suggest_address)

To make sure the correct address is being used for a shipment, the `suggest-address` endpoint allows you to verify and possibly suggest the address of a shipment. This endpoints differs a bit from the other endpoints, since it is an [RPC endpoint](/api/rpc-endpoints).

{{% notice info %}}
For now, the only supported country to suggest addresses for is the Netherlands (NL).
{{% /notice %}}

## Request

The attributes that are required for an address suggestion differ per country. The endpoint will respond with a `422 Unprocessable Entity` when not all required attributes are supplied for the country and will list all required attributes.

**Required Scope:** `addresses.suggest`

Address suggestions can be queried based on postal code or combination of city and name of a street. Both use cases, however, require country code.

The following table displays required attributes and their types for postal code-based address suggestion:

| Attribute                     | Type    | Required |
|-------------------------------|---------|----------|
| `country_code`                | string  | ✓        |
| `postal_code`                 | string  | ✓        |
| `street_number`               | integer | ✓        |
| `street_number_suffix`        | string  |          |


Moreover, the table below lists the required attributes and their types for city and street name-based address suggestion:

| Attribute                     | Type    | Required |
|-------------------------------|---------|----------|
| `country_code`                | string  | ✓        |
| `city`                        | string  | ✓        |
| `street_1`                    | string  | ✓        |
| `street_number`               | integer | ✓        |
| `street_number_suffix`        | string  |          |


{{% notice info %}}
Note that the attribute `street_1` represents name of a street.
{{% /notice %}}

```http
POST /suggest-address HTTP/1.1
Example: https://sandbox-api.myparcel.com/suggest-address
```

```json
{
  "data": {
    "country_code": "NL",
    "postal_code": "2131 BC",
    "street_number": 679,
    "street_number_suffix": "A1"
  }
}
```

## Response

The API will try to suggest all possible matches using the data provided.

| Attribute              | Type    | Required |
|------------------------|---------|----------|
| `country_code`         | string  | ✓        |
| `postal_code`          | string  |          |
| `street_number`        | integer |          |
| `street_number_suffix` | string  |          |
| `city`                 | string  |          |
| `street_1`             | string  |          |
| `street_2`             | string  |          |

```json
{
  "data": [
    {
      "country_code": "NL",
      "postal_code": "2131 BC",
      "street_number": 679,
      "street_number_suffix": "A1",
      "city": "Hoofddorp",
      "street_1": "Hoofdweg",
      "street_2": "Haarlemmermeer"
    }
  ]
}
```

When no address can be found to suggest, the data array will be empty.
