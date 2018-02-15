+++
title = "Regions"
weight = 8
+++

<em class="fa fa-fw fa-file-text-o"></em>[API specification](https://docs.myparcel.com/api-specification#/Regions)

The regions are MyParcel.com created locations that point to a geological area that can be restricted by `country code` or `region code`.

## Relations
All regions are connected via parent-child relationships.
Regions that have the `country code` set can be used to create shipments.

## Retrieve regions
To get all the available regions call the [GET /regions](https://docs.myparcel.com/api-specification#/Carriers/get_carriers__carrier_id__contracts) endpoint

#### Sample request
```http
GET /regions HTTP/1.1
Content-Type: application/vnd.api+json
```

#### Sample response
```http
HTTP/1.1 200 OK
Content-Type: application/vnd.api+json

{
  "data": [
    {
      "type": "regions",
      "id": "[regin-id]",
      "attributes": {
        "country_code": "GB",
        "region_code": "NIR",
        "currency": "EUR",
        "name": "The Netherlands"
      },
      "relationships": {
        "parent": {
          "data": {
            "type": "regions",
            "id": "[regin-id]"
          },
          "links": {
            "related": "http://localhost:8080/v1/regions/[regin-id]"
          }
        }
      },
      "links": {
        "self": "http://localhost:8080/v1/regions/[regin-id]"
      }
    }
  ]
}
```

### Filters
You can filter the regions on a the query parameters parent, country_code, region_code and name.
If you add these filters the call would look something like this:

```http
GET /regions?filter[country_code]=GB&filter[region_code]=SCT HTTP/1.1
Content-Type: application/vnd.api+json
```

| Parameter         | Type  | value     | Description        |
| ----------------- |:----- |:--------- |:------------------ |
| {parent}          | query | (string)  | The id of the parent region.   |
| {country_code}    | query | (string)  | The two letter country code. |
| {region_code}     | query | (string)  | The tree letter region code. |
| {name}            | query | (integer) | The region name. |
