+++
title = "Customs"
description = "Information required for the shipment to pass customs."
weight = 1
+++

Information required for international shipments to pass customs.

## Attributes

| Attribute          | Type                                                                                       | Description                                                                                                                                                | Required                                                                |
|--------------------|--------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| content_type       | string enum: <br>`gifts` <br>`documents` <br>`merchandise` <br>`sample_merchandise` <br>`returned_merchandise` | The type of items contained in the shipment.                                                                                                               | ✓                                                                       |
| non_delivery       | string enum: <br>`return` <br>`abandon`                                                            | What should be done with the shipment when delivery is not possible.                                                                                       | ✓                                                                       |
| incoterm           | string enum: <br>`DDP` <br>`DAP`                                                                   | Specify if the sender or receiver is responsible for import charges and risks. DDP (Delivered Duty Paid, sender) or DAP (Delivered At Place, receiver). | ✓                                                                       |
| invoice_number     | string                                                                                     | The number of the invoice attached to the package.                                                                                                         | Required for: <br>merchandise <br>sample_merchandise <br>returned_merchandise |
| license_number     | string                                                                                     | A license number related to shipment items if available.                                                                                                   |                                                                         |
| certificate_number | string                                                                                     | A certificate number related to shipment items if available.                                                                                               |                                                                         |

## Example

### Gift

```json
{
  "content_type": "gifts",
  "non_delivery": "abandon",
  "incoterm": "DDP"
}
```

### Merchandise

```json
{
  "content_type": "merchandise",
  "non_delivery": "return",
  "incoterm": "DAP",
  "invoice_number": "2018-1302",
  "license_number": "NH132-1324",
  "certificate_number": "KC2-5SH-4113"
}
```
