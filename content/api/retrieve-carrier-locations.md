+++
title = "Retrieve carrier locations"
description = "How to retrieve pick-up and drop-off locations used by carriers."
weight = 4
+++

Carriers often have several physical locations as part of their services. There are two types of carrier locations:

- [Drop-off locations](#drop-off-locations) where parcels can be handed to the carrier by the **sender**.
- [Pick-up locations](#pick-up-locations) where parcels can be collected by the **recipient**.

These [carrier location resources](/api/resources/carrier-pudo-locations) can be retrieved for each carrier using the [carrier locations endpoint](#carrier-locations-endpoint).

## Carrier locations endpoint

A complete list of all locations belonging to a carrier can be retrieved using this API endpoint. Below is an example request to retrieve locations for carrier X around the postal code NW1 6XE in the United Kingdom:

```http
GET /v1/carriers/be7f6752-34e0-49a1-a832-bcc209450ea9/pickup-dropoff-locations/GB/NW1%206XE HTTP/1.1
```

The variable components of this endpoint are the `carrier_id`, the `country_code` and the `postal_code` path parameters. Optionally, you can add `street` and `street_number` as query parameters to get more accurate results:

```http
GET /v1/carriers/be7f6752-34e0-49a1-a832-bcc209450ea9/pickup-dropoff-locations/GB/NW1%206XE?street=Baker%20Street&street_number=1 HTTP/1.1
```

If you want to retrieve locations for multiple carriers, you will have to make another request with a different `carrier_id`. Check the [API Specification](https://docs.myparcel.com/api-specification/#/Carriers/get_carriers__carrier_id__pickup_dropoff_locations__country_code___postal_code_) for a complete description of this endpoint.

## Drop-off locations

Most carrier services offer the option to submit new parcels at one of their locations. This is indicated by the `handover_method` of the chosen service, which can contain the value `drop-off`. In that case, the sender can submit the parcel into the network of the carrier via a location with the category `drop-off`.

To only select drop-off locations, use the `filter[categories]` with the value `drop-off`:

```http
GET /v1/carriers/be7f6752-34e0-49a1-a832-bcc209450ea9/pickup-dropoff-locations/GB/NW1%206XE?filter[categories]=drop-off HTTP/1.1
```

## Pick-up locations

Some carrier services offer the option to deliver parcels at one of their locations. This is indicated by the `delivery_method` of the chosen service, which can contain the value `pick-up`. In that case, the recipient can collect the parcel at the location with the category `pick-up` which has been specified when creating the shipment. The `code` and `address` of the chosen pick-up location must be stored in the `pickup_location` property of a shipment.

To only select pick-up locations, use the `filter[categories]` with the value `pick-up`:

```http
GET /v1/carriers/be7f6752-34e0-49a1-a832-bcc209450ea9/pickup-dropoff-locations/GB/NW1%206XE?filter[categories]=pick-up HTTP/1.1
```
