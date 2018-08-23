+++
title = "Carrier Specific Shipment Requirements"
description = "Carrier specific shipment requirements for all carriers."
weight = 3
+++

The MyParcel.com API is built to communicate with many different carriers. 
However, each carrier has their own restrictions and requirements for creating shipments. 
Below you will find a list of every carrier specific requirement and restriction that the curently integrated carriers have for a shipment. 

## Hermes
Attribute                       | Restriction/Requirement           | When       
------------------------------- | --------------------------------- | -----------
`description`                   | Cannot exceed 20 characters.      | Always


## DPD
Attribute                       | Restriction/Requirement           | When       
------------------------------- | --------------------------------- | -----------
`recipient_address`             | Needs to be an existing address.  | Always. Address validation is performed when creating the shipment[^1]. An incorrect postal code, for example, will immediately cause the shipment registration process to fail. 

[^1]: Other carriers also have address validation built in, but some will correct the address based on the best match instead of failing the registration process.