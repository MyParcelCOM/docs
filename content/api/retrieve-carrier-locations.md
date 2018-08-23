+++
title = "Retrieve carrier locations"
description = "How to retrieve pick-up and drop-off locations used by carriers."
weight = 4
+++

Carriers often have several physical locations, as part of their services. There are two types of carrier locations:

- [Drop-off locations](#drop-off-locations) where parcels can be handed over to the carrier by the **sender**.
- [Pick-up locations](#pick-up-locations) where parcels can be collected by the **recipient**.

These [carrier locations](/api/resources/carrier-pudo-locations) can be retrieved for each carrier using the [carrier locations endpoint](#carrier-locations-endpoint).

## Carrier locations endpoint

To retrieve the carrier locations for a carrier, the following API endpoint can be used. The endpoint accepts a couple of parameters to specify from which area carrier locations should be retrieved.

**Path parameters (required)**

- *`carrier_id`: the identifier of the carrier to retrieve locations for*
- *`country_code`: the country code of the area to retrieve locations from*
- *`postal_code`: the postal code of the area to retrieve locations for*

**Query parameters (optional)**

- *`street`: the street name to further specify the area to retrieve locations for*
- *`street_number`: the house number to further specify the area to retrieve locations for*

**Example**

The example below will retrieve locations for a carrier, with identifier `be7f6752-34e0-49a1-a832-bcc209450ea9`, closest to `221B Baker Street` in `London`, with the postal code `NW1 6XE`.

```http
GET /v1/carriers/be7f6752-34e0-49a1-a832-bcc209450ea9/pickup-dropoff-locations/GB/NW1%206XE?street=Baker%20Street&street_number=221B HTTP/1.1
```

To retrieve locations for multiple carrier, separate calls can be made for each carrier, with their respective `carrier_id`. Check the [API Specification](https://docs.myparcel.com/api-specification/#/Carriers/get_carriers__carrier_id__pickup_dropoff_locations__country_code___postal_code_) for a complete description of this endpoint.

## Drop-off locations

Most carriers offer the option to drop off parcels at one of their locations. This is indicated by the `handover_method` of the chosen service, which in that case contains the value `drop-off`. Parcels can only be dropped off at locations that belong to the `drop-off` category.

To only retrieve drop-off locations, use the `filter[categories]` query parameter with value `drop-off`:

```http
GET /v1/carriers/be7f6752-34e0-49a1-a832-bcc209450ea9/pickup-dropoff-locations/GB/NW1%206XE?filter[categories]=drop-off HTTP/1.1
```

## Pick-up locations

Some carriers offer the option to have parcels delivered at one of their locations, so the recipient can collect the parcel there. This is indicated by the `delivery_method` of the chosen service, which in that case contains the value `pick-up`. Parcels can only be delivered to locations that belong to the `pick-up` category. The `code` and `address` of the chosen pick-up location must be specified in the `pickup_location` property of a shipment, when creating a new shipment.

To only retrieve `pick-up` locations, use the `filter[categories]` query parameter with value `pick-up`:

```http
GET /v1/carriers/be7f6752-34e0-49a1-a832-bcc209450ea9/pickup-dropoff-locations/GB/NW1%206XE?filter[categories]=pick-up HTTP/1.1
```
