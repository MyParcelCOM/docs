+++
title = "Update shipment status"
description = "Manually update the status of shipment"
weight = 8
+++

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/RPC/post_update_shipment_status)

{{% notice warning %}}
This endpoint is only available for the **sandbox** environment!
{{% /notice %}}

When implementing the MyParcel.com API using the sandbox environment, you might want to simulate realistic shipment behavior like changing a shipment's status.
Because the sandbox environment doesn't actually allow users to send a shipment, shipments will never receive a status update from the carrier, indicating that it is on the way or has been delivered etc. To simulate this behavior, the sandbox environment describes an [RPC endpoint](/api/rpc-endpoints) that allows users to manually update the status of a shipment. 

## Request

**Required Scope:** `shipments.manage`

| Attribute              | Type                     | Required |
|------------------------|--------------------------|----------|
| `shipment_id`          | uuid formatted string    | ✓        |
| `status_id`            | uuid formatted string    | ✓        |

This endpoint allows a user to create a new [shipment-status](/api/resources/shipment-statuses) consisting of the posted [shipment](/api/resources/shipments) and [status](/api/resources/statuses). 

{{% notice warning %}}
The MyParcel.com API contains several resources that are not related to shipments. 
When calling the /update-shipment-status endpoint, please make sure the posted status is a shipment related status (indicated by the [status](/api/resources/statuses) `resource_type` attribute). 
{{% /notice %}}


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
