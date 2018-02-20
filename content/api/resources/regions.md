+++
title = "Regions"
description = "All available regions with their region code and country code to easily filter available services."
weight = 8
+++

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/Regions)

Regions are geographical areas arranged in a tree-like structure with "Earth" being the root region. Countries are regions with a non-empty `country_code`. Carriers can offer their services in any region. Shipment addresses should always contain a `country_code` and a `region_code` from a region defined as a country.

## Region

Attribute    | Description
------------ | -----------
country_code | A two letter country code, if the region is a country.
region_code  | A tree letter region code, if the region is within a country.
currency     | The default currency used in this region.
name         | Region name, useful for displaying to users.

Relation | Description
-------- | -----------
parent   | The parent region in the region tree.

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
      "id": "[region-id]",
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
            "id": "[region-id]"
          },
          "links": {
            "related": "http://localhost:8080/v1/regions/[region-id]"
          }
        }
      },
      "links": {
        "self": "http://localhost:8080/v1/regions/[region-id]"
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

Parameter    | Type  | Value   | Description
------------ | ----- | ------- | -----------
parent       | query | string  | The id of the parent region.
country_code | query | string  | A two letter country code.
region_code  | query | string  | A tree letter region code.
name         | query | integer | A region name.
