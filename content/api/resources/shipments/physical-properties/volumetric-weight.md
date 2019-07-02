+++
title = "Volumetric weight"
description = "What is volumetric weight and how is it calculated."
weight = 1
+++

## What is volumetric weight?
The volumetric weight of a shipment represents the amount of space it takes up in an aircraft/vehicle. 
It is therefore calculated from the length, width and height of the parcel.
Some carriers use volumetric weight to determing the cost for a shipment, where others just use the actual weight of the shipment to determine the price.
Carriers that do use volumetric weight to calculate the cost of a shipment will take the higher value between the gross weight and the volumetric weight to determine the billable weight (or chargeable weight).
Some of the carriers integrated in the MyParcel.com API consider volumetric weight (also known as dimensional weight) when determining the cost of a shipment.

{{% notice note %}}
Even if a carrier uses volumetric weight, they might not use it for all their services!  
The [service resource](/api/resources/services) in the MyParcel.com API has an attribute called `uses_volumetric_weight` indicating whether it uses volumetric weight, or not.
{{% /notice %}}

## How is volumetric weight calculated?
The formula to calculate the volumetric weight of a shipment depends on the preferred dimension units.
When using `mm` as the unit for dimensions, 
The formula to calculate the volumetric weight (in KG) of a shipment is as follows:

{{< figure src="/images/volumetric-weight-mm.gif" title="Volumetric weight in kg" alt="Volumetric weight formula" >}}

When using cm as the unit for shipment dimensions, the formula becomes this:

{{< figure src="/images/volumetric-weight-cm.gif" title="Volumetric weight in kg" alt="Volumetric weight formula" >}}

{{< volumetric-weight-calculator >}}
