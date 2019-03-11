+++
title = "Shipments"
description = "The main resource in our API containing shipment information, files and statuses."
weight = 15
+++

Shipments are at the core of our API. They contain files such as labels and are used to track the status of the physical shipment being delivered by the carrier.

## Attributes

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/Shipments)

| Attribute           | Type                                                                 | Description                                                                                                                  | Required                                                 |
|---------------------|----------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------|
| recipient_address   | [address](/api/resources/common-objects/addresses/)                  | The address of the recipient of the shipment.                                                                                | ✓                                                        |
| return_address      | [address](/api/resources/common-objects/addresses/)                  | The address the shipment can be returned to when  shipment fails.                                                            | ✓                                                        |
| sender_address      | [address](/api/resources/common-objects/addresses/)                  | The address of the sender of the shipment.                                                                                   | ✓                                                        |
| physical_properties | [physical-properties](/api/resources/shipments/physical-properties/) | Weight and dimensions of the shipment.                                                                                       | ✓                                                        |
| pickup_location     | [pickup-dropoff-locations](/api/resources/pickup-dropoff-locations)  | The place where the recipient can pick up their shipment. See [Pickup Location](/api/resources/shipments/pickup-location/).  | Required when chosen service has delivery-method pick-up |
| description         | string                                                               | Short custom description that will be printed on the label when possible.                                                    | Required for international shipments                     |
| items               | array of [items](/api/resources/shipments/items)                     | The contents of the shipment.                                                                                                | Required for international shipments                     |
| customs             | [customs](/api/resources/shipments/customs/)                         | Information required for the shipment to pass customs.                                                                       | Required for international shipments                     |
| price               | [price](/api/resources/common-objects/prices/)                       | The price of the shipment.                                                                                                   |                                                          |
| barcode             | string                                                               | Textual representation of the barcode present on the label.                                                                  |                                                          |
| tracking_code       | string                                                               | Used to request tracking status from the carrier.                                                                            |                                                          |
| tracking_url        | string                                                               | Points to the tracking software of the carrier.                                                                              |                                                          |
| register_at         | integer                                                              | Unix timestamp for when the shipment will be registered with the carrier. After registration, labels will be made available. |                                                          |
| created_at          | integer                                                              | Unix timestamp for when the shipment was created.                                                                            |                                                          |
| updated_at          | integer                                                              | Unix timestamp for when the shipment resource was last updated.                                                              |                                                          |
| synced_at           | integer                                                              | Unix timestamp for when the shipment status was last checked with the carrier.                                               |                                                          |

