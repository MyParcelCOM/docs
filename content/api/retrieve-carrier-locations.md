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

A list of locations belonging to a carrier can be retrieved using this API endpoint. When calling this endpoint, you use a country code and postal code to specify in what area you are looking for a location. Below is an example request to retrieve locations for carrier X around the postal code `NW1 6XE` in Great Britain:

```http
GET /v1/carriers/be7f6752-34e0-49a1-a832-bcc209450ea9/pickup-dropoff-locations/GB/NW1%206XE HTTP/1.1
```

The variable components of this endpoint are the `carrier_id`, the `country_code` and the `postal_code` path parameters. Optionally, you can add `street` and `street_number` as query parameters to get more accurate results:

```http
GET /v1/carriers/be7f6752-34e0-49a1-a832-bcc209450ea9/pickup-dropoff-locations/GB/NW1%206XE?street=Baker%20Street&street_number=1 HTTP/1.1
```

If you want to retrieve locations for multiple carriers, you will have to make multiple requests with different `carrier_id`'s. Check the [API Specification](https://docs.myparcel.com/api-specification/#/Carriers/get_carriers__carrier_id__pickup_dropoff_locations__country_code___postal_code_) for a complete description of this endpoint.

## Drop-off locations

Most carrier services offer the option to submit new parcels at one of their locations. This is indicated by the `handover_method` of the chosen service, which in that case contains the value `drop-off`. The sender can submit the parcel into the network of the carrier at a location with `category` `drop-off`.

To only retrieve drop-off locations, use the `filter[categories]` query parameter with value `drop-off`:

```http
GET /v1/carriers/be7f6752-34e0-49a1-a832-bcc209450ea9/pickup-dropoff-locations/GB/NW1%206XE?filter[categories]=drop-off HTTP/1.1
```

## Pick-up locations

Some carrier services offer the option to have parcels delivered at one of their locations. This is indicated by the `delivery_method` of the chosen service, which in that case contains the value `pick-up`. The recipient can then collect the parcel at the location with the `category` `pick-up` which has been specified when creating the shipment. The `code` and `address` of the chosen pick-up location must be stored in the `pickup_location` property of a shipment when creating a shipment resource.

To only retrieve `pick-up` locations, use the `filter[categories]` query parameter with value `pick-up`:

```http
GET /v1/carriers/be7f6752-34e0-49a1-a832-bcc209450ea9/pickup-dropoff-locations/GB/NW1%206XE?filter[categories]=pick-up HTTP/1.1
```
