+++
title = "Volumetric weight"
description = "What is volumetric weight and how is it calculated."
weight = 1
+++

The volumetric weight of a shipment represents the amount of space it takes up in an aircraft/vehicle. 
Some carriers use volumetric weight to determine the cost for a shipment, while others use only the gross weight.
Carriers that do use volumetric weight to calculate the cost of a shipment will take the higher value between the gross weight and the volumetric weight to determine the billable weight (or chargeable weight).
Some of the carriers integrated in the MyParcel.com API consider volumetric weight (also known as dimensional weight) when determining the cost of a shipment.

{{% notice note %}}
Even if a carrier uses volumetric weight, they might not use it for all their services.
The [service resource](/api/resources/services) in the MyParcel.com API has an attribute called `uses_volumetric_weight` indicating whether it uses volumetric weight, or not.
{{% /notice %}}

### Formula
The formula to calculate the volumetric weight of a shipment depends on the preferred dimension units.
When using `mm` as the unit for dimensions, calculating the volume by multiplying the dimensions and then dividing that by 5.000.000 will give the volumetric weight in kilograms:

{{< figure src="/images/volumetric-weight-mm.gif" title="Volumetric weight in kg" alt="Volumetric weight formula" >}}

When using `cm` as the unit for shipment dimensions, the factor to divide the volume by becomes 5000:

{{< figure src="/images/volumetric-weight-cm.gif" title="Volumetric weight in kg" alt="Volumetric weight formula" >}}

Use the calculator below to calculate the volumetric weight of your shipment.
{{< volumetric-weight-calculator >}}

### Usage
The volumetric weight of a shipment will be calculated in the MyParcel.com API upon shipment creation, 
provided that the shipment request contains the required dimensions (length, width and height) in the [physical_properties](/api/resources/shipments/physical-properties/) attribute.
If the posted [service](/api/resources/services/) uses volumetric weight, 
the API will try to find a matching [service-rate](/api/resources/service-rates/) by matching the billable weight 
(the higher value between the gross weight of the parcel and the volumetric weight), with the weight range of the service rate, thus determining the raw price of the service (the price is further influenced by any added [service-options](/api/resources/service-options/)).

{{% notice warning %}} 
The volumetric weight of a shipment is a read-only field and is automatically calculated in the MyParcel.com API.   
It is not possible to provide the volumetric weight in a POST shipment request!
{{% /notice %}}
