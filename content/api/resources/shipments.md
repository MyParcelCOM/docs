+++
title = "Shipments"
weight = 15
+++

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/Shipments)

The shipment resources are used to set all the relationships and additional information necessary to create shipment labels.   

## Relations
The shipment belongs to one [shop](/api/resources/shops) and can have multiples [status](/api/resources/statuses). There is always one latest [status](/api/resources/statuses) available.
The shipment can contain multiple [files](/api/resources/files) like the generated `label`.


## Retrieve shipments
To get all your shipments call the [GET /shipments](https://docs.myparcel.com/api-specification#/Shipments/get_shipments) endpoint

#### Sample request
```http
GET /shipments HTTP/1.1
Content-Type: application/vnd.api+json
```

#### Sample response
```http
HTTP/1.1 200 OK
Content-Type: application/vnd.api+json

{
  "data": [
      {
        "relationships": {
          "parent": {
            "data": {
              "id": "[id]",
              "type": "shipments"
            },
            "links": {
              "related": "/shipments/[id]"
            }
          },
          "service_options": {
            "data": [
              {
                "id": "[id]",
                "type": "service-options"
              }
            ]
          },
          "shop": {
            "data": {
              "id": "[id]",
              "type": "shops"
            },
            "links": {
              "related": "/shops/[id]"
            }
          },
          "files": {
            "data": [
              {
                "id": "[id]",
                "type": "files"
              }
            ],
            "links": {
              "related": "/shipments/[id]/files"
            }
          },
          "service_contract": {
            "data": {
              "id": "[id]",
              "type": "service-contracts"
            },
            "links": {
              "related": "/services/[id]/contracts/[id]"
            }
          },
          "status": {
            "data": {
              "id": "[id]",
              "type": "shipment-statuses"
            },
            "links": {
              "related": "/shipments/[id]/statuses/[id]"
            }
          }
        },
        "attributes": {
          "insurance": "",
          "physical_properties_verified": {
            "volume": 22.5,
            "width": 300,
            "length": 500,
            "weight": 5000,
            "height": 150
          },
          "pickup_location": {
            "code": "123456",
            "address": ""
          },
          "description": "order #8008135",
          "created_at": 1504801719,
          "recipient_address": {
            "city": "Cardiff",
            "last_name": "Doe",
            "country_code": "GB",
            "street_1": "Some road",
            "street_2": "Room 3",
            "street_number": 17,
            "company": "Acme Jewelry Co.",
            "phone_number": "+31 234 567 890",
            "street_number_suffix": "A",
            "postal_code": "1GL HF1",
            "first_name": "John",
            "email": "john@doe.com",
            "region_code": "NIR"
          },
          "tracking_code": "3SABCD0123456789",
          "sender_address": "",
          "updated_at": 1504801719,
          "price": {
            "amount": 995,
            "currency": "EUR"
          },
          "customs": {
            "non_delivery": "return",
            "content_type": "merchandise",
            "incoterm": "DDU",
            "invoice_number": "9000",
            "items": [
              {
                "quantity": 2,
                "description": "OnePlus X",
                "origin_country_code": "GB",
                "sku": "123456789",
                "item_value": "",
                "hs_code": "8517.12.00"
              }
            ]
          },
          "barcode": "3SABCD0123456789",
          "tracking_url": "https://tracker.carrier.com/3SABCD0123456789",
          "physical_properties": {
            "volume": 22.5,
            "width": 300,
            "length": 500,
            "weight": 5000,
            "height": 150
          },
          "synced_at": 1504801719
        },
        "links": {
          "self": "/shipments/[id]"
        },
        "id": "[id]",
        "type": "shipments"
      }
    ],
}
```

### Filters
You can filter the shipments on a the query parameters `search` and `shop_id`.
If you add these filters the call would look something like this:

```http
GET /regions?filter[search]=Some road HTTP/1.1
Content-Type: application/vnd.api+json
```

| Parameter         | Type  | value     | Description        |
| ----------------- |:----- |:--------- |:------------------ |
| {search}          | query | (string)  | Search string you want to look for in the `description` and `recipient_address` fields of the shipment. |
| {shop_id}         | query | (string)  | The id the shipments need to belong to. |
