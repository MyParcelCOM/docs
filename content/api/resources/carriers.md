+++
title = "Carriers"
description = "The postal carriers that MyParcel.com works with and are available for your region."
weight = 2
+++

A carrier resource represents one of the many postal carriers that MyParcel.com works with to provide you with a broad range of [contracts](/api/resources/carrier-contracts). This endpoint can be used to get a list of the postal carriers we support.
Carriers are included as relationships of [services](/api/resources/services/), [carrier contracts](/api/resources/carrier-contracts/) and [pickup dropoff locations](/api/resources/carrier-pudo-locations/).

## Carrier

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/Carriers)

Attribute | Description
--------- | -----------
name      | Carrier name, useful for displaying to users.

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
