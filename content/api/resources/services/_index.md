+++
title = "Services"
description = "All services provided by the carriers, possibly filtered on a specific region."
weight = 9
+++

Services are provided by [carriers](/api/resources/carriers) and can be used to send [shipments](/api/resources/shipments). Services are offered from a specific region to a specific region. 

## Attributes

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/Services)

Attribute       | Type              | Description                                                                                                                                       | Required
--------------- |-------------------| -----------------------------------------------------------------------------------------------------------------------------------------------   | --------------
name            | string            | Service name (eg. Next Day), useful for displaying to users.                                                                                                     | ✓
package_type    | string enum: `parcel`<br> `letterbox`<br> `letter`<br> `unstamped`              | Type of package (eg. letter).                                                               | ✓
handover_method | string enum: `collection`<br> `drop-off`                                    | Available methods to hand the shipment to the carrier. Value `collection` means the carrier will pick up the shipment at the shipment's sender address while drop-off means the sender has to drop the shipment at a pickup-dropoff-location.                                     | ✓
delivery_method | string enum: `pick-up`<br> `delivery`            | Delivery method for the carrier. Services with value `pick-up` means the carrier delivers the shipment at a pickup-dropoff-location while `delivery` means they deliver at the shipment's recipient address).   | ✓
delivery_days   | array of string enum: `Monday`<br> `Tuesday`<br> `Wednesday`<br> `Thursday`<br> `Friday`<br> `Saturday`<br> `Sunday`  | Textual representation of days of the week this service delivers shipments.                                                                       | 
transit_time    | [transit time](/api/resources/services/transit-time)                 | The minimum and maximum time it takes to deliver the shipment.                                 |

Relationship | Type                                 | Description                                | Required
------------ | ------------------------------------ |------------------------------------------- | ---------------
carrier      | [carriers](/api/resources/carriers)  | Carrier offering the service.              | ✓
region_from  | [regions](/api/resources/regions)    | Region in which this service is available. | ✓       
region_to    | [regions](/api/resources/regions)    | Region where shipments can be delivered.   | ✓  

## Endpoints

{{%expand "GET /services" %}}
Retrieving a list of services.

**Scope**  

Any of the following scopes:

- `shipments.show`
- `shipments.manage`
- `brokers.show`
- `brokers.manage`

**Request parameters**  
For more specific requests, the following parameters can be included as query parameters.

Parameter                          | Type    | Description
-----------------------------------|---------|---------------------------------------------------------------------------------------------------------------------------------
filter[package_type]               | string  | Comma separated string of `package_types` to filter the services on (eg. `letterbox`). 
filter[carrier]                    | string  | Comma separated string of ids of carrier to filter the services on
filter[region_from]                | string  | Comma separated string of ids of regions that the requested services should be sending from
filter[region_to]                  | string  | Comma separated string of ids of regions that the requested services should be sending to
filter[address_from][country_code] | string  | Retrieve services for which the given [2-letter ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) corresponds to the origin region of the service.
filter[address_from][postal_code]  | string  | Retrieve services for which the given postal code corresponds to the origin region of the service (may result in multiple services if postal code exists in different regions).
filter[address_to][country_code]   | string  | Retrieve services for which the given [2-letter ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) corresponds to the destination region of the service.
filter[address_to][postal_code]    | string  | Retrieve services for which the given postal code corresponds to the destination region of the service (may result in multiple services if postal code exists in different regions).
filter[has_active_contract]        | boolean | A `true` value will filter services that have **active** [contract](/api/resources/contracts) associations. `false` will result in services that do **not** have active contract associations. To retrieve **all** services regardless of contract, omit this filter.
filter[delivery_method]            | string  | Using filter value `pick-up` will result in services that deliver to a [pickup-dropoff-location](/api/resources/pickup-dropoff-locations). Using `delivery` filters services for which the carrier delivers the shipment to the `recipient_address`.

**Request**  
```http
GET /services HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/services
```

**Response**
```json
{
  "data": [
    {
      "type": "services",
      "id": "175a235f-aff5-4e44-87b5-3657b75c1deb",
      "attributes": {
        "name": "Parcel to Parcelshop",
        "package_type": "parcel",
        "delivery_days": [
          "Monday",
          "Tuesday",
          "Wednesday",
          "Thursday",
          "Friday"
        ],
        "transit_time": {
          "min": 1,
          "max": 3
        },
        "handover_method": "drop-off",
        "delivery_method": "pick-up"
      },
      "relationships": {
        "carrier": {
          "data": {
            "type": "carriers",
            "id": "be7f6752-34e0-49a1-a832-bcc209450ea9"
          },
          "links": {
            "related": "https://sandbox-api.myparcel.com/carriers/be7f6752-34e0-49a1-a832-bcc209450ea9"
          }
        },
        "region_from": {
          "data": {
            "type": "regions",
            "id": "0b6ecd39-6072-4529-a031-f21247a91296"
          },
          "links": {
            "related": "https://sandbox-api.myparcel.com/regions/0b6ecd39-6072-4529-a031-f21247a91296"
          }
        },
        "region_to": {
          "data": {
            "type": "regions",
            "id": "0b6ecd39-6072-4529-a031-f21247a91296"
          },
          "links": {
            "related": "https://sandbox-api.myparcel.com/regions/0b6ecd39-6072-4529-a031-f21247a91296"
          }
        }
      },
      "links": {
        "self": "https://sandbox-api.myparcel.com/services/175a235f-aff5-4e44-87b5-3657b75c1deb"
      }
    }
  ],
  "meta": {
    "total_pages": 1,
    "total_records": 1
  },
  "links": {
    "self": "https://sandbox-api.myparcel.com/services?page[number]=1&page[size]=30",
    "first": "https://sandbox-api.myparcel.com/services?page[number]=1&page[size]=30",
    "last": "https://sandbox-api.myparcel.com/services?page[number]=1&page[size]=30"
  }
}
```

{{% /expand%}}

{{%expand "GET /services/{service_id}" %}}
Retrieve a specific service.

**Scope**  

Any of the following scopes:

- `shipments.show`
- `shipments.manage`
- `brokers.show`
- `brokers.manage`

**Request**  
```http
GET /services/{service_id} HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/service/175a235f-aff5-4e44-87b5-3657b75c1deb
```

**Response**  
```json
{
  "data": {
    "type": "services",
    "id": "175a235f-aff5-4e44-87b5-3657b75c1deb",
    "attributes": {
      "name": "Parcel to Parcelshop",
      "package_type": "parcel",
      "delivery_days": [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday"
      ],
      "transit_time": {
        "min": 1,
        "max": 3
      },
      "handover_method": "drop-off",
      "delivery_method": "pick-up"
    },
    "relationships": {
      "carrier": {
        "data": {
          "type": "carriers",
          "id": "be7f6752-34e0-49a1-a832-bcc209450ea9"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/carriers/be7f6752-34e0-49a1-a832-bcc209450ea9"
        }
      },
      "region_from": {
        "data": {
          "type": "regions",
          "id": "0b6ecd39-6072-4529-a031-f21247a91296"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/regions/0b6ecd39-6072-4529-a031-f21247a91296"
        }
      },
      "region_to": {
        "data": {
          "type": "regions",
          "id": "0b6ecd39-6072-4529-a031-f21247a91296"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/regions/0b6ecd39-6072-4529-a031-f21247a91296"
        }
      }
    },
    "links": {
      "self": "https://sandbox-api.myparcel.com/services/175a235f-aff5-4e44-87b5-3657b75c1deb"
    }
  }
}
```
