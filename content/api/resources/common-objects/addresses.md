+++
title = "Addresses"
description = "A commonly used model structure that represents an address."
weight = 16
+++

Technically, an address is not a resource, but it is often used withing our API and follows the
following structure:

Attribute            |  Value  | Description                                                                | Required
-------------------- | ------- | -------------------------------------------------------------------------- | --------
street_1             | string  | First address line.                                                        | ✓
street_2             | string  | Second address line.                                                       |
street_number        | integer | House number                                                               |
street_number_suffix | integer | House number suffix                                                        |
postal_code          | string  | Postal code                                                                | ✓
city                 | string  | City                                                                       | ✓
region_code          | string  | Code of a region ([see regions](/api/resources/regions))                   |
country_code         | string  | Country code in ISO 3166-1 alpha-2 ([see regions](/api/resources/regions)) | ✓
company              | string  | Company name                                                               |
first_name           | string  | First name of optionally related contact                                   | ✓
last_name            | string  | Last name of optionally related contact, including any insertions          | ✓
email                | string  | Email address of optionally related contact                                |
phone_number         | string  | Phone number of optionally related contact                                 |
