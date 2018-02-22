+++
title = "Services"
description = "All services provided by the carriers, possibly filtered on a specific region."
weight = 9
+++

Services are provided by [carriers](/api/resources/carriers/) and can be used to send [shipments](/api/resources/shipments). Services are offered from a specific region to a specific region. To limit the number of services, several filters can be included as parameters:

- `filter[package_type]`
- `filter[carrier]`
- `filter[region_from]`
- `filter[region_to]`

## Service

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/Services)

Attribute       | Description
--------------- | -----------
name            | Service name, useful for displaying to users.
package_type    | Parcel, letterbox, letter or unstamped.
delivery_days   | Textual representation of days of the week this service delivers shipments.
transit_time    | The minimum and maximum time it takes to deliver the shipment.
handover_method | Available methods to hand the shipment to the carrier.
rating          | Generic rating which indicates a combination of popularity, price and quality.

Relationship | Description
------------ | -----------
carrier      | Carrier offering the service.
region_from  | Region in which this service is available.
region_to    | Region where shipments can be delivered.
