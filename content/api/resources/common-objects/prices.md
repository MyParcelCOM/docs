+++
title = "Prices"
description = "A commonly used model structure that represents a price."
weight = 2
+++

Technically, a price is not a resource, but it is often used within our API and has the following structure:

Attribute | Value   | Description                       | Required
--------- | ------- | --------------------------------- | --------
amount    | integer | Price amount in cents/pence.      | ✓
currency  | string  | Currency code in ISO 4217 format. | ✓
