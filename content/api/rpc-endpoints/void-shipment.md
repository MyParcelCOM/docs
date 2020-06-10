+++
title = "Void shipment"
description = "Void a shipment, making the label unable to be used"
weight = 9
+++

{{< icon fa-file-text-o >}}[API specification](https://api-specification.myparcel.com/#tag/RPC/paths/~1void-shipment/post)

Some carriers allow a user to void (cancel) a shipment if they have no intentions of using the label.
Voiding the shipment renders its label invalid and can prevent costs if the carrier charges on label creation, rather than upon the first scan of the label.

{{% notice warning %}}
Voiding a shipment deletes the label that was created for that shipment in the MyParcel.com API.
This means that the label can no longer be downloaded after the shipment was voided.
{{% /notice %}}

### When is a shipment voidable?
A shipment becomes voidable after it is registered with the carrier and a label becomes available. 
If the label associated with the shipment has been scanned by the carrier however, 
it becomes unvoidable. 

{{% notice tip %}}
As a rule of thumb, whenever a shipment has the `shipment-registered` status, it can be voided.
Some exceptions exist of course, for example when the shipment was just handed over to the carrier and no status update has reached the MyParcel.com platform yet.
The carrier will reject the request to void the shipment in such cases.
{{% /notice %}}

## Request

**Required Scope:** `shipments.manage`

| Attribute              | Type                     | Required |
|------------------------|--------------------------|----------|
| `shipment_id`          | uuid formatted string    | ✓        |

This endpoint allows a user to void a registered shipment if its label is not going to be used. This will avoid unused labels to be invoiced by the carrier.

```http
POST /void-shipment HTTP/1.1
Example: https://sandbox-api.myparcel.com/void-shipment
```

```json
{
  "data": {
    "shipment_id": "3bba2b2e-453f-4e89-bff9-018e06efa5a6"
  }
}
```

## Response

The API will respond with either one of two statuses:  

 - `204 No Content`: Voiding the shipment was successful. The shipment has been updated with a new `shipment-voided` status.
 - `423 Locked`: The shipment could not be voided. Either the carrier rejected it because it has already entered their network, 
 or the MyParcel.com API rejected it because the shipment is not in a voidable state.
