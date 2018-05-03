+++
title = "Shipment Statuses"
description = "Statuses which are attached to shipments, containing carrier status details."
weight = 14
+++

A shipment status consists of one of our `Status` resources combined with one of the many carrier specific statuses.

## Shipment Status

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification/#/Shipments/get_shipments__shipment_id__statuses)

Attribute                  | Description
-------------------------- | -----------
carrier_status_code        | Status code we received from the carrier.
carrier_status_description | Description of the status code we received from the carrier.
carrier_timestamp          | Unix timestamp of this status according to the carrier.

Relationship | Description
------------ | -----------
shipment     | The shipment having this status.
status       | Our generic status belonging to this carrier specific status.
