+++
title = "Services"
weight = 9
+++

<em class="fa fa-fw fa-file-text-o"></em>[API specification](https://docs.myparcel.com/api-specification#/Services)

These are the services provided by the [carriers](/api/resources/carriers/) that can be used to sent your [shipments](/api/resources/shipments).  
For each service a different `region_from` can restrict the [region](/api/resources/regions/) you can use this service from. The same goes for the `region_to` that restricts the usage of using this service to send something outside that [region](/api/resources/regions/).
The services also have a fixed `delivery_days` set to specify the days this service delivers on. This can however be expanded on with [service_options](/api/resources/service-options/) which can contain additional costs. 

## Relations
The service belongs to one [carriers](/api/resources/carriers/) and has one [region_from](/api/resources/regions/) and [region_to](/api/resources/regions/) to specify where this service can be used.
This service can be added to a shipment trouw the [service_contract](/api/resources/service-contracts) resource which combined the service with a [carrier contract](/api/resources/carrier-contracts/).
