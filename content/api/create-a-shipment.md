+++
title = "Create a shipment"
description = "The resources to use when creating a shipment."
weight = 2
+++

Before retrieving a label to put on your parcel, a shipment should be created in the MyParcel.com API.
Creating such a shipment is done by performing a POST request to the following endpoint: 
```
/v1/shipments
```

## Minimum shipment requirements
In order to successfully register a shipment with a carrier, some information is always required.

#### Attributes
The following attributes should always be included in a shipment request:

Attribute           | Description      
------------------- | ----------------- 
recipient_address   | [Address](/api/resources/addresses) object containing information of the shipments recipient address.
sender_address      | [Address](/api/resources/addresses) object containing information about where the shipment is sent from.
return_address      | [Address](/api/resources/addresses) object containing information about where the shipment should be returned to.
physical_properties | Physical properties object containing information about the dimensions and weight of the shipment. Weight is the only required attribute in this object.

#### Relationships
The following relationships should always be included in a shipment request:

Relationship        | Description
------------------- | ------------------
service_contract    | A [service contract](/api/resources/service-contracts) object



- a recipient address
- a weight
- a service contract (see [how to retrieve service contracts](/api/retrieving-service-contracts))

The best way to start creating a shipment is to request:

- the [regions](/api/resources/regions) to select the recipient address country
- the [services](/api/resources/services) filtered on the chosen destination region
- the [service contracts](/api/resources/service-contracts) for the resulting / chosen service(s)
