+++ 
title = "Tax Identification Numbers"
description = "An object that is used on Organizations and Shipments to store tax identification numbers."
weight = 3 
+++

Tax identification numbers (tax ID numbers) are not a resource on itself, but rather an object shared among shipments and organizations.  
It has the following structure:

Property        | Value     | Description                       | Required
--------------- | --------- | --------------------------------- | --------
type            | string enum: <br> - `vat` <br> - `ioss` <br> - `eori` | The type of tax number. | ✓
country_code    | string    | Country code in ISO 3166-1 alpha-2 ([see regions](/api/resources/regions)). This country code specifies where the tax identification number originates from. | ✓
number          | string    | The tax number itself. | ✓
description     | string    | Optional description of the tax number for personal reference. |

### Using tax ID numbers

When shipping internationally, tax identification numbers may be required. These numbers can be stored on
a [shipment](/api/resources/shipments) individually, using the `sender_tax_identification_numbers`
and `recipient_tax_identification_numbers` attributes.

Usually, the same sender Tax ID numbers apply across most shipments sent by the same [shop](/api/resources/shops), or
even for all shops related to an [organization](/api/resources/organizations). Therefore, it is possible to define these
numbers on an organization using the `tax_identification_numbers` attribute. This will cause all shipments that are
created by a shop related to this organization to get these tax ID numbers set as `sender_tax_identification_numbers` when
registered with the carrier. The `country_code` property is used to decide which numbers to use when sending from/to certain countries.
Multiple tax ID numbers of the same `type` can be stored on the organization, as long as they have a different `country_code` property.

There will be scenario's where a shipment needs a tax ID number that is different from the one defined on the
organization. That is why during registration, the `sender_tax_identification_numbers` defined on the shipment have
priority over the ones defined on the organization. This prioritization is done using the `type` and `country_code`
properties of the tax ID numbers, meaning that when the organization has a tax ID number with same `type`
and `country_code` as a tax ID number already defined in the shipment's `sender_tax_identification_numbers` attribute,
it will not overwrite it.

#### Example
Imagine an organization with the following substructure:
```json
{
  "type": "organizations",
  "id": "3f013256-b90c-4fff-a934-6a248fcd44ee",
  "attributes": {
    "...":  "...",
    "tax_identification_numbers": [
      {
        "country_code": "GB",
        "number": "XI123456789",
        "description": "Eori XI number for Northern Ireland",
        "type": "eori"
      },
      {
        "country_code": "NL",
        "number": "NL5123123123",
        "description": "Dutch EORI number",
        "type": "eori"
      },
      {
        "country_code": "GB",
        "number": "GB18312371247",
        "description": "My IOSS number for GB",
        "type": "ioss"
      }
    ]
  },
  "relationships": {
    "...": "..."
  }
}
```

Now let's make a shipment with the following substructure:

```json
{
  "type": "shipments",
  "attributes": {
    "recipient_address": {
      "street_1": "Hoofdweg 679",
      "street_number": 679,
      "postal_code": "2131 BC",
      "city": "Hoofddorp",
      "country_code": "NL",
      "first_name": "Sherlock",
      "last_name": "Holmes",
      "company": "Holmes Investigations",
      "email": "s.holmes@holmesinvestigations.com",
      "phone_number": "+31 234 567 890"
    },
    "...": "...",
    "sender_tax_identification_numbers": [
      {
        "country_code": "GB",
        "number": "TI97167891123",
        "description": "eBay IOSS number",
        "type": "ioss"
      }
    ]
  },
  "relationships": {
    "shop": {
      "data": {
        "type": "shops",
        "id": "de140984-bf5e-4eb7-953e-e844a64d45a2"
      }
    }
  }
}
```
Let's assume this shipment's shop is related to the organization defined above.
During registration, the shipment will get the organization's tax ID numbers, but only the ones that are not already defined on the shipment.
We see that the shipment has a tax ID number with `type` "ioss" and `country_code` "GB" in it's `sender_tax_identification_numbers` attribute.
The organization also has a number with this `type` and `country_code`, but because it is already defined on the shipment, it will not overwrite it. 
The other tax ID numbers from the organization will be set on the shipment, because they are not yet defined, and so these numbers are communicated to the carrier during registration:
```json
{
  "...": "...",
  "sender_tax_identification_numbers": [
    {
      "country_code": "GB",
      "number": "XI123456789",
      "description": "Eori XI number for Northern Ireland",
      "type": "eori"
    },
    {
      "country_code": "NL",
      "number": "NL5123123123",
      "description": "Dutch EORI number",
      "type": "eori"
    },
    {
      "country_code": "GB",
      "number": "TI97167891123",
      "description": "eBay IOSS number",
      "type": "ioss"
    }
  ]
}
```

