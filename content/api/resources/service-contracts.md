+++
title = "Service Contracts"
description = "A service can have one or multiple contracts, this resource specifies the prices and available options."
weight = 10
+++

A service contract is a combination of a [service](/api/resources/services/) with a [carrier_contract](/api/resources/carrier-contracts/). Each combination contains an unique recipe to send a shipment. One of the weight groups should be applicable, an insurance might be available or already included. Also extra options might be available and increase the base price with a certain amount.

## Service Contract

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/ServiceContracts)

Relationship          | Description
--------------------- | -----------
service               | The service.
carrier_contract      | The carrier contract offering this service.
service_groups        | A list of service [Group](/api/resources/service-contracts/#group) objects
service_option_prices | A list of service [Option Price](/api/resources/service-contracts/#option-price) objects
service_insurances    | A list of service [Insurance](/api/resources/service-contracts/#insurance) objects

### Group

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/ServiceGroups)

Attribute  | Description
---------- | -----------
weight     | An object containing the minimum and maximum weight of supported shipments. If the shipment weight does not fall between these constraints, another service group or service should be used.
price      | Price of this group which will be the shipment base price.
step_price | Price of additional weight units (grams) which will be added to the shipment price. Used for services which transport by air where extra weight is expensive.
step_size  | The amount of weight units (grams) every time a step_price will be added.

Relationship     | Description
---------------- | -----------
service_contract | The service contract offering this weight group.

### Insurance

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/ServiceInsurances)

Attribute | Description
--------- | -----------
covered   | Value up to which is covered by this insurance.
price     | Price of the insurance which will be added to the shipment price.

Relationship     | Description
---------------- | -----------
service_contract | The service contract offering this insurance.

### Option Price

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/ServiceOptionPrices)

Attribute | Description
--------- | -----------
price     | Price of the option which will be added to the shipment price.
required  | If this is a default option included with the service. In this case the price will most likely be 0.

Relationship     | Description
---------------- | -----------
service_contract | The service contract offering this option.
service_option   | The service option offered.
