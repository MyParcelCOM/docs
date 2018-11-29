+++
title = "Carriers"
description = "The postal carriers that MyParcel.com works with and are available for your region."
weight = 2
+++

A carrier resource represents one of the many postal carriers that MyParcel.com works with to provide you with a broad range of [contracts](/api/resources/carrier-contracts). This endpoint can be used to get a list of the postal carriers we support that the client can access.
Carriers are included as relationships of [services](/api/resources/services/), [contracts](/api/resources/contracts/) and [pickup dropoff locations](/api/resources/pickup-dropoff-locations/).

## Carrier

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/Carriers)

Attribute | Description
--------- | -----------
name      | Carrier name, useful for displaying to users.
credentials_format | The format of credentials for this carrier's contracts described using [JSON Schema](https://json-schema.org/).
