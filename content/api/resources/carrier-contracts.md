+++
title = "Carrier Contracts"
description = "Multiple contracts can exist for a single carrier. The carrier-contracts resource represents one of these contracts."
weight = 10
+++

A carrier contract is a representation of a contract with a carrier. It has relationships with [service_contracts](/api/resources/carrier-contracts/), which hold all price and available option attributes.

## Carrier Contract

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/CarrierContracts)

Attribute   | Description
----------- | -----------
name        | The name given to this specific contract for easier identification.
currency    | The currency in which all prices with the carrier have been agreed on.
status      | The current status of the contract. This is "pending" by default and changes once the credentials have been verified to either "active" or "invalid".
credentials | A json value containing the credentials used to communicate with the carrier. This should be in the format as described in the `credentials_format` property of a [carrier](/api/resources/carriers).

## Status

When creating a new carrier contract, its status will be "pending". The status will be updated once the API has tried to verify the credentials. Once the verification has succeeded, the status will change to "active" or "invalid" if the API was unable to verify the credentials.

When at any point the credentials get updated, the status will go back to "pending" until the API has verified the credentials.

Once the status is "active" anyone who is authorized to update the carrier contract can change it to "inactive" or back to "active". These are the only two statuses that can be adjusted by a user. Only the API can change the status to "pending" and "invalid". These statuses can not be altered by a user.
