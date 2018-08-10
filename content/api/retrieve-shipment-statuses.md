+++
title = "Retrieve shipment statuses"
description = "How to retrieve the current status and status history of a shipment."
weight = 3
+++

Shipments always have at least one shipment status. A [shipment status resource](/api/resources/shipment-statuses) contains:

1. One of our [generic statuses](#generic-status) with our code and description.
2. The [carrier specific status](#carrier-specific-status) with their code, description and timestamp.

You receive the [current status](#current-status) within every shipment resource. A complete [status history](#status-history) can be retrieved separately. Below is an example of the JSON data from a shipment status:

```json
{
  "type": "shipment-statuses",
  "id": "9e6d8dba-7c45-4351-a9fc-b55a0cbafbad",
  "attributes": {
    "carrier_status_code": "9001",
    "carrier_status_description": "Confirmed at destination",
    "carrier_timestamp": 1504801719
  },
  "relationships": {
    "status": {
      "data": {
        "type": "statuses",
        "id": "5c868557-0827-4d21-a7f4-9820f01769f4"
      }
    },
    "shipment": {
      "data": {
        "type": "shipments",
        "id": "7b808eee-bf1c-40cd-98f2-3c335a06417e"
      }
    }
  }
}
```

## Generic status

We have a list of generic [status resources](/api/resources/statuses) used for several types of other resources. They can be of the level:

- pending
- success
- failed

The list of status codes we use for shipment resources is:

code                | description
------------------- | -----------
shipment_concept    | The shipment is created
shipment_registered | The shipment is registered with the carrier
shipment_at_carrier | The shipment is handed to the carrier
shipment_at_sorting | The shipment is at the sorting center
shipment_at_courier | The shipment is picked up by the courier
shipment_delivered  | The shipment is delivered
shipment_inactive   | The shipment is inactive
shipment_failed     | Carrier has failed to process the shipment
shipment_completed  | No further status tracking will be available
shipment_rejected   | Something went wrong when registering the shipment. Please create a new shipment.

An up to date list of our generic statuses can be retrieved using the [GET /statuses endpoint](https://docs.myparcel.com/api-specification/#/Statuses/get_statuses).

## Carrier specific status

Every carrier has their own list of statuses for the different events happening in their network. We map all known events to our [generic statuses](#generic-status) mentioned above. The carrier specific information present in the shipment status resource is present in the following attributes:

attribute                  | description
-------------------------- | -----------
carrier_status_code        | Code used by the carrier
carrier_status_description | Explanation of the code used by the carrier
carrier_timestamp          | Unix timestamp when the carrier registered this status

## Current status

The current status of a shipment can be found in the `relationships` of a [shipment resource](/api/resources/shipments). For example:

```json
"shipment_status": {
  "data": {
    "type": "shipment-statuses",
    "id": "9e6d8dba-7c45-4351-a9fc-b55a0cbafbad"
  },
  "links": {
    "related": "https://api.myparcel.com/v1/shipments/7b808eee-bf1c-40cd-98f2-3c335a06417e/statuses/9e6d8dba-7c45-4351-a9fc-b55a0cbafbad"
  }
}
```

To get the complete [shipment status](/api/resources/shipment-statuses) resource, you will need to either:

- fetch it using the `related` link from the `shipment_status` relationship, or
- include it in the `GET /shipment` request using `?include=shipment_status`.

## Status history

A complete list of all shipment statuses belonging to a shipment can be retrieved using a separate endpoint. For example:

```http
GET https://api.myparcel.com/v1/shipments/7b808eee-bf1c-40cd-98f2-3c335a06417e/statuses
```

Check our [API Specification](https://docs.myparcel.com/api-specification/#/Shipments/get_shipments__shipment_id__statuses) for a complete description of this shipment status endpoint.
