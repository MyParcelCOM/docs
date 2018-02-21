+++
title = "Shipments"
description = "The main resource in our API containing shipment information, files and statuses."
weight = 15
+++

Shipments are used to retrieve shipment labels from carriers. When requesting all shipments, you can filter on a search keyword and a shop.

## Shipment

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/Shipments)

Attribute                    | Description
---------------------------- | -----------
recipient_address            | [Address](/api/resources/addresses) object used as delivery address if no pickup location is specified.
sender_address               | [Address](/api/resources/addresses) object used as return address.
pickup_location              | [PUDO location](/api/resources/carrier-pudo-locations) object containing the `code` and `address` of the location.
description                  | Short note, printed on the shipping label if specified in the shop settings (and if allowed by the carrier).
price                        | Price of the shipment which will be charged on your invoice.
insurance                    | Amount this shipment is insured up to.
barcode                      | Code returned by the carrier, also printed on the shipping label.
tracking_code                | Code returned by the carrier, used to retrieve status information.
tracking_url                 | Consumer URL to check the status on the website of the carrier.
physical_properties          | [Physical Properties](/api/resources/shipments/#physical-properties) object containing the weight and dimensions supplied by the user.
physical_properties_verified | [Physical Properties](/api/resources/shipments/#physical-properties) object containing the weight and dimensions measured by the carrier.
items                        | A list of shipment [Item](/api/resources/shipments/#items) objects, required for international shipping.
customs                      | [Customs](/api/resources/shipments/#customs) object, required for international shipping.
created_at                   | Unix timestamp when the shipment was created.
updated_at                   | Unix timestamp when the shipment was updated with new information.
synced_at                    | Unix timestamp when the shipment was checked at the carrier.

{{% notice note %}}
Several relations can be **included** as resources in the `GET /shipments` response. This way you don't need additional requests to other endpoints to get the related objects and their attributes.
{{% /notice %}}

Relationship     | Description
---------------- | -----------
service_options  | Chosen options belonging to the chosen contract.
parent           | Returned shipments have a parent indicating their origin.
shop             | Owner of this shipment.
status           | Current shipment status. There is a [shipment statuses endpoint](https://docs.myparcel.com/api-specification#/Shipments/get_shipments__shipment_id__statuses) to retrieve all statuses from a shipment.
service_contract | Chosen service contract (including the carrier).
files            | Available files, often shipping labels in PDF format. There is a [shipment files endpoint](https://docs.myparcel.com/api-specification#/Shipments/get_shipments__shipment_id__files) to retrieve all files from a shipment.

### Customs

When customs information is required, also at least one shipment item should be provided.

Attribute      | Description
-------------- | -----------
content_type   | The category of this merchandise.
invoice_number | Invoice number, required for all types of merchandise.
non_delivery   | Action when the parcel cannot be delivered
incoterm       | Specify if the buyer or seller is responsible for charges and risks.

### Items

You can include items even if no customs information is required. This way you can view the shipment contents in our back office.

Attribute           | Description
------------------- | -----------
sku                 | Unique identifier, often the Stock Keeping Unit.
description         | Description of the item or it's content.
item_value          | Value of one single item.
quantity            | Amount of these items present in the shipment.
hs_code             | Harmonized System code used by customs.
origin_country_code | Country where this item was produced.

### Physical Properties

Attribute | Description
--------- | -----------
height    | Height in millimeters.
width     | Width in millimeters.
length    | Length in millimeters.
volume    | Volume in liters (dm3).
weight    | Weight in grams.
