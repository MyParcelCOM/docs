+++
title = "Statuses"
description = "Various statuses which are available for different resources in our API."
weight = 17
+++

Statuses are informative states which some resource can have attached as a relationship.

## Status

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/Statuses)

Attribute     | Description
------------- | -----------
code          | Status code, useful for programmers.
resource_type | Resources which can have this status attached.
level         | If the status is pending, success or failed.
name          | Status name, useful for displaying to users.
description   | Description of the current state of the resource.
