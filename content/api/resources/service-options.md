+++
title = "Service Options"
description = "Various options which are available for different carrier services in our API."
weight = 18
+++

Service options can be added to a [shipment](/api/resources/shipments/) to add extra's to the chosen service (if available). Options are a generic resource since many carriers offer the same options, like delivery in the weekend. The added price of the service option depends on the used [contract](/api/resources/contracts/) and [service](/api/resources/services/) and is described in the [service rate](/api/resources/service-rates/) that links the shipment's service and contract together.

## Service Option

{{< icon fa-file-text-o >}}[API specification](https://api-specification.myparcel.com/#tag/ServiceOptions)

Attribute       | Type                                                                            | Description                                                                                                               | Required
--------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |----------------
name            | string                                                                          | Option name, useful for displaying to users.                                                                              | ✓
code            | string                                                                          | Option code, which will be used in the request to the carrier.                                                            | ✓
category        | string enum: `delivery-window`<br> `handover-method`<br> `proof-of-delivery`    | The category in which a service option belongs. Note that only one service option per category can be set on a shipment.  |
values_format   | object                                                                          | The format of additional values required for this service option using [JSON Schema](https://json-schema.org/). e.g. price input for Cash on Delivery options. | 

## Endpoints

{{%expand "GET /service-options" %}}
Retrieving a list of service options.

**Scope**  
No scopes are required to retrieve service options.

**Request**
```http
GET /service-options HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/service-options
``` 

**Response**
```json
{
  "data": [
    {
      "type": "service-options",
      "id": "4c675b1a-516c-4410-abff-d237fd45bcd0",
      "attributes": {
        "name": "Collection",
        "category": "handover-method",
        "code": "handover-method:collection"
      },
      "links": {
        "self": "https://sandbox-api.myparcel.com/service-options/4c675b1a-516c-4410-abff-d237fd45bcd0"
      }
    },
    {
      "type": "service-options",
      "id": "c290cfb7-f0ad-4c51-bf2d-be8952ad3d2f",
      "attributes": {
        "name": "Sunday Delivery",
        "category": "delivery-window",
        "code": "delivery-window:saturday"
      },
      "links": {
        "self": "https://sandbox-api.myparcel.com/service-options/c290cfb7-f0ad-4c51-bf2d-be8952ad3d2f"
      }
    }
  ],
  "meta": {
    "total_pages": 1,
    "total_records": 2
  },
  "links": {
    "self": "https://sandbox-api.myparcel.com/service-options?page[number]=1&page[size]=30",
    "first": "https://sandbox-api.myparcel.com/service-options?page[number]=1&page[size]=30",
    "last": "https://sandbox-api.myparcel.com/service-options?page[number]=1&page[size]=30"
  }
}
```

{{% /expand%}}

{{%expand "GET /service-options/{service_option_id}" %}}
Retrieving a specific service option.

**Scope**  
No scopes are required to retrieve service options.

**Request**
```http
GET /service-options/{service_option_id} HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/service-options/c290cfb7-f0ad-4c51-bf2d-be8952ad3d2f
``` 

**Response**
```json
{
  "data": {
    "type": "service-options",
    "id": "c290cfb7-f0ad-4c51-bf2d-be8952ad3d2f",
    "attributes": {
      "name": "Sunday Delivery",
      "category": "delivery-window",
      "code": "delivery-window:saturday"
    },
    "links": {
      "self": "https://sandbox-api.myparcel.com/service-options/c290cfb7-f0ad-4c51-bf2d-be8952ad3d2f"
    }
  }
}
```

{{% /expand%}}
