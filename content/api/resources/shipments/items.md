+++
title = "Items"
description = "Information about the contents of the shipment."
weight = 2
+++

Information about the contents of the shipment. Items can be included even if no customs information is required.

## Attributes

| Attribute           | Type                                           | Description                                                                    | Required
|---------------------|------------------------------------------------|--------------------------------------------------------------------------------|---------
| description         | string                                         | Description of the item or it's content.                                       | ✓
| quantity            | integer                                        | Amount of these items present in the shipment.                                 | ✓
| image_url           | string                                         | A link to an image of the item.                                                |
| item_value          | [price](/api/resources/common-objects/prices/) | Value of a single item. Should be multiplied by quantity to get total value.   | (only for international shipments)
| item_weight         | integer                                        | Weight of a single item. Should be multiplied by quantity to get total weight. |
| hs_code             | string                                         | Harmonized System code used by customs.                                        |
| origin_country_code | string                                         | The country code in [ISO 3166-1 alpha-2](https://www.iso.org/obp/ui/#search/code/) format. | (only for international shipments)
| sku                 | string                                         | Unique identifier, often the Stock Keeping Unit.                               | 
