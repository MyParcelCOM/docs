+++
title = "Volumetric weight"
description = "What is volumetric weight and how is it calculated."
weight = 1
+++

The volumetric weight of a shipment represents the amount of space it takes up in an aircraft/vehicle. 
Some carriers use volumetric weight to determine the cost for a shipment, where others use just the gross weight of the shipment to determine the price.
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
The volumetric weight of a shipment is automatically calculated and returned by the MyParcel.com API, provided that the [physical properties](/api/resources/shipments/physical-properties/)
