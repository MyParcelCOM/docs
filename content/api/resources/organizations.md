+++
title = "Organizations"
description = "A user needs at least one organization to be able to create shipments."
weight = 13
+++

A user can have one or more organizations and be able to read or manage attached resources like shops and contracts.

## Attributes

{{< icon fa-file-text-o >}}[API specification](https://api-specification.myparcel.com/#tag/Organizations)

Attribute                   | Type                                                | Description                                                                | Required
--------------------------- | --------------------------------------------------- | -------------------------------------------------------------------------- | --------
name                        | string                                              | Name of the organization.                                                  | ✓
company_registration_number | string                                              | Chamber of Commerce number of the organization.                            |
vat_number                  | string                                              | VAT identification number of the organization.                             |
eori_number                 | string                                              | EORI number used as `sender_tax_number` when creating shipments to the EU. |
voec_number                 | string                                              | VOEC number used as `sender_tax_number` when creating shipments to Norway. |
tax_identification_numbers  | array of [tax-identification-numbers](/api/resources/common-objects/tax-identification-numbers) | Tax ID numbers to use when sending an international shipment. Any numbers passed on the shipment will overwrite numbers of the same `type` and `country_code` defined on the organization of this shipment’s shop during registration. | 
currency                    | string                                              | Currency for invoicing purposes.                                           |
billing_address             | [address](/api/resources/common-objects/addresses/) | The address used for invoicing purposes.                                   |
created_at                  | integer                                             | Unix timestamp when the organization was created.                          |

Relationship | Type                                                                               | Description                             | Required
------------ | ---------------------------------------------------------------------------------- | --------------------------------------- | --------
broker       | [brokers](https://api-specification.myparcel.com/#tag/Brokers/paths/~1brokers/get) | The broker this organization belongs to | ✓
