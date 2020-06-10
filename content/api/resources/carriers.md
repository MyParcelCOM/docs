+++
title = "Carriers"
description = "The postal carriers that MyParcel.com works with and are available for your region."
weight = 2
+++

A carrier resource represents one of the many postal carriers that MyParcel.com works with to provide you with a broad range of [contracts](/api/resources/contracts). This endpoint can be used to get a list of the postal carriers we support that the client can access.
Carriers are included as relationships of [services](/api/resources/services/), [contracts](/api/resources/contracts/) and [pickup dropoff locations](/api/resources/carrier-pudo-locations/).

## Carrier

{{< icon fa-file-text-o >}}[API specification](https://api-specification.myparcel.com/#tag/Carriers)

Attribute          | Type           | Description
------------------ | -------------- | -----------
name               | string         | Carrier name, useful for displaying to users.
code               | string         | Unique slugified version of the carrier name.
credentials_format | object         | The format of credentials for this carrier's contracts described using [JSON Schema](https://json-schema.org/).
label_mime_types   | array          | The label mime-types the carrier offers for shipments.

## Endpoints

{{%expand "GET /carriers" %}}
Retrieving a list of carriers.

**Scope**  

No scopes are required to retrieve carriers.

**Request**  
```http
GET /carriers HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/carriers
```

**Response**
```json
{
  "data": [
    {
      "type": "carriers",
      "id": "be7f6752-34e0-49a1-a832-bcc209450ea9",
      "attributes": {
        "name": "MyParcel.com",
        "code": "my-parcel-com",
        "credentials_format": {
          "additionalProperties": false,
          "required": [
            "api_user",
            "api_password"
          ],
          "properties": {
            "api_user": {
              "type": "string"
            },
            "api_password": {
              "type": "string"
            }
          }
        },
        "label_mime_types": [
          "application/pdf"
        ]
      },
      "links": {
        "self": "https://sandbox-api.myparcel.com/carriers/be7f6752-34e0-49a1-a832-bcc209450ea9"
      }
    }
  ],
  "meta": {
    "total_pages": 13,
    "total_records": 373
  },
  "links": {
    "self": "https://sandbox-api.myparcel.com/carriers?page[number]=3&page[size]=30",
    "first": "https://sandbox-api.myparcel.com/carriers?page[number]=1&page[size]=30",
    "prev": "https://sandbox-api.myparcel.com/carriers?page[number]=2&page[size]=30",
    "next": "https://sandbox-api.myparcel.com/carriers?page[number]=4&page[size]=30",
    "last": "https://sandbox-api.myparcel.com/carriers?page[number]=13&page[size]=30"
  }
}
```

{{% /expand%}}

{{%expand "GET /carriers/{carrier_id}" %}}
Retrieve a specific carrier.

**Scope**  

No scopes are required to retrieve carriers.

**Request**  
```http
GET /carriers/{carrier_id} HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/carriers/be7f6752-34e0-49a1-a832-bcc209450ea9
```

**Response**  
```json
{
  "data": {
    "type": "carriers",
    "id": "be7f6752-34e0-49a1-a832-bcc209450ea9",
    "attributes": {
      "name": "MyParcel.com",
      "code": "my-parcel-com",
      "credentials_format": {
        "additionalProperties": false,
        "required": [
          "api_user",
          "api_password"
        ],
        "properties": {
          "api_user": {
            "type": "string"
          },
          "api_password": {
            "type": "string"
          }
        }
      },
      "label_mime_types": [
        "application/pdf"
      ]
    },
    "links": {
      "self": "https://sandbox-api.myparcel.com/carriers/be7f6752-34e0-49a1-a832-bcc209450ea9"
    }
  }
}
```
