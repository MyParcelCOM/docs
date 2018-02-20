+++
title = "Shops"
description = "An account needs at least one shop to be able to create shipments."
weight = 16
+++

A user can have one or more shops and be able to read or manage attached resources like shipments. Shops contain specific information, settings, preferences and help organising shipments and automation rules.

## Shop

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/Shops)

Attribute       | Description
--------------- | -----------
name            | Shop name, useful for displaying to users.
coc             | Registration number at the Chamber of Commerce.
iban            | International Bank Account Number.
billing_address | [Address](/api/resources/addresses) object used for financial communication.
return_address  | [Address](/api/resources/addresses) object used as return address for new shipments.
created_at      | Unix timestamp when the shop was created.

Relation | Description
-------- | -----------
region   | Region defined by the country_code and region_code of the billing address.
