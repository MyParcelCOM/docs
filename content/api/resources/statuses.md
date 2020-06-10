+++
title = "Statuses"
description = "Various statuses which are available for different resources in our API."
weight = 17
+++

Statuses are informative states which some resource can have attached as a relationship. Our statuses are separate resources instead of an enumerable property on for example a shipment. This makes it possible to fetch an up to date list of all our statuses, including a description and level of success. If we used an enumerable property, adding a new status would require external code to be updated.

## Status

{{< icon fa-file-text-o >}}[API specification](https://api-specification.myparcel.com/#tag/Statuses)

Attribute     | Description
------------- | -----------
code          | Status code, which will be used in our request to the carrier.
resource_type | Resources which can have this status attached.
level         | If the status is pending, success or failed.
name          | Status name, useful for displaying to users.
description   | Description of the current state of the resource.
