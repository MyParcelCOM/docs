+++
title = "Service Rates"
description = "Service rates determine the price and limitations for a given service."
weight = 20
+++

Service rates determine the price and maximum dimensions for a given service.
A user has access to service rates that are related to the contracts the user has access to.

## Attributes

{{< icon fa-file-text-o >}}[API specification](https://api-specification.myparcel.com/#tag/Shops)

Attribute  |  Type   | Description                                              | Required
---------- | ------- | ------------------------------------------------------------------------------------------- | --------
weight_min | integer | The minimum weight in grams a shipment should have for this service rate to apply to it.     | ✓
weight_max | integer | The maximum weight in grams a shipment should have for this service rate to apply to it.     | ✓
length_max | integer | The maximum length of the shipment in mm.                                                    |
width_max  | integer | The maximum width of the shipment in mm.                                                     |
height_max | integer | The maximum height of the shipment in mm.                                                    |
volume_max | float   | The maximum volume of the shipment in liters.                                                |
price      | [price](/api/resources/common-objects/prices/) | The price of the service in cents (where applicable). |
step_size  | integer | When the service supports sending shipments that exceed the max weight, this indicates in what weight steps (in grams) the increments are calculated with. |
step_price | [price](/api/resources/common-objects/prices/) | The price per increment of `step_size`. |

Relationship    | Type                                                                                                | Description                          | Required
--------------- | --------------------------------------------------------------------------------------------------- | ------------------------------------ | --------
contract        | [contracts](/api/resources/contracts)                  | The contract this rate belongs to.    | ✓
service         | [services](/api/resources/services/)                     | The service this rate belongs to.     | ✓
service_options | [service-options](/api/resources/service-options/) | The service service options that are available for this contract and service combination. The price and whether it is always included are available in the meta. |

## Endpoints

{{%expand "GET /service-rates" %}}
Retrieving a list of all the service rates available to the current user.

**Scope**  
Any of the following scopes:

- `organizations.manage`

**Request parameters**  
For more specific requests, the following parameters can be included as query parameters.

Parameter                   | Type    | Description
--------------------------- | ------- | ------------
filter[weight]              | integer | Weight in grams to filter on. This will only return service-rates for which the following is true `weight_min ≤ filter[weight] ≤ weight_max`.
filter[volumetric_weight]   | integer | Volumetric weight in grams to filter on. Use together with weight filter for the most accurate results. This filter uses the same logic as the weight filter, but uses the higher value between the two sent filters to determine what weight range should be returned (only applies to service-rates for services that use [volumetric_weight](/api/resources/shipments/physical-properties/volumetric-weight)).
filter[service]             | string  | Comma separated string of service ids to filter the service rates by.
filter[contract]            | string  | Comma separated string of contract ids to filter the service rates by.
filter[has_active_contract] | boolean | A `true` value will filter services-rates that have **active** [contract](/api/resources/contracts) associations. `false` will result in service-rates that do **not** have active contract associations. To retrieve **all** services regardless of contract, omit this filter.

**Request**
```http
GET /service-rates HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/service-rates
```

**Response**
```json
{
  "data": [
    {
      "type": "service-rates",
      "id": "09a8f83a-bc8d-4598-81e6-ebf9d59a186a",
      "attributes": {
        "weight_min": 0,
        "weight_max": 2000,
        "length_max": 300,
        "width_max": 200,
        "height_max": 200,
        "volume_max": 12,
        "price": {
          "amount": 995,
          "currency": "EUR"
        },
        "step_price": {
          "amount": 995,
          "currency": "EUR"
        },
        "step_size": 100
      },
      "relationships": {
        "contract": {
          "data": {
            "type": "contracts",
            "id": "2cb32706-5762-4b96-9212-327e6afaeeff"
          },
          "links": {
            "related": "https://sandbox-api.myparcel.com/contracts/2cb32706-5762-4b96-9212-327e6afaeeff"
          }
        },
        "service": {
          "data": {
            "type": "services",
            "id": "175a235f-aff5-4e44-87b5-3657b75c1deb"
          },
          "links": {
            "related": "https://sandbox-api.myparcel.com/services/175a235f-aff5-4e44-87b5-3657b75c1deb"
          }
        },
        "service_options": {
          "data": [
            {
              "type": "service-options",
              "id": "4c675b1a-516c-4410-abff-d237fd45bcd0",
              "meta": {
                "price": {
                  "amount": 995,
                  "currency": "EUR"
                },
                "included": true
              }
            }
          ]
        }
      },
      "links": {
        "self": "https://sandbox-api.myparcel.com/service-rates/c9ce29a4-6325-11e7-907b-a6006ad3dba0"
      }
    }
  ],
  "meta": {
    "total_pages": 13,
    "total_records": 373
  },
  "links": {
    "self": "https://sandbox-api.myparcel.com/service-rates?page[number]=3&page[size]=30",
    "first": "https://sandbox-api.myparcel.com/service-rates?page[number]=1&page[size]=30",
    "prev": "https://sandbox-api.myparcel.com/service-rates?page[number]=2&page[size]=30",
    "next": "https://sandbox-api.myparcel.com/service-rates?page[number]=4&page[size]=30",
    "last": "https://sandbox-api.myparcel.com/service-rates?page[number]=13&page[size]=30"
  }
}
```
{{% /expand%}}

{{%expand "GET /service-rates/{service_rate_id}" %}}
Retrieve a specific service rate.

**Scope**

Any of the following scopes:

- `organizations.manage`

**Request**
```http
GET /shops/{service_rate_id} HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/service-rates/09a8f83a-bc8d-4598-81e6-ebf9d59a186a
```

**Response**
```json
{
  "data": {
    "type": "service-rates",
    "id": "09a8f83a-bc8d-4598-81e6-ebf9d59a186a",
    "attributes": {
      "weight_min": 0,
      "weight_max": 2000,
      "length_max": 300,
      "width_max": 200,
      "height_max": 200,
      "volume_max": 12,
      "price": {
        "amount": 995,
        "currency": "EUR"
      },
      "step_price": {
        "amount": 995,
        "currency": "EUR"
      },
      "step_size": 100
    },
    "relationships": {
      "contract": {
        "data": {
          "type": "contracts",
          "id": "2cb32706-5762-4b96-9212-327e6afaeeff"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/contracts/2cb32706-5762-4b96-9212-327e6afaeeff"
        }
      },
      "service": {
        "data": {
          "type": "services",
          "id": "175a235f-aff5-4e44-87b5-3657b75c1deb"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/services/175a235f-aff5-4e44-87b5-3657b75c1deb"
        }
      },
      "service_options": {
        "data": [
          {
            "type": "service-options",
            "id": "4c675b1a-516c-4410-abff-d237fd45bcd0",
            "meta": {
              "price": {
                "amount": 995,
                "currency": "EUR"
              },
              "included": true
            }
          }
        ]
      }
    },
    "links": {
      "self": "https://sandbox-api.myparcel.com/service-rates/c9ce29a4-6325-11e7-907b-a6006ad3dba0"
    }
  }
}
```
{{% /expand%}}
