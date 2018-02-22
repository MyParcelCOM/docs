+++
title = "Service Options"
description = "Various options which are available for different carrier services in our API."
weight = 13
+++

Service options can be added to a [shipment](/api/resources/shipments). The added price depends on the selected [service contract](/api/resources/service-contracts/). Options are a generic resource since many carriers offer the same options, like "delivery on saturday".

## Service Option

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/ServiceOptions)

Attribute | Description
--------- | -----------
name      | Option name, useful for displaying to users.
category  | Category like `delivery-day` or `handover-method`, useful to filter on and display options in groups.
code      | Option code, which will be used in our request to the carrier.
