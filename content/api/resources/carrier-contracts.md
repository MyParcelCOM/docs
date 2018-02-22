+++
title = "Carrier Contracts"
description = "The contracts offered by the carriers."
weight = 3
+++

A carrier contract combines a [carrier](/api/resources/carriers/) with [service contracts](/api/resources/service-contracts/). It only contains a currency attribute, other data like pricing and options is linked through the [service contract](/api/resources/service-contracts/). While this looks like a pretty empty resource, it also contains all necessary credentials to communicate with this carrier. These credentials are write-only and will never be returned, they are only used by our internal systems.

## Carrier Contract

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/CarrierContracts)

Attribute         | Description
----------------- | -----------
currency          | The currency used for all prices for the attached service contracts.

Relationship      | Description
----------------- | -----------
carrier           | Carrier offering the contract.
service_contracts | Contracts for services offered by the carrier, which define prices and options.
