+++
title = "Carrier PUDO locations"
weight = 4
+++

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/CarrierContracts)

Carrier PUDO locations are the locations where you can drop your shipments off to send it(dropoff) and locations where the shipments can be picked up once retrieved(pickup).

## Relations
The location belongs to one [carrier](/api/resources/carriers/).

## Retrieve carrier pickup and dropoff locations
To get all the available the pickup and dropoff locations of a carrier call the [GET /carriers/{carrier_id}/contracts](https://docs.myparcel.com/api-specification#/Carriers/get_carriers__carrier_id__pickup_dropoff_locations__country_code___postal_code_) endpoint.
This will contain the location `code` used as reference by the carrier, the opening hours, latitude/longitude position and the address.
It wil also have a reference to the [carrier](/api/resources/carriers).

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
        "code": "dpd123",
        "address": {
          "street_1": "Some road",
          "street_2": "Room 3",
          "street_number": 17,
          "street_number_suffix": "A",
          "postal_code": "1GL HF1",
          "city": "Cardiff",
          "region_code": "NIR",
          "country_code": "GB",
          "first_name": "John",
          "last_name": "Doe",
          "company": "Acme Jewelry Co.",
          "email": "john@doe.com",
          "phone_number": "+31 234 567 890"
        },
        "opening_hours": [
          {
            "day": "Monday",
            "open": "17:30",
            "closed": "17:30"
          }
        ],
        "position": {
          "latitude": 52.3050097,
          "longitude": 4.689905,
          "distance": 1337
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

### Parameter
With the two required path parameters country code and postal code you can specify which position you want set as the starting position for finding locations.

```http
GET /carriers/[carrier_id]/pickup-dropoff-locations/GB/1234AB HTTP/1.1
Content-Type: application/vnd.api+json
```

| Parameter     | Type            | value    | Description                       | Required  |
| ------------- |:--------------- |:-------- |:--------------------------------- |:--- |
| {carrier_id}  | path            | (string) | To retrieve one specific carrier. | ✓   | 
| {country_code}| path            | (string) | To retrieve one specific carrier. | ✓   | 
| {postal_code} | path            | (string) | The country code.                 | ✓   | 

### Filters
You can filter the locations further on a the query parameters street and street number.
If you add these filters the call would look something like this:

```http
GET /carriers/[carrier_id]/pickup-dropoff-locations/GB/1234AB?street=somestreet&street_number=17 HTTP/1.1
Content-Type: application/vnd.api+json
```

| Parameter         | Type  | value     | Description        | Required  |
| ----------------- |:----- |:--------- |:------------------ |:--------- |
| {street}          | query | (string)  | The street name.   |           | 
| {street_number}   | query | (integer) | The street number. |           | 
