+++
title = "Retrieve shipment statuses"
description = "How to retrieve the current status and status history of a shipment."
weight = 3
+++

Shipments always have at least one shipment status. A [shipment status resource](/api/resources/shipment-statuses) contains:

1. A relation with a [generic status](#generic-status) resource containing a code and description.
2. Information about the [carrier specific status](#carrier-specific-status) like a status code, description and timestamp.

You receive the [current shipment status](#current-status) within every shipment resource. A complete [status history](#status-history) can be retrieved separately. 

## Generic status

Within the MyParcel.com API, a list of generic [status resources](/api/resources/statuses) is used for several types of resources. 
Status resources can be of the following levels:

- pending
- success
- failed

The list of status codes for the shipment resource is:

code                | level   | description
------------------- | ------  | -----------
shipment_concept    | pending | The shipment is created, but not yet registered with the carrier.
shipment_registered | success | The shipment is registered with the carrier.
shipment_at_carrier | success | The shipment is handed to the carrier.
shipment_at_sorting | success | The shipment is at the sorting center.
shipment_at_courier | success | The shipment is picked up by the courier.
shipment_delivered  | success | The shipment is delivered.
shipment_inactive   | failed  | The shipment is inactive.
shipment_failed     | failed  | The carrier has failed to process the shipment.
shipment_completed  | success | No further status tracking will be available.
shipment_rejected   | failed  | Something went wrong when registering the shipment. Please create a new shipment.

An up-to-date list of the generic statuses can be retrieved using the [GET /statuses endpoint](https://docs.myparcel.com/api-specification/#/Statuses/get_statuses).

## Carrier specific status

Every carrier has their own list of statuses for the different events happening in their network. 
All of those carrier statuses are mapped to one of the [generic statuses](#generic-status) mentioned above. 
Information about the carrier specific status is present in the shipment status resource in the following attributes:

Attribute                  | Description
-------------------------- | -----------
carrier_status_code        | The code used by the carrier for the status.
carrier_status_description | Explanation of the code used by the carrier.
carrier_timestamp          | Unix timestamp when the carrier registered this status.

## Current status

The current status of a shipment can be found in the `relationships` of a [shipment resource](/api/resources/shipments).

```json
{
  "data": {
    "type": "shipments",
    "id": "7b808eee-bf1c-40cd-98f2-3c335a06417e",
    "attributes": {
      "...": "..."
    },
    "relationships": {
      "shipment_status": {
        "data": {
          "type": "shipment-statuses",
          "id": "9e6d8dba-7c45-4351-a9fc-b55a0cbafbad"
        },
        "links": {
          "related": "https://api.myparcel.com/shipments/7b808eee-bf1c-40cd-98f2-3c335a06417e/statuses/9e6d8dba-7c45-4351-a9fc-b55a0cbafbad"
        }
      },
      "shop": {
        "...": "..."
      }
    }
  }
}

```

To get the complete [shipment status](/api/resources/shipment-statuses) resource, you will need to either:

- fetch it, using the `related` link from the `shipment_status` relationship, or
- include it in the `GET /shipments/{shipment_id}` request using the `include` query parameter: `?include=shipment_status`.

## Status history

A complete list of all shipment statuses belonging to a shipment can be retrieved using the shipment status endpoint. You will need the `shipments.show` or `shipments.manage` scope in your access token in order to access this endpoint.

```http
GET /shipments/7b808eee-bf1c-40cd-98f2-3c335a06417e/statuses HTTP/1.1
```

Check the [MyParcel.com API Specification](https://docs.myparcel.com/api-specification/#/Shipments/get_shipments__shipment_id__statuses) for a complete description of this shipment status endpoint.
