+++
title = "Regions"
description = "All available regions with their region code and country code to easily filter available services."
weight = 14
+++

Regions are geographical areas arranged in a tree-like structure with "Earth" being the root region. Countries are regions with a non-empty `country_code`. Carriers can offer their services in any region. Shipment addresses should always contain a `country_code` and a `region_code` from a region defined as a country.

## Region

{{< icon fa-file-text-o >}}[API specification](https://api-specification.myparcel.com/#tag/Regions)

Attribute    | Description
------------ | -----------
country_code | A two letter country code, if the region is a country.
region_code  | A tree letter region code, if the region is within a country.
currency     | The default currency used in this region.
name         | Region name, useful for displaying to users.
category     | Present if the region is part of a common geographical group.

Relationship | Description
------------ | -----------
parent       | The parent region in the region tree.

## Retrieve regions

For an example request and response, check our API specification:<br>
{{< icon fa-file-text-o >}}[GET /regions](https://api-specification.myparcel.com/#tag/Regions/paths/~1regions/get)

### Parameters

You can filter the regions on a parent, country_code, region_code, name and postal_code.
If you add these filters the request would look something like this:

```http
GET /regions?filter[country_code]=GB&filter[region_code]=SCT HTTP/1.1
```

Parameter    | Type  | Value   | Description
------------ | ----- | ------- | -----------
parent       | query | string  | The id of the parent region.
country_code | query | string  | A two letter country code.
region_code  | query | string  | A tree letter region code.
name         | query | string  | A region name.
postal_code  | query | string  | A postal code.


{{% notice note %}}
If a postal code exists in more than one country, multiple regions are returned. The `postal_code` filter
can be used in combination with the `country_code` filter to get more specific results.
{{% /notice %}}
