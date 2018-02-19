+++
title = "Carriers"
weight = 2
+++

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/Carriers)

A carrier resource in this API represents one of the many postal carriers that MyParcel.com work with to provide you with the best [contracts](/api/resources/carrier-contracts).
The list of postal carriers we supported is always growing, to get an updated list of what carriers we support this resource is available.

## Relations
A carrier can support multiple [services](/api/resources/services) from the following types: `parcel`, `letter`, `letterbox`, `unstamped`.
If you call a service it will contain a relationship with the `carrier` that it belongs to.
A carrier can also have multiple [pickup and dropoff locations(PUDO)](/api/resources/carrier-pudo-locations/) that represent an location that can set to to a shipment as its pickup or dropoff location.
The carrier can also own multiple [contracts](/api/resources/carrier-contracts/) when you call the [contracts endpoint](/api/resources/carriers/#retrieve-carrier-contracts) you wil get a subset of the contracts you are permitted to use.

## Retrieving carriers
To get all the available carriers call the [GET /carriers](https://docs.myparcel.com/api-specification#/Carriers/get_carriers) endpoint.
If you just want one specific carrier you will need the carrier id so you can call it with the [GET /carriers/{carrier-id}](https://docs.myparcel.com/api-specification#/Carriers/get_carriers__carrier_id_) endpoint.

#### Sample request
```http
GET /carriers HTTP/1.1
Content-Type: application/vnd.api+json
```

#### Sample response
```http
HTTP/1.1 200 OK
Content-Type: application/vnd.api+json

{
  "data": [
    {
      "type": "carriers",
      "id": "[carrier-id]",
      "attributes": {
        "name": "[carrier-name]"
      }
    }
  ],
  "meta": {
    "total_pages": 1,
    "total_records": 1
  },
  "links": {
    "self": "/carriers?page[number]=3&page[size]=30",
  }
}
```

### Attributes
The carrier has an `id` for reference and can contains the following additional attributes:

| Name        | 	Type           | Description  | Always present  |
| ------------- |:------------- |:----- |-----:|
| name      | (string) | The name of the carrier | ✓  |


### Parameter
| Parameter        | 	Type           | 	value           | Description  | Required  |
| ------------- |:------------- |:------------- |:----- |:----- |
| {carrier-id}      | path | (string) | To retrieve one specific carrier. | Only for one specific carrier  | 

## Retrieve carrier contracts
To get all the available carriers contracts call the [GET /carriers/{carrier_id}/contracts](https://docs.myparcel.com/api-specification#/Carriers/get_carriers__carrier_id__contracts) endpoint
This will just have the `currency` used for this contract and a relation to the `carrier` it belongs to and the actual [carrier contract](/api/resources/carrier-contracts/).

#### Sample request
```http
GET /carriers/{carrier_id}/contracts HTTP/1.1
Content-Type: application/vnd.api+json
```

#### Sample response
```http
HTTP/1.1 200 OK
Content-Type: application/vnd.api+json

{
  "data": [
    {
      "type": "carriers",
      "id": "[carrier-id]",
      "attributes": {
        "currency": "EUR"
      }
    },
    "relationships": {
      "carrier": {
        "data": {
          "type": "carriers",
          "id": "[carrier-id]"
        },
        "links": {
          "related": "/carriers/[carrier-id]"
        }
      },
      "service_contracts": {
        "data": [
          {
            "type": "service-contracts",
            "id": "[service-contract-id]",
            "links": {
              "related": "/services/[service-id]/contracts/[service-contract-id]"
            }
          }
        ]
      }
    }
  ],
  "meta": {
    "total_pages": 1,
    "total_records": 1
  },
  "links": {
    "self": "/carriers?page[number]=3&page[size]=30",
  }
}
```

### Attributes
The carrier has an `id` for reference and can contains the following additional attributes:

| Name        | 	Type           | Description  | Always present  |
| ------------- |:------------- |:----- |-----:|
| currency      | (string) | The currency used by this carrier | ✓  |