| Relationship    | Type                                                        | Description                                                                             | Required                                            |
|-----------------|-------------------------------------------------------------|-----------------------------------------------------------------------------------------|-----------------------------------------------------|
| shop            | [shops](/api/resources/shops/)                              | The shop the shipment belongs to.                                                       | ✓                                                   |
| service         | [services](/api/resources/services/)                        | The service used to send the shipment.                                                  | Required before registration with the carrier       |
| contract        | [contracts](/api/resources/contracts/)                      | The contract to use for the chosen service.                                             | Required before registration with the carrier       |
| service_options | array of [service-options](/api/resources/service-options/) | The service options chosen for the shipment.                                            |                                                     |
| shipment_status | [shipment-statuses](/api/resources/shipment-statuses/)      | The current shipment status for the shipment.                                           |                                                     |
| files           | array of [files](/api/resources/files/)                     | The files available for the shipment. Such as the label and possible customs documents. |                                                     |

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
        "description": "Order #8008135",
        "price": {
          "amount": 995,
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
          "weight": 5000
        },
        "items": [
          {
            "sku": "123456789",
            "description": "OnePlus X",
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
        "synced_at": 1504801719
      },
      "relationships": {
        "service_options": {
          "data": [
            {
              "type": "service-options",
              "id": "4c675b1a-516c-4410-abff-d237fd45bcd0",
              "links": {
                "self": "https://sandbox-api.myparcel.com/service-options/4c675b1a-516c-4410-abff-d237fd45bcd0"
              }
            }
          ],
          "links": {
            "related": "https://sandbox-api.myparcel.com/service-contracts/af5e65b6-a709-4f61-a565-7c12a752482f/options"
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
          ],
          "links": {
            "related": "https://sandbox-api.myparcel.com/shipments/0f621db6-d239-4ae9-b85d-8e97469b10ce/files"
          }
        }
      },
      "links": {
        "self": "https://sandbox-api.myparcel.com/shipments/7b808eee-bf1c-40cd-98f2-3c335a06417e"
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
        "description": "Order #8008135",
        "price": {
          "amount": 995,
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
          "weight": 5000
        },
        "items": [
          {
            "sku": "123456789",
            "description": "OnePlus X",
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
        "synced_at": 1504801719
      },
      "relationships": {
        "service_options": {
          "data": [
            {
              "type": "service-options",
              "id": "4c675b1a-516c-4410-abff-d237fd45bcd0",
              "links": {
                "self": "https://sandbox-api.myparcel.com/service-options/4c675b1a-516c-4410-abff-d237fd45bcd0"
              }
            }
          ],
          "links": {
            "related": "https://sandbox-api.myparcel.com/service-contracts/af5e65b6-a709-4f61-a565-7c12a752482f/options"
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
          ],
          "links": {
            "related": "https://sandbox-api.myparcel.com/shipments/0f621db6-d239-4ae9-b85d-8e97469b10ce/files"
          }
        }
      },
      "links": {
        "self": "https://sandbox-api.myparcel.com/shipments/7b808eee-bf1c-40cd-98f2-3c335a06417e"
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
      "description": "Order #8008135",
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
        "incoterm": "DDU",
        "license_number": "218532158",
        "certificate_number": "12122121"
      },
      "register_at": 1504801719,
      "price": {
        "amount": 995,
        "currency": "EUR"
      },
      "barcode": "3SABCD0123456789",
      "tracking_code": "3SABCD0123456789",
      "tracking_url": "https://tracker.carrier.com/3SABCD0123456789",
      "created_at": 1504801719,
      "updated_at": 1504801719,
      "synced_at": 1504801719
    },
    "relationships": {
      "service_options": {
        "data": [
          {
            "type": "service-options",
            "id": "4c675b1a-516c-4410-abff-d237fd45bcd0"
          }
        ],
        "links": {
          "related": "https://sandbox-api.myparcel.com/service-contracts/af5e65b6-a709-4f61-a565-7c12a752482f/options"
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
        ],
        "links": {
          "related": "https://sandbox-api.myparcel.com/shipments/0f621db6-d239-4ae9-b85d-8e97469b10ce/files"
        }
      }
    },
    "links": {
      "self": "https://sandbox-api.myparcel.com/shipments/7b808eee-bf1c-40cd-98f2-3c335a06417e"
    }
  }
}
```
{{% /expand%}}

{{%expand "POST /shipments" %}}
Create a shipment.

**Scope**

- `shipments.manage`

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
      "description": "Order #8008135",
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
        "incoterm": "DDU",
        "license_number": "218532158",
        "certificate_number": "12122121"
      },
      "register_at": 1504801719
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
      "description": "Order #8008135",
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
        "incoterm": "DDU",
        "license_number": "218532158",
        "certificate_number": "12122121"
      },
      "register_at": 1504801719,
      "price": {
        "amount": 995,
        "currency": "EUR"
      },
      "barcode": "3SABCD0123456789",
      "tracking_code": "3SABCD0123456789",
      "tracking_url": "https://tracker.carrier.com/3SABCD0123456789",
      "created_at": 1504801719,
      "updated_at": 1504801719,
      "synced_at": 1504801719
    },
    "relationships": {
      "service_options": {
        "data": [
          {
            "type": "service-options",
            "id": "4c675b1a-516c-4410-abff-d237fd45bcd0"
          }
        ],
        "links": {
          "related": "https://sandbox-api.myparcel.com/service-contracts/af5e65b6-a709-4f61-a565-7c12a752482f/options"
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
        ],
        "links": {
          "related": "https://sandbox-api.myparcel.com/shipments/0f621db6-d239-4ae9-b85d-8e97469b10ce/files"
        }
      }
    },
    "links": {
      "self": "https://sandbox-api.myparcel.com/shipments/7b808eee-bf1c-40cd-98f2-3c335a06417e"
    }
  }
}
```
{{% /expand%}}

{{%expand "PATCH /shipments/{shipment_id}" %}}
Update an existing shipment.

**Scope**

- `shipments.manage`

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
      "description": "Order #8008135",
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
        "incoterm": "DDU",
        "license_number": "218532158",
        "certificate_number": "12122121"
      },
      "register_at": 1504801719,
      "price": {
        "amount": 995,
        "currency": "EUR"
      },
      "barcode": "3SABCD0123456789",
      "tracking_code": "3SABCD0123456789",
      "tracking_url": "https://tracker.carrier.com/3SABCD0123456789",
      "created_at": 1504801719,
      "updated_at": 1504801719,
      "synced_at": 1504801719
    },
    "relationships": {
      "service_options": {
        "data": [
          {
            "type": "service-options",
            "id": "4c675b1a-516c-4410-abff-d237fd45bcd0"
          }
        ],
        "links": {
          "related": "https://sandbox-api.myparcel.com/service-contracts/af5e65b6-a709-4f61-a565-7c12a752482f/options"
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
        ],
        "links": {
          "related": "https://sandbox-api.myparcel.com/shipments/0f621db6-d239-4ae9-b85d-8e97469b10ce/files"
        }
      }
    },
    "links": {
      "self": "https://sandbox-api.myparcel.com/shipments/7b808eee-bf1c-40cd-98f2-3c335a06417e"
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
