+++
title = "Shipments"
description = "The main resource in our API containing shipment information, files and statuses."
weight = 22
+++

Shipments are at the core of our API. They contain files such as labels and are used to track the status of the physical shipment being delivered by the carrier.

## Attributes

{{< icon fa-file-text-o >}}[API specification](https://api-specification.myparcel.com/#tag/Shipments)

| Attribute            | Type                                                                 | Description                                                                                                                  | Required
| -------------------- | -------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- | --------
| recipient_address    | [address](/api/resources/common-objects/addresses/)                  | The address of the recipient of the shipment.                                                                                | ✓
| return_address       | [address](/api/resources/common-objects/addresses/)                  | The address the shipment can be returned to when  shipment fails.                                                            | ✓
| sender_address       | [address](/api/resources/common-objects/addresses/)                  | The address of the sender of the shipment.                                                                                   | ✓
| physical_properties  | [physical-properties](/api/resources/shipments/physical-properties/) | Weight and dimensions of the shipment.                                                                                       | ✓
| pickup_location      | [pickup-dropoff-locations](/api/resources/carrier-pudo-locations/)   | The place where the recipient can pick up their shipment.                                                                    | Required when chosen service has delivery-method pick-up
| description          | string                                                               | Short description of the shipment that will be printed on the label when possible.                                           | Required for international shipments
| items                | array of [items](/api/resources/shipments/items)                     | The contents of the shipment.                                                                                                | Required for international shipments
| customs              | [customs](/api/resources/shipments/customs/)                         | Information required for the shipment to pass customs.                                                                       | Required for international shipments
| sender_tax_number    | string                                                               | Tax number of sender e.g. EORI or VOEC number. Taken from [organization](/api/resources/organizations/) if not specified.    |
| recipient_tax_number | string                                                               | Tax number of recipient.                                                                                                     |
| customer_reference   | string                                                               | Internal customer reference that can be used to identify shipments. This field is not communicated to the carrier.           |
| channel              | string                                                               | Name of the application or integration (and potentially version number) used to create the shipment.                         |
| price                | [price](/api/resources/common-objects/prices/)                       | The price of the shipment.                                                                                                   |
| total_value          | [price](/api/resources/common-objects/prices/)                       | The total value of the shipment.                                                                                             |
| barcode              | string                                                               | Textual representation of the barcode present on the label.                                                                  |
| tracking_code        | string                                                               | Used to request tracking status from the carrier.                                                                            |
| tracking_url         | string                                                               | Points to the tracking software of the carrier.                                                                              |
| register_at          | integer                                                              | Unix timestamp for when the shipment will be registered with the carrier. After registration, labels will be made available. |
| created_at           | integer                                                              | Unix timestamp for when the shipment was created.                                                                            |
| updated_at           | integer                                                              | Unix timestamp for when the shipment resource was last updated.                                                              |
| synced_at            | integer                                                              | Unix timestamp for when the shipment status was last checked with the carrier.                                               |
| tags                 | array of strings or numbers                                          | User defined tags for the shipment.                                                                                          |

| Relationship    | Type                                                        | Description                                                                                                  | Required                                            |
|-----------------|-------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------|-----------------------------------------------------|
| shop            | [shops](/api/resources/shops/)                              | The shop the shipment belongs to.                                                                            | ✓                                                   |
| service         | [services](/api/resources/services/)                        | The service used to send the shipment.                                                                       | Required for registration with the carrier          |
| contract        | [contracts](/api/resources/contracts/)                      | The contract to use for the chosen service.                                                                  | Required for registration with the carrier          |
| service_options | array of [service-options](/api/resources/service-options/) | The service options chosen for the shipment.                                                                 |                                                     |
| shipment_status | [shipment-statuses](/api/resources/shipment-statuses/)      | The current shipment status for the shipment.                                                                |                                                     |
| files           | array of [files](/api/resources/files/)                     | The files available for the shipment. Such as the label and possible customs documents.                      |                                                     |
| hook_logs       | array of [hook-logs](/api/resources/hooks/logs/)            | The logs of the hooks that were applied to this this shipment. Such as updating the service or the contract. |                                                     |

## Endpoints

{{%expand "GET /shipments" %}}
Retrieving a list of shipments.

**Scope**

Any of the following scopes:

- `shipments.manage`

**Request**
```http
GET /shipments HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/shipments
```

**Response**
```json
{
  "data": [
    {
      "type": "shipments",
      "id": "7b808eee-bf1c-40cd-98f2-3c335a06417e",
      "attributes": {
        "recipient_address": {
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
        },
        "return_address": {
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
        },
        "sender_address": {
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
        },
        "pickup_location": {
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
        },
        "description": "Fidget spinners",
        "customer_reference": "#8008135",
        "channel": "MyParcel.com Back Office",
        "price": {
          "amount": 995,
          "currency": "EUR"
        },
        "total_value": {
          "amount": 25000,
          "currency": "EUR"
        },
        "barcode": "3SABCD0123456789",
        "tracking_code": "3SABCD0123456789",
        "tracking_url": "https://tracker.carrier.com/3SABCD0123456789",
        "physical_properties": {
          "height": 150,
          "width": 300,
          "length": 500,
          "volume": 22.5,
          "weight": 5000,
          "volumetric_weight": 4500
        },
        "items": [
          {
            "sku": "123456789",
            "description": "OnePlus X",
            "image_url": "https://some.image.url/file.png",
            "item_value": {
              "amount": 995,
              "currency": "EUR"
            },
            "quantity": 2,
            "hs_code": "8517.12.00",
            "origin_country_code": "GB",
            "nett_weight": 135
          }
        ],
        "register_at": 1504801719,
        "created_at": 1504801719,
        "updated_at": 1504801719,
        "synced_at": 1504801719,
        "tags": ["my", "personal", "tags"]
      },
      "relationships": {
        "service_options": {
          "data": [
            {
              "type": "service-options",
              "id": "4c675b1a-516c-4410-abff-d237fd45bcd0"
            }
          ]
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
        "contract": {
          "data": {
            "type": "contracts",
            "id": "2cb32706-5762-4b96-9212-327e6afaeeff"
          },
          "links": {
            "related": "https://sandbox-api.myparcel.com/contracts/2cb32706-5762-4b96-9212-327e6afaeeff"
          }
        },
        "shop": {
          "data": {
            "type": "shops",
            "id": "35eddf50-1d84-47a3-8479-6bfda729cd99"
          },
          "links": {
            "related": "https://sandbox-api.myparcel.com/shops/35eddf50-1d84-47a3-8479-6bfda729cd99"
          }
        },
        "shipment_status": {
          "data": {
            "type": "shipment-statuses",
            "id": "9e6d8dba-7c45-4351-a9fc-b55a0cbafbad"
          },
          "links": {
            "related": "https://sandbox-api.myparcel.com/shipments/7b808eee-bf1c-40cd-98f2-3c335a06417e/statuses/9e6d8dba-7c45-4351-a9fc-b55a0cbafbad"
          }
        },
        "files": {
          "data": [
            {
              "type": "files",
              "id": "0f621db6-d239-4ae9-b85d-8e97469b10ce"
            }
          ]
        },
        "hook_logs": {
          "data": [
            {
              "type": "hook-logs",
              "id": "8e141db6-d638-9ae0-e33d-8e97469b10ce"
            }
          ]
        }
      },
      "links": {
        "self": "https://sandbox-api.myparcel.com/shipments/7b808eee-bf1c-40cd-98f2-3c335a06417e",
        "files": "https://sandbox-api.myparcel.com/shipments/0f621db6-d239-4ae9-b85d-8e97469b10ce/files"
      }
    },
    {
      "type": "shipments",
      "id": "7b808eee-bf1c-40cd-98f2-3c335a06417e",
      "attributes": {
        "recipient_address": {
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
        },
        "return_address": {
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
        },
        "sender_address": {
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
        },
        "pickup_location": {
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
        },
        "description": "Fidget spinners",
        "customer_reference": "#8008135",
        "channel": "MyParcel.com Back Office",
        "price": {
          "amount": 995,
          "currency": "EUR"
        },
        "total_value": {
          "amount": 25000,
          "currency": "EUR"
        },
        "barcode": "3SABCD0123456789",
        "tracking_code": "3SABCD0123456789",
        "tracking_url": "https://tracker.carrier.com/3SABCD0123456789",
        "physical_properties": {
          "height": 150,
          "width": 300,
          "length": 500,
          "volume": 22.5,
          "weight": 5000,
          "volumetric_weight": 4500
        },
        "items": [
          {
            "sku": "123456789",
            "description": "OnePlus X",
            "image_url": "https://some.image.url/file.png",
            "item_value": {
              "amount": 995,
              "currency": "EUR"
            },
            "quantity": 2,
            "hs_code": "8517.12.00",
            "origin_country_code": "GB",
            "nett_weight": 135
          }
        ],
        "register_at": 1504801719,
        "created_at": 1504801719,
        "updated_at": 1504801719,
        "synced_at": 1504801719,
        "tags": ["my", "personal", "tags"]
      },
      "relationships": {
        "service_options": {
          "data": [
            {
              "type": "service-options",
              "id": "4c675b1a-516c-4410-abff-d237fd45bcd0"
            }
          ]
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
        "contract": {
          "data": {
            "type": "contracts",
            "id": "2cb32706-5762-4b96-9212-327e6afaeeff"
          },
          "links": {
            "related": "https://sandbox-api.myparcel.com/contracts/2cb32706-5762-4b96-9212-327e6afaeeff"
          }
        },
        "shop": {
          "data": {
            "type": "shops",
            "id": "35eddf50-1d84-47a3-8479-6bfda729cd99"
          },
          "links": {
            "related": "https://sandbox-api.myparcel.com/shops/35eddf50-1d84-47a3-8479-6bfda729cd99"
          }
        },
        "shipment_status": {
          "data": {
            "type": "shipment-statuses",
            "id": "9e6d8dba-7c45-4351-a9fc-b55a0cbafbad"
          },
          "links": {
            "related": "https://sandbox-api.myparcel.com/shipments/7b808eee-bf1c-40cd-98f2-3c335a06417e/statuses/9e6d8dba-7c45-4351-a9fc-b55a0cbafbad"
          }
        },
        "files": {
          "data": [
            {
              "type": "files",
              "id": "0f621db6-d239-4ae9-b85d-8e97469b10ce"
            }
          ]
        },
        "hook_logs": {
          "data": [
            {
              "type": "hook-logs",
              "id": "8e141db6-d638-9ae0-e33d-8e97469b10ce"
            }
          ]
        }
      },
      "links": {
        "self": "https://sandbox-api.myparcel.com/shipments/7b808eee-bf1c-40cd-98f2-3c335a06417e",
        "files": "https://sandbox-api.myparcel.com/shipments/0f621db6-d239-4ae9-b85d-8e97469b10ce/files"
      }
    }
  ],
  "meta": {
    "total_pages": 13,
    "total_records": 373
  },
  "links": {
    "self": "https://sandbox-api.myparcel.com/shipments?page[number]=3&page[size]=30",
    "first": "https://sandbox-api.myparcel.com/shipments?page[number]=1&page[size]=30",
    "prev": "https://sandbox-api.myparcel.com/shipments?page[number]=2&page[size]=30",
    "next": "https://sandbox-api.myparcel.com/shipments?page[number]=4&page[size]=30",
    "last": "https://sandbox-api.myparcel.com/shipments?page[number]=13&page[size]=30"
  }
}
```
{{% /expand%}}

{{%expand "GET /shipments/{shipment_id}" %}}
Retrieve a specific shipment.

**Scope**

Any of the following scopes:

- `shipments.manage`

**Request**
```http
GET /shipments/{shipment_id} HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/shipments/7b808eee-bf1c-40cd-98f2-3c335a06417e
```

**Response**
```json
{
  "data": {
    "type": "shipments",
    "id": "7b808eee-bf1c-40cd-98f2-3c335a06417e",
    "attributes": {
      "recipient_address": {
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
        "email": "s.holmes@holmesinvestigations.com",
        "phone_number": "+31 234 567 890"
      },
      "return_address": {
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
        "email": "s.holmes@holmesinvestigations.com",
        "phone_number": "+31 234 567 890"
      },
      "sender_address": {
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
        "email": "s.holmes@holmesinvestigations.com",
        "phone_number": "+31 234 567 890"
      },
      "pickup_location": {
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
          "email": "s.holmes@holmesinvestigations.com",
          "phone_number": "+31 234 567 890"
        }
      },
      "description": "Fidget spinners",
      "customer_reference": "#8008135",
      "channel": "MyParcel.com Back Office",
      "physical_properties": {
        "height": 150,
        "width": 300,
        "length": 500,
        "volume": 22.5,
        "weight": 5000,
        "volumetric_weight": 4500
      },
      "items": [
        {
          "sku": "123456789",
          "description": "OnePlus X",
          "image_url": "https://some.image.url/file.png",
          "item_value": {
            "amount": 995,
            "currency": "EUR"
          },
          "quantity": 2,
          "hs_code": "8517.12.00",
          "origin_country_code": "GB",
          "nett_weight": 135
        }
      ],
      "customs": {
        "content_type": "merchandise",
        "invoice_number": "9000",
        "non_delivery": "return",
        "incoterm": "DAP",
        "shipping_value": {
          "amount": 995,
          "currency": "EUR"
        },
        "license_number": "218532158",
        "certificate_number": "12122121"
      },
      "register_at": 1504801719,
      "price": {
        "amount": 995,
        "currency": "EUR"
      },
      "total_value": {
        "amount": 25000,
        "currency": "EUR"
      },
      "barcode": "3SABCD0123456789",
      "tracking_code": "3SABCD0123456789",
      "tracking_url": "https://tracker.carrier.com/3SABCD0123456789",
      "created_at": 1504801719,
      "updated_at": 1504801719,
      "synced_at": 1504801719,
      "tags": ["my", "personal", "tags"]
    },
    "relationships": {
      "service_options": {
        "data": [
          {
            "type": "service-options",
            "id": "4c675b1a-516c-4410-abff-d237fd45bcd0"
          }
        ]
      },
      "shop": {
        "data": {
          "type": "shops",
          "id": "35eddf50-1d84-47a3-8479-6bfda729cd99"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/shops/35eddf50-1d84-47a3-8479-6bfda729cd99"
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
      "contract": {
        "data": {
          "type": "contracts",
          "id": "2cb32706-5762-4b96-9212-327e6afaeeff"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/contracts/2cb32706-5762-4b96-9212-327e6afaeeff"
        }
      },
      "shipment_status": {
        "data": {
          "type": "shipment-statuses",
          "id": "9e6d8dba-7c45-4351-a9fc-b55a0cbafbad"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/shipments/7b808eee-bf1c-40cd-98f2-3c335a06417e/statuses/9e6d8dba-7c45-4351-a9fc-b55a0cbafbad"
        }
      },
      "files": {
        "data": [
          {
            "type": "files",
            "id": "0f621db6-d239-4ae9-b85d-8e97469b10ce"
          }
        ]
      },
      "hook_logs": {
        "data": [
          {
            "type": "hook-logs",
            "id": "8e141db6-d638-9ae0-e33d-8e97469b10ce"
          }
        ]
      }
    },
    "links": {
      "self": "https://sandbox-api.myparcel.com/shipments/7b808eee-bf1c-40cd-98f2-3c335a06417e",
      "files": "https://sandbox-api.myparcel.com/shipments/0f621db6-d239-4ae9-b85d-8e97469b10ce/files"
    }
  }
}
```
{{% /expand%}}

{{%expand "POST /shipments" %}}
Create a shipment.

**Scope**

- `shipments.manage`

**Meta data**

The `POST /shipments` endpoint allows the user to send a `meta` property in addition to the main `data` attribute.
In this `meta` property, the following properties can be included:

| Property          | Type      | Description                                   | Required  | Default           |
| --------          | --------- | --------------------------------------------- | --------- | ----------------- |
| label_mime_type   | string    | Requested mime type for the shipment's label. |           | application/pdf   |

{{% notice note %}}
This meta information is not returned in the response.
{{% /notice %}}

**Request**
```http
POST /shipments HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/shipments
```

```json
{
  "data": {
    "type": "shipments",
    "attributes": {
      "recipient_address": {
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
        "email": "s.holmes@holmesinvestigations.com",
        "phone_number": "+31 234 567 890"
      },
      "return_address": {
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
        "email": "s.holmes@holmesinvestigations.com",
        "phone_number": "+31 234 567 890"
      },
      "sender_address": {
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
        "email": "s.holmes@holmesinvestigations.com",
        "phone_number": "+31 234 567 890"
      },
      "pickup_location": {
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
          "email": "s.holmes@holmesinvestigations.com",
          "phone_number": "+31 234 567 890"
        }
      },
      "description": "Fidget spinners",
      "customer_reference": "#8008135",
      "channel": "MyParcel.com Back Office",
      "physical_properties": {
        "height": 150,
        "width": 300,
        "length": 500,
        "volume": 22.5,
        "weight": 5000
      },
      "items": [
        {
          "sku": "123456789",
          "description": "OnePlus X",
          "image_url": "https://some.image.url/file.png",
          "item_value": {
            "amount": 995,
            "currency": "EUR"
          },
          "quantity": 2,
          "hs_code": "8517.12.00",
          "origin_country_code": "GB",
          "nett_weight": 135
        }
      ],
      "customs": {
        "content_type": "merchandise",
        "invoice_number": "9000",
        "non_delivery": "return",
        "incoterm": "DAP",
        "shipping_value": {
          "amount": 995,
          "currency": "EUR"
        },
        "license_number": "218532158",
        "certificate_number": "12122121"
      },
      "register_at": 1504801719,
      "tags": ["my", "personal", "tags"]
    },
    "relationships": {
      "service_options": {
        "data": [
          {
            "type": "service-options",
            "id": "4c675b1a-516c-4410-abff-d237fd45bcd0"
          }
        ]
      },
      "shop": {
        "data": {
          "type": "shops",
          "id": "35eddf50-1d84-47a3-8479-6bfda729cd99"
        }
      },
      "service": {
        "data": {
          "type": "services",
          "id": "175a235f-aff5-4e44-87b5-3657b75c1deb"
        }
      },
      "contract": {
        "data": {
          "type": "contracts",
          "id": "2cb32706-5762-4b96-9212-327e6afaeeff"
        }
      }
    }
  },
  "meta": {
    "label_mime_type": "application/zpl"
  }
}
```

**Response**
```json
{
  "data": {
    "type": "shipments",
    "id": "7b808eee-bf1c-40cd-98f2-3c335a06417e",
    "attributes": {
      "recipient_address": {
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
        "email": "s.holmes@holmesinvestigations.com",
        "phone_number": "+31 234 567 890"
      },
      "return_address": {
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
        "email": "s.holmes@holmesinvestigations.com",
        "phone_number": "+31 234 567 890"
      },
      "sender_address": {
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
        "email": "s.holmes@holmesinvestigations.com",
        "phone_number": "+31 234 567 890"
      },
      "pickup_location": {
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
          "email": "s.holmes@holmesinvestigations.com",
          "phone_number": "+31 234 567 890"
        }
      },
      "description": "Fidget spinners",
      "customer_reference": "#8008135",
      "channel": "MyParcel.com Back Office",
      "physical_properties": {
        "height": 150,
        "width": 300,
        "length": 500,
        "volume": 22.5,
        "weight": 5000,
        "volumetric_weight": 4500
      },
      "items": [
        {
          "sku": "123456789",
          "description": "OnePlus X",
          "image_url": "https://some.image.url/file.png",
          "item_value": {
            "amount": 995,
            "currency": "EUR"
          },
          "quantity": 2,
          "hs_code": "8517.12.00",
          "origin_country_code": "GB",
          "nett_weight": 135
        }
      ],
      "customs": {
        "content_type": "merchandise",
        "invoice_number": "9000",
        "non_delivery": "return",
        "incoterm": "DAP",
        "shipping_value": {
          "amount": 995,
          "currency": "EUR"
        },
        "license_number": "218532158",
        "certificate_number": "12122121"
      },
      "register_at": 1504801719,
      "price": {
        "amount": 995,
        "currency": "EUR"
      },
      "total_value": {
        "amount": 25000,
        "currency": "EUR"
      },
      "barcode": "3SABCD0123456789",
      "tracking_code": "3SABCD0123456789",
      "tracking_url": "https://tracker.carrier.com/3SABCD0123456789",
      "created_at": 1504801719,
      "updated_at": 1504801719,
      "synced_at": 1504801719,
      "tags": ["my", "personal", "tags"]
    },
    "relationships": {
      "service_options": {
        "data": [
          {
            "type": "service-options",
            "id": "4c675b1a-516c-4410-abff-d237fd45bcd0"
          }
        ]
      },
      "shop": {
        "data": {
          "type": "shops",
          "id": "35eddf50-1d84-47a3-8479-6bfda729cd99"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/shops/35eddf50-1d84-47a3-8479-6bfda729cd99"
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
      "contract": {
        "data": {
          "type": "contracts",
          "id": "2cb32706-5762-4b96-9212-327e6afaeeff"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/contracts/2cb32706-5762-4b96-9212-327e6afaeeff"
        }
      },
      "shipment_status": {
        "data": {
          "type": "shipment-statuses",
          "id": "9e6d8dba-7c45-4351-a9fc-b55a0cbafbad"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/shipments/7b808eee-bf1c-40cd-98f2-3c335a06417e/statuses/9e6d8dba-7c45-4351-a9fc-b55a0cbafbad"
        }
      },
      "files": {
        "data": [
          {
            "type": "files",
            "id": "0f621db6-d239-4ae9-b85d-8e97469b10ce"
          }
        ]
      },
      "hook_logs": {
        "data": [
          {
            "type": "hook-logs",
            "id": "8e141db6-d638-9ae0-e33d-8e97469b10ce"
          }
        ]
      }
    },
    "links": {
      "self": "https://sandbox-api.myparcel.com/shipments/7b808eee-bf1c-40cd-98f2-3c335a06417e",
      "files": "https://sandbox-api.myparcel.com/shipments/0f621db6-d239-4ae9-b85d-8e97469b10ce/files"
    }
  }
}
```
{{% /expand%}}

{{%expand "PATCH /shipments/{shipment_id}" %}}
Update an existing shipment.

**Scope**

- `shipments.manage`

**Meta data**

The `PATCH /shipments/{shipment_id}` endpoint allows the user to send a `meta` property in addition to the main `data` attribute.
In this `meta` property, the following properties can be included:

| Property          | Type      | Description                                   | Required      | Default           |
| --------          | --------- | --------------------------------------------- | ------------- | ----------------- |
| label_mime_type   | string    | Requested mime type for the shipment's label. |               | application/pdf   |

{{% notice note %}}
This meta information is not returned in the response.
{{% /notice %}}

**Request**

*In this example we're updating the recipient_address.*

```http
PATCH /shipments/{shipment_id} HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/shipments/7b808eee-bf1c-40cd-98f2-3c335a06417e
```

```json
{
  "data": {
    "type": "shipments",
    "id": "7b808eee-bf1c-40cd-98f2-3c335a06417e",
    "attributes": {
      "recipient_address": {
        "street_1": "Fifth Avenue",
        "street_2": "Manhattan",
        "street_number": 890,
        "postal_code": "10020",
        "city": "New York",
        "region_code": "USA",
        "country_code": "US",
        "first_name": "Tony",
        "last_name": "Stark",
        "company": "Avengers, inc.",
        "phone_number": "+31 234 567 890"
      }
    }
  }
}
```

**Response**
```json
{
  "data": {
    "type": "shipments",
    "id": "7b808eee-bf1c-40cd-98f2-3c335a06417e",
    "attributes": {
      "recipient_address": {
        "street_1": "Fifth Avenue",
        "street_2": "Manhattan",
        "street_number": 890,
        "postal_code": "10020",
        "city": "New York",
        "region_code": "USA",
        "country_code": "US",
        "first_name": "Tony",
        "last_name": "Stark",
        "company": "Avengers, inc.",
        "phone_number": "+31 234 567 890"
      },
      "return_address": {
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
        "email": "s.holmes@holmesinvestigations.com",
        "phone_number": "+31 234 567 890"
      },
      "sender_address": {
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
        "email": "s.holmes@holmesinvestigations.com",
        "phone_number": "+31 234 567 890"
      },
      "pickup_location": {
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
          "email": "s.holmes@holmesinvestigations.com",
          "phone_number": "+31 234 567 890"
        }
      },
      "description": "Fidget spinners",
      "customer_reference": "#8008135",
      "channel": "MyParcel.com Back Office",
      "physical_properties": {
        "height": 150,
        "width": 300,
        "length": 500,
        "volume": 22.5,
        "weight": 5000,
        "volumetric_weight": 4500
      },
      "items": [
        {
          "sku": "123456789",
          "description": "OnePlus X",
          "image_url": "https://some.image.url/file.png",
          "item_value": {
            "amount": 995,
            "currency": "EUR"
          },
          "quantity": 2,
          "hs_code": "8517.12.00",
          "origin_country_code": "GB",
          "nett_weight": 135
        }
      ],
      "customs": {
        "content_type": "merchandise",
        "invoice_number": "9000",
        "non_delivery": "return",
        "incoterm": "DAP",
        "shipping_value": {
          "amount": 995,
          "currency": "EUR"
        },
        "license_number": "218532158",
        "certificate_number": "12122121"
      },
      "register_at": 1504801719,
      "price": {
        "amount": 995,
        "currency": "EUR"
      },
      "total_value": {
        "amount": 25000,
        "currency": "EUR"
      },
      "barcode": "3SABCD0123456789",
      "tracking_code": "3SABCD0123456789",
      "tracking_url": "https://tracker.carrier.com/3SABCD0123456789",
      "created_at": 1504801719,
      "updated_at": 1504801719,
      "synced_at": 1504801719,
      "tags": ["my", "personal", "tags"]
    },
    "relationships": {
      "service_options": {
        "data": [
          {
            "type": "service-options",
            "id": "4c675b1a-516c-4410-abff-d237fd45bcd0"
          }
        ]
      },
      "shop": {
        "data": {
          "type": "shops",
          "id": "35eddf50-1d84-47a3-8479-6bfda729cd99"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/shops/35eddf50-1d84-47a3-8479-6bfda729cd99"
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
      "contract": {
        "data": {
          "type": "contracts",
          "id": "2cb32706-5762-4b96-9212-327e6afaeeff"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/contracts/2cb32706-5762-4b96-9212-327e6afaeeff"
        }
      },
      "shipment_status": {
        "data": {
          "type": "shipment-statuses",
          "id": "9e6d8dba-7c45-4351-a9fc-b55a0cbafbad"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/shipments/7b808eee-bf1c-40cd-98f2-3c335a06417e/statuses/9e6d8dba-7c45-4351-a9fc-b55a0cbafbad"
        }
      },
      "files": {
        "data": [
          {
            "type": "files",
            "id": "0f621db6-d239-4ae9-b85d-8e97469b10ce"
          }
        ]
      },
      "hook_logs": {
        "data": [
          {
            "type": "hook-logs",
            "id": "8e141db6-d638-9ae0-e33d-8e97469b10ce"
          }
        ]
      }
    },
    "links": {
      "self": "https://sandbox-api.myparcel.com/shipments/7b808eee-bf1c-40cd-98f2-3c335a06417e",
      "files": "https://sandbox-api.myparcel.com/shipments/0f621db6-d239-4ae9-b85d-8e97469b10ce/files"
    }
  }
}
```
{{% /expand%}}

{{%expand "DELETE /shipments/{shipment_id}" %}}
Delete an existing shipment.

This is only possible for shipments with the status `shipment_concept`.

**Scope**

- `shipments.manage`

**Request**

```http
DELETE /shipments/{shipment_id} HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/shipments/7b808eee-bf1c-40cd-98f2-3c335a06417e
```

**Response**

```http
202 The shipment will be deleted.
```
```http
204 The shipment is deleted.
```

{{% /expand%}}
