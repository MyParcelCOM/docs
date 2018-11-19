+++
title = "Addresses"
description = "A commonly used model structure that represents an address."
weight = 16
+++

Technically, an address is not a resource, but it is often used withing our API and follows the
following structure:

| Attribute            | Type    | Description                                                                                                                    | Required |
|----------------------|---------|--------------------------------------------------------------------------------------------------------------------------------|----------|
| first_name           | string  | First name of optionally related contact                                                                                       | ✓        |
| last_name            | string  | Last name of optionally related contact, including any insertions                                                              | ✓        |
| street_1             | string  | First address line.                                                                                                            | ✓        |
| street_2             | string  | Second address line.                                                                                                           |          |
| postal_code          | string  | Postal code                                                                                                                    | ✓        |
| city                 | string  | City                                                                                                                           | ✓        |
| country_code         | string  | Country code in [ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) ([see regions](/api/resources/regions)) | ✓        |
| street_number        | integer | House number                                                                                                                   |          |
| street_number_suffix | integer | House number suffix                                                                                                            |          |
| region_code          | string  | Code of a region ([see regions](/api/resources/regions))                                                                       |          |
| company              | string  | Company name                                                                                                                   |          |
| email                | string  | Email address of optionally related contact                                                                                    |          |
| phone_number         | string  | Phone number of optionally related contact                                                                                     |          |

## Examples

### Minimal address

```json
{
  "first_name": "Sherlock",
  "last_name": "Holmes",
  "street_1": "Baker Street 221B",
  "postal_code": "NW1 6XE",
  "city": "London",
  "country_code": "GB"
}
```

### Full address

```json
{
  "first_name": "Sherlock",
  "last_name": "Holmes",
  "street_1": "Baker Street",
  "street_2": "Marylebone",
  "postal_code": "NW1 6XE",
  "city": "London",
  "country_code": "GB",
  "street_number": 221,
  "street_number_suffix": "B",
  "region_code": "ENG",
  "company": "Holmes Investigations",
  "email": "sherlock@holmes.inc",
  "phone_number": "+31 234 567 890"
}
```
