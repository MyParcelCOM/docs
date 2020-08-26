+++
title = "Adding liability coverage"
description = "How to add liability coverage to insure your parcel."
weight = 4
+++

Liability coverage can be added to a shipment to insure valuable goods when sending them through the MyParcel.com API.
It is important to cover the contents of a package to their actual value. 
Because of this, whenever liability coverage is available for a contract, it will often be available for different "value groups", covering a higher value for a higher price.

## When is liability coverage available?
At this moment, liability coverage is only available for contracts provided by MyParcel.com and not custom contracts.
To find out if liability coverage is available for a shipment and up to how much value can be covered, 
a call to the `GET /contracts/{contract_id}` endpoint should be made to retrieve the [contract](/api/resources/contracts) you intend to use with your shipment.
The API will respond with the contracts resource and if the contract has liability coverage available, 
it will be listed in the relationships in the response of the retrieved contract. 
For more general information about liability coverage, visit the MyParcel.com [knowledge base](https://help.myparcel.com/support/solutions/articles/16000079653-can-i-insure-my-shipments-).

```json
{
  "data": {
    "type": "contracts",
    "id": "2cb32706-5762-4b96-9212-327e6afaeeff",
    "attributes": {
      "name": "MyParcel.com contract",
      "currency": "EUR",
      "status": "active"
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
      "owner": {
        "data": {
          "type": "brokers",
          "id": "a294ee55-bc94-4890-b734-afd56c158f95"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/brokers/a294ee55-bc94-4890-b734-afd56c158f95"
        }
      },
      "liability_coverages": {
        "data": [
          {
            "type": "liability-coverages",
            "id": "5a7ef73a-ddea-11e9-8a34-2a2ae2dbcce4"
          }
        ]
      }
    }
  }
}
```

## Attaching liability coverage to a shipment
Attaching liability coverage to a shipment is quite easy. 
The same way that a contract, service, shop and service options are [attached to a shipment](/api/create-a-shipment/#shop-relationship), 
liability coverage can be passed as a relationship on a shipment. 
Note that only one liability coverage resource can be attached to a shipment at a time.
It is therefore important to choose the correct liability coverage for the value of your shipment.

{{% notice warning %}}
When attaching liability coverage to a `shipment`, make sure the `contract` relationship on the `liability coverage` corresponds to the `contract` relationship on the to-be-created `shipment`.
{{% /notice %}}

```json
{
  "data": {
    "type": "shipments",
    "attributes": {
      "...": "..."
    },
    "relationships": {
      "shop": {
        "data": {
          "type": "shops",
          "id": "35eddf50-1d84-47a3-8479-6bfda729cd99"
        }
      },
      "service": {
        "data": {
          "type": "services",
          "id": "af5e65b6-a709-4f61-a565-7c12a752482f"
        }
      },
      "contract": {
        "data": {
          "type": "contracts",
          "id": "448e55b3-0829-4783-a9ca-1078697cdb46"
        }
      },
      "liability_coverage": {
        "data": {
          "type": "liability-coverages",
          "id": "5a7ef73a-ddea-11e9-8a34-2a2ae2dbcce4"
        }  
      }
    }
  }
}
```
