+++
title = "Update shipment status"
description = "Manually update the status of shipment"
weight = 8
+++

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/RPC/post_update_shipment_status)

The `update-shipment-status` endpoint allows you to trigger an update of a shipment's status. The shipment will be synchronized with the carrier.

### Sandbox environment

Since our sandbox environment does not provide real shipments, they will never receive a status update from the carrier.
To simulate a status update, you can provide a `status_id` in sandbox requests.
This way you can simulate realistic shipment behavior and trigger webhooks to test your implementation.

{{% notice warning %}}
The MyParcel.com API contains several [status](/api/resources/statuses) resources that are not related to shipments. 
When calling the /update-shipment-status endpoint, please make sure the posted status is a shipment related status (indicated by the `resource_type` attribute). 
{{% /notice %}}

## Request

**Required Scope:** `shipments.manage`

| Attribute     | Type                                                                  | Required |
|---------------|-----------------------------------------------------------------------|----------|
| `shipment_id` | uuid formatted string                                                 | ✓        |
| `status_id`   | uuid formatted string (only available on the **sandbox** environment) |          |

Using this endpoint will result in a new [shipment-status](/api/resources/shipment-statuses) added to the posted [shipment](/api/resources/shipments), if the new status is different from the current status.

```http
POST /update-shipment-status HTTP/1.1
Example: https://sandbox-api.myparcel.com/update-shipment-status
```

```json
{
  "data": {
    "shipment_id": "3bba2b2e-453f-4e89-bff9-018e06efa5a6",
    "status_id": "8b384f97-5161-47fb-91c9-4731e4d10ab1"
  }
}
```

## Response

The API will respond with status 204 No Content, indicating that no content is returned, but the update has taken place.
