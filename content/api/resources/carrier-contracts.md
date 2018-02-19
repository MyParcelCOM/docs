+++
title = "Carrier Contracts"
weight = 3
+++

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/CarrierContracts)

The resource carrier contracts combines a [carrier](/api/resources/carriers/) with a [service contract](/api/resources/service-contracts/).
The carrier contract only contains the `currency` attribute, other data like pricing and options is linked throw the [service contract](/api/resources/service-contracts/).

## Relations
The carrier contract belongs to one [carrier](/api/resources/carriers/) and can have multiple [service contracts](/api/resources/service-contracts/).

## Retrieve carrier contracts
To get all the contracts of a carrier call the [GET /carrier-contracts/{carrier_contract_id}](https://docs.myparcel.com/api-specification#/CarrierContracts/get_carrier_contracts__carrier_contract_id_) endpoint.
This will contain the contract `currency` used for all the prices for the [services](/api/resources/services) under this contract.

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
