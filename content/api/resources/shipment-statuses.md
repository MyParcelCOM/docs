+++
title = "Shipment Statuses"
description = "Statuses which are attached to shipments, containing carrier status details."
weight = 24
+++

A shipment status is basically a wrapper to combine and structure information from different sources, without losing valuable information.
It consists of one of our generic [statuses](/api/resources/statuses) in most cases combined with one or more of the many carrier specific statuses.

Please read the page on [retrieving shipment statuses](/api/retrieve-shipment-statuses) for a detailed explanation and example of this resource.

## Shipment Status

{{< icon fa-file-text-o >}}[API specification](https://api-specification.myparcel.com/#tag/Shipments/paths/~1shipments~1{shipment_id}~1statuses/get)

Attribute        | Description
---------------- | -----------
carrier_statuses | an array of [carrier-statuses](/api/resources/shipment-statuses/#carrier-status) (empty when the shipment is not yet registered)
errors           | an array of [error objects](http://jsonapi.org/format/#errors) when the carrier returned errors during shipment registration

Relationship | Type                                   | Description
------------ | -------------------------------------- | -----------
shipment     | [shipments](/api/resources/shipments) | The shipment having this status.
status       | [statuses](/api/resources/statuses)   | Our generic status belonging to this carrier specific status.

### Carrier Status

Attribute   | Description
----------- | -----------
code        | Status code we received from the carrier.
description | Description of the status code we received from the carrier.
assigned_at | Unix timestamp of the status update according to the carrier.
