+++
title = "Carrier PUDO locations"
description = "The pickup and dropoff locations offered by the carriers."
weight = 4
+++

Carrier PUDO locations are locations where:

- your shipments can be picked up once delivered (Pick Up)
- you can drop the shipments you want to send (Drop Off)

## Pickup Dropoff Location

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/Carriers/get_carriers__carrier_id__pickup_dropoff_locations__country_code___postal_code_)

Attribute     | Description
------------- | -----------
code          | Unique identifier used by the carrier.
address       | [Address](/api/resources/addresses) object.
opening_hours | List of objects containing the days and hours on which the location is accessible.
position      | Object holding the latitude, longitude and distance from the given geographical location.
categories    | The location can function as a `pick-up` or `drop-off` location, or both.

Relationship | Description
------------ | -----------
carrier      | Carrier offering the location.

### Parameters
With the required path parameters you can specify the geographical position to start searching for locations. You can specify a more accurate position using optional query parameters.

Parameter     | Type  | Value  | Description                       | Required
------------- | ----- | ------ | --------------------------------- | --------
carrier_id    | path  | string | To retrieve one specific carrier. | ✓
country_code  | path  | string | The country code.                 | ✓
postal_code   | path  | string | The postal code.                  | ✓
street        | query | string | The street name.                  |
street_number | query | string | The street number.                |
