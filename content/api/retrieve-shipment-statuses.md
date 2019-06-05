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
- in-progress
- success
- failed

The list of status codes for the shipment resource is:

code                                | level         | description
----------------------------------- | ------------- | ------------------------------------------------------------------------------
shipment-processing                 | pending       | The shipment is being processed internally.
shipment-concept                    | pending       | The shipment was created, but has not been registered with the carrier (yet).
shipment-registered                 | in-progress   | The shipment was registered with the carrier. Files (such as a label) are available.
shipment-received-by-carrier        | in-progress   | The shipment was collected by or handed over to the carrier.
shipment-at-sorting                 | in-progress   | The shipment is in the sorting process of the carrier.
shipment-with-courier               | in-progress   | The shipment is with the courier and on it's way to the destination.
shipment-delivered                  | success       | The shipment was delivered successfully.
shipment-failed                     | failed        | The shipping process failed. The shipping process will not continue. The shipment has to be resend. Errors are available.
shipment-created-without-tracking   | success       | The shipment was registered and has files available, but no further tracking is available.
shipment-registration-failed        | failed        | The concept shipment was rejected by the carrier and might need to be updated before trying to register again.

{{% notice info %}}
After initial shipment creation and shipment updates through PATCH requests, the shipment will get the status `shipment-processing`.
This indicates that the shipment is undergoing internal processes, for example any [hooks](/api/using-hooks) the user might have set up.
The status will automatically update to `shipment-concept` when the internal processes are finished.
{{% /notice %}}

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
          "related": "https://sandbox-api.myparcel.com/shipments/7b808eee-bf1c-40cd-98f2-3c335a06417e/statuses/9e6d8dba-7c45-4351-a9fc-b55a0cbafbad"
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

A complete list of all shipment statuses belonging to a shipment can be retrieved using the shipment status endpoint. You will need the `shipments.manage` scope in your access token in order to access this endpoint.

```http
GET /shipments/7b808eee-bf1c-40cd-98f2-3c335a06417e/statuses HTTP/1.1
```

Check the [MyParcel.com API Specification](https://docs.myparcel.com/api-specification/#/Shipments/get_shipments__shipment_id__statuses) for a complete description of this shipment status endpoint.
