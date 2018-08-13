+++
title = "Create a shipment"
description = "The resources to use when creating a shipment."
weight = 2
+++

Before printing a label to put on your parcel, a [shipment](/api/resources/shipments) resource should be created in the MyParcel.com API.  
Creating such a shipment is done by performing a POST request to the following endpoint:
```
/v1/shipments
```

{{%expand "See example shipment." %}}
```
{
  "data": {
    "type": "shipments",
    "attributes": {
      "recipient_address": {
        "street_1": "Baker Street",
        "street_2": "Marylebone",
        "street_number": 221,
        "street_number_suffix": "B",
        "postal_code": "NW1 6XE",
        "city": "London",
        "region_code": "ENG",
        "country_code": "GB",
        "first_name": "Sherlock",
        "last_name": "Holmes",
        "company": "Holmes Investigations",
        "email": "s.holmes@holmesinvestigations.com",
        "phone_number": "+31 234 567 890"
      },
      "return_address": {
        "street_1": "Baker Street",
        "street_2": "Marylebone",
        "street_number": 221,
        "street_number_suffix": "B",
        "postal_code": "NW1 6XE",
        "city": "London",
        "region_code": "ENG",
        "country_code": "GB",
        "first_name": "Sherlock",
        "last_name": "Holmes",
        "company": "Holmes Investigations",
        "email": "s.holmes@holmesinvestigations.com",
        "phone_number": "+31 234 567 890"
      },
      "sender_address": {
        "street_1": "Baker Street",
        "street_2": "Marylebone",
        "street_number": 221,
        "street_number_suffix": "B",
        "postal_code": "NW1 6XE",
        "city": "London",
        "region_code": "ENG",
        "country_code": "GB",
        "first_name": "Sherlock",
        "last_name": "Holmes",
        "company": "Holmes Investigations",
        "email": "s.holmes@holmesinvestigations.com",
        "phone_number": "+31 234 567 890"
      },
      "description": "Order #8008135",
      "physical_properties": {
        "height": 150,
        "width": 300,
        "length": 500,
        "volume": 22.5,
        "weight": 5000
      },
      "register_at": 1504801719
    },
    "relationships": {
      "shop": {
        "data": {
          "type": "shops",
          "id": "35eddf50-1d84-47a3-8479-6bfda729cd99"
        }
      },
      "service_contract": {
        "data": {
          "type": "service-contracts",
          "id": "af5e65b6-a709-4f61-a565-7c12a752482f"
        }
      }
    }
  }
}
```
{{% /expand %}}

{{%expand "See example international shipment that requires customs." %}}
```
{
  "data": {
    "type": "shipments",
    "attributes": {
      "recipient_address": {
        "street_1": "Baker Street",
        "street_2": "Marylebone",
        "street_number": 221,
        "street_number_suffix": "B",
        "postal_code": "NW1 6XE",
        "city": "London",
        "region_code": "ENG",
        "country_code": "GB",
        "first_name": "Sherlock",
        "last_name": "Holmes",
        "company": "Holmes Investigations",
        "email": "s.holmes@holmesinvestigations.com",
        "phone_number": "+31 234 567 890"
      },
      "return_address": {
        "street_1": "Baker Street",
        "street_2": "Marylebone",
        "street_number": 221,
        "street_number_suffix": "B",
        "postal_code": "NW1 6XE",
        "city": "London",
        "region_code": "ENG",
        "country_code": "GB",
        "first_name": "Sherlock",
        "last_name": "Holmes",
        "company": "Holmes Investigations",
        "email": "s.holmes@holmesinvestigations.com",
        "phone_number": "+31 234 567 890"
      },
      "sender_address": {
        "street_1": "Baker Street",
        "street_2": "Marylebone",
        "street_number": 221,
        "street_number_suffix": "B",
        "postal_code": "NW1 6XE",
        "city": "London",
        "region_code": "ENG",
        "country_code": "GB",
        "first_name": "Sherlock",
        "last_name": "Holmes",
        "company": "Holmes Investigations",
        "email": "s.holmes@holmesinvestigations.com",
        "phone_number": "+31 234 567 890"
      },
      "description": "Order #8008135",
      "physical_properties": {
        "height": 150,
        "width": 300,
        "length": 500,
        "volume": 22.5,
        "weight": 5000
      },
      "items": [
        {
          "sku": "123456789",
          "description": "OnePlus X",
          "item_value": {
            "amount": 995,
            "currency": "EUR"
          },
          "quantity": 2,
          "hs_code": "8517.12.00",
          "origin_country_code": "GB",
          "nett_weight": 135
        }
      ],
      "customs": {
        "content_type": "merchandise",
        "invoice_number": "9000",
        "non_delivery": "return",
        "incoterm": "DDU"
      },
      "register_at": 1504801719
    },
    "relationships": {
      "shop": {
        "data": {
          "type": "shops",
          "id": "35eddf50-1d84-47a3-8479-6bfda729cd99"
        }
      },
      "service_contract": {
        "data": {
          "type": "service-contracts",
          "id": "af5e65b6-a709-4f61-a565-7c12a752482f"
        }
      }
    }
  }
}
```
{{% /expand %}}


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
service_contract    | A [service contract](/api/resources/service-contracts) relationship object containing the uuid of the desired service contract.
shop                | A [shop](/api/resources/shops) relationship object containing the uuid of the shop under which this shipment should be created.

## Registration of the shipment
Creating your shipment resource is step one. The next step is the registration of your shipment with the carrier that corresponds to the chosen `service_contract`.
That's where the `register_at` attribute comes in. The `register_at` attribute expects an [unix timestamp](https://www.unixtimestamp.com/) as integer value. 
Sending in a timestamp that lies in the future will queue the registration of the shipment for that exact time. 
Otherwise, sending in a timestamp that lies in the past or corresponds to the current time, will cause the shipment to be queued for registration immediately.
Lastly, the `register_at` attribute is an optional attribute. This means that by choosing to not include the attribute in the shipment request, the shipment will not be registered with the carrier until it is patched with a `register_at` value. 

{{% notice warning %}} 
After a shipment is registered with a carrier, it is no longer possible to **edit** or **delete** that shipment
{{% /notice %}}


The best way to start creating a shipment is to request:

- the [regions](/api/resources/regions) to select the recipient address country
- the [services](/api/resources/services) filtered on the chosen destination region
- the [service contracts](/api/resources/service-contracts) for the resulting / chosen service(s)
