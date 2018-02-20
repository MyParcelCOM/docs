+++
title = "Create a shipment"
description = "The resources to use when creating a shipment."
weight = 2
+++

The minimum information required to create a (domestic) shipment is:

- a recipient address
- a weight
- a service contract

The best way to start creating a shipment is to request:

- the [regions](/api/resources/regions) to select the recipient address country
- the [services](/api/resources/services) filtered on the chosen destination region
- the [service contracts](/api/resources/service-contracts) for the resulting / chosen service(s)
