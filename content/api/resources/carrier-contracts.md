+++
title = "Carrier Contracts"
description = "The contracts offered by the carriers."
weight = 3
+++

A carrier contract combines a [carrier](/api/resources/carriers/) with [service contracts](/api/resources/service-contracts/). It only contains a currency attribute, other data like pricing and options is linked through the [service contract](/api/resources/service-contracts/). While this looks like a pretty empty resource, it also contains all necessary credentials to communicate with this carrier. These credentials are write-only and will never be returned, they are only used by our internal systems.

## Carrier Contract

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/CarrierContracts)

Attribute         | Description
----------------- | -----------
currency          | The currency used for all prices for the attached service contracts.

Relation          | Description
----------------- | -----------
carrier           | Carrier offering the contract.
service_contracts | Contracts for services offered by the carrier, which define prices and options.

## Retrieve carrier contracts
To get all the contracts of a carrier call the [GET /carrier-contracts/{carrier_contract_id}](https://docs.myparcel.com/api-specification#/CarrierContracts/get_carrier_contracts__carrier_contract_id_) endpoint.

#### Sample request
```http
GET /carrier-contracts/{carrier_contract_id} HTTP/1.1
Content-Type: application/vnd.api+json
```

#### Sample response
```http
HTTP/1.1 200 OK
Content-Type: application/vnd.api+json

{
  "data": {
      "type": "carrier-contracts",
      "id": "[carrier-contract-id]",
      "attributes": {
        "currency": "EUR"
      },
      "relationships": {
        "carrier": {
          "data": {
            "type": "carriers",
            "id": "[carrier-id]"
          },
          "links": {
            "related": "http://localhost:8080/v1/carriers/[carrier-id]"
          }
        },
        "service_contracts": {
          "data": [
            {
              "type": "service-contracts",
              "id": "[service-contracts-id]",
              "links": {
                "related": "http://localhost:8080/v1/services/[service-id]/contracts/[contract-id]"
              }
            }
          ]
        }
      }
    }
}
```
