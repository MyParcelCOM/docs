+++
title = "Liability Coverages"
description = "Liability coverages that can be applied to a shipment."
weight = 12
+++

Liability coverages can be added to a shipment to cover shipments that contain valuable items.
Liability coverage resources are specific per [contract](/api/resources/contracts) and can cover multiple value ranges. 

{{% notice info %}}
Liability coverages are currently not offered as a product on custom contracts.
{{% /notice %}}

## Attributes

{{< icon fa-file-text-o >}}[API specification](https://api-specification.myparcel.com/#tag/LiabilityCoverages)

Attribute           | Type                                          | Description                                           | Required
------------------- | --------------------------------------------- | ----------------------------------------------------- | ----------
name                | string                                        | Name of the liability coverage.                       | ✓
price               | [price](/api/resources/common-objects/prices) | How much this particular liability coverage costs.    | ✓
coverage_max        | [price](/api/resources/common-objects/prices) | Maximum value coverage of this liability coverage.    | ✓

Relationship        | Type                                          | Description                                                       | Required
------------------- | --------------------------------------------- | ----------------------------------------------------------------- | ----------
contract            | [contract](/api/resources/contracts)          | The contract that these liability coverages are available for.    | ✓

## Endpoints

{{%expand "GET /liability-coverages/{liability-coverage_id}" %}}

Retrieving a specific liability coverage.

**Scope**

Any of the following scopes:

- `shipments.manage`
- `organizations.manage`

**Request**

```http
GET /liability-coverages/{liability-coverage_id} HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/liability-coverages/5a7ef73a-ddea-11e9-8a34-2a2ae2dbcce4
```

**Response**

```json
{
  "data": {
    "type": "liability-coverages",
    "id": "5a7ef73a-ddea-11e9-8a34-2a2ae2dbcce4",
    "attributes": {
      "name": "Liability coverage up to GBP 250 value.",
      "price": {
        "amount": 995,
        "currency": "EUR"
      },
      "coverage_max": {
        "amount": 995,
        "currency": "EUR"
      }
    },
    "relationships": {
      "contract": {
        "data": {
          "type": "contracts",
          "id": "2cb32706-5762-4b96-9212-327e6afaeeff"
        },
        "links": {
          "related": "https://api.myparcel.com/contracts/2cb32706-5762-4b96-9212-327e6afaeeff"
        }
      }
    },
    "links": {
      "self": "https://api.myparcel.com/liability-coverages/5a7ef73a-ddea-11e9-8a34-2a2ae2dbcce4"
    }
  }
}
```

{{% /expand %}}

{{% notice tip %}}
To find out what the available liability coverages for a shipment are, the shipment's [contract](/api/resources/contract) resource should be retrieved
using the GET /contracts/{contract_id} endpoint. If the contract offers liability coverage, the available liability coverages resources will be listed as relationships on the contract.
