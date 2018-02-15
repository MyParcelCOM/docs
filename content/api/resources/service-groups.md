+++
title = "Service Groups"
weight = 11
+++

<em class="fa fa-fw fa-file-text-o"></em>[API specification](https://docs.myparcel.com/api-specification#/ServiceGroups)

This resource represents a the base price of a service for a given weight group. The service-groups contain an `min` and `max` weight to select which group is used for your [shipment](/api/resources/shipments/). Than the `price` defined in this group will be used as a base price with an additional `step_price` if set. This `step_price` wil be added for every `step_size` amount your weight is over the min weight.


## Relations
This service group belongs to one [service contract](/api/resources/service-contracts). 
