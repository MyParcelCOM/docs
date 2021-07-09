+++
title = "Carrier specific requirements"
description = "Carrier specific shipment requirements for all carriers."
weight = 3
+++

The MyParcel.com API is built to communicate with many carriers.
However, each carrier has their own restrictions and requirements for creating shipments. 
Below you will find a list of carrier specific requirement and restriction that the currently integrated carriers have for a shipment. 

- [bpost](#bpost)
- [DHL Express](#dhl-express)
- [DPD](#dpd)
- [Hermes](#hermes)
- [PostNL C2C](#postnl-c2c)

## bpost

Attribute              | Requirement
---------------------- | -----------
`company`              | Max 40 characters.
`first_name`           | Max 40 characters together with `last_name`.
`last_name`            | Max 40 characters together with `first_name`.
`street_1`             | Max 40 characters together with `street_number` and `street_number_suffix`.
`postal_code`          | Max 8 characters.
`city`                 | Max 40 characters.
`email`                | Max 50 characters.
`phone_number`         | Max 20 characters.

## DHL Express
Attribute              | Requirement
---------------------- | -----------
`first_name`           | Max 45 characters together with `last_name`.
`last_name`            | Max 45 characters together with `first_name`.
`street_1`             | Max 35 characters together with `street_number` and `street_number_suffix`.
`street_2`             | Max 35 characters.
`postal_code`          | Max 12 characters.
`city`                 | Max 35 characters.
`email`                | Max 50 characters.
`phone_number`         | Max 25 characters.

## DPD
Attribute              | Requirement 
---------------------- | -----------
`first_name`           | Max 25 characters together with `last_name`.
`last_name`            | Max 25 characters together with `first_name`.
`street_1`             | Max 35 characters together with `street_number` and `street_number_suffix`.
`street_2`             | Max 35 characters.
`postal_code`          | Max 8 characters.
`city`                 | Max 35 characters.
`email`                | Max 50 characters.
`phone_number`         | Max 15 characters.
`recipient_address`    | Needs to be an existing address. Address validation is performed when creating the shipment. An incorrect postal code, for example, will cause the shipment registration process to fail.
`hs_code`              | Min 8 characters.

## Hermes
Attribute              | Requirement
---------------------- | -----------
`first_name`           | Max 50 characters.
`last_name`            | Max 50 characters.
`street_1`             | Max 32 characters.
`street_number`        | Max 10 characters. Dispatches to The Netherlands (NL) must contain a `street_number`.
`street_number_suffix` | Max 32 characters.
`street_2`             | Max 32 characters.
`postal_code`          | Max 10 characters.
`city`                 | Max 32 characters.
`email`                | Max 80 characters.
`phone_number`         | Max 15 characters.
`description`          | Max 20 characters.
`currency`             | Only `EUR`, `GBP`, `USD` are supported.
`hs_code`              | Max 10 characters.

## PostNL C2C

Attribute              | Requirement
---------------------- | -----------
`company`              | Max 35 characters.
`first_name`           | Max 20 characters.
`last_name`            | Max 32 characters.
`street_1`             | Max 32 characters.
`street_number`        | Max 5 characters.
`street_number_suffix` | Max 7 characters.
`city`                 | Max 25 characters.
`phone_number`         | Max 14 characters.
