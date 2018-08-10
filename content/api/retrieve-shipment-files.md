+++
title = "Retrieve shipment files"
weight = 3
+++

Before you can hand your shipment over to the carrier, the parcel must be provided with a label. In some cases even documents required for passing customs. This section explains how to retrieve the available files and write them to your local file system.

## Shipment registration required

Before being able to provide you with files for your shipment, it first needs to be registered with the carrier that will ship the parcel. This allows us to retrieve or create the necessary files for you. Shipments that were just registered have a status with the code `shipment_registered`. But all shipments with a status that has the level `success` should have any necessary files available.

You can learn more about [retrieving shipment statuses](#todo) and [registering a shipment](#todo) at their corresponding sections.

- Registration is required
- Retrieving available files
  - What kind of files are available?
  - Example files
- Downloading file blobs?
  - Using the accept header
