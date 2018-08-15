+++
title = "Create a shipment"
description = "The resources to use when creating a shipment."
weight = 2
+++

Before printing a label to put on your parcel, a [shipment](/api/resources/shipments) resource should be created in the MyParcel.com API.  
Creating such a shipment is done by making a `POST` request to the `/v1/shipments` endpoint.  

In order to be able to create a shipment in the MyParcel.com API, the `shipments.manage` [scope](/api/authentication/scopes) is required in the access token.

## Minimum shipment requirements
In order to successfully register a shipment with a carrier, some information is always required.

### Attributes
The following attributes should always be included in a shipment request:

Attribute           | Description      
------------------- | ----------------- 
recipient_address   | [Address](/api/resources/shipments#address) object containing information of the shipments recipient address.
sender_address      | [Address](/api/resources/shipments#address) object containing information about where the shipment is sent from.
return_address      | [Address](/api/resources/shipments#address) object containing information about where the shipment should be returned to.
physical_properties | [Physical properties](/api/resources/shipments#physical-properties) object containing information about the dimensions and weight of the shipment.

{{% notice note %}}
Depending on the carrier, more information may be required. 
For more information, see our page about **[carrier specific requirements](/api/carrier-specific-requirements)**.
{{% /notice %}}

### Relationships
The following relationships should always be included in a shipment request:

Relationship        | Description
------------------- | ------------------
shop                | A [shop](/api/resources/shops) relationship object containing the uuid of the shop for which this shipment should be created.
service_contract    | A [service contract](/api/resources/service-contracts) relationship object containing the uuid of the desired service contract.

Additionally you could add a `service_options` relationship if you would like to add service options to the shipment. For more information, see the [service options resource page](/api/resources/service-options).

#### Shop relationship
A shipment is always created for a shop. The shop's `uuid` should therefore always be included the shipment request. 
To retrieve your shop's `uuid`, simply call the `/v1/shops` endpoint to retrieve all `shops` resources available to you.
You can then include the desired shop's `uuid` in the shipment request.

#### Service contract relationship
Every shipment resource has to have a [service contract](/api/resources/service-contracts) relationship. 
Choosing the right service contract depends on a few factors and can be a little complicated. 
A service contract is a connection between a [service](/api/resources/services) resource and a [carrier contract](/api/resources/carrier-contracts) resource.
Choosing a service contract therefore depends on your choice of carrier, but also the [regions](/api/resources/regions) that your shipment should be shipping to and from.
To make things a little easier for you, here's a list of required steps in order to retrieve the resources needed for choosing a service contract.

1. [Retrieve the origin and destination regions](https://docs.myparcel.com/api-specification#Regions) for your shipment.
2. [Retrieve the desired carrier](https://docs.myparcel.com/api-specification#Carriers) with whom you want to ship your shipment.
3. [Retrieve the desired service](https://docs.myparcel.com/api-specification#Services) for your shipment based on the regions, desired carrier and other wishes for your shipment.
4. [Retrieve the shop](https://docs.myparcel.com/api-specification#Shops) for which you would like to create a shipment.

With this information, you can now call the `/v1/service-contracts/` endpoint to retrieve the available service contracts for your shipment.
To filter the service contracts based on the information above, you should use the following `filter` query parameters:

1. `filter[shop]={shop_id}` to filter service contracts available for that shop.
2. `filter[service]={service_id}` to filter service contracts based on the chosen service.

You can then include the desired service contract's `uuid` in the shipment request.

### Customs information
When shipping from one country to another, chances are that your parcel will have to go through customs. 
The required customs information can be included in the shipment request. 
Whenever the [customs](/api/resources/shipments#customs) object is present in the shipment request, the [items](/api/resources/shipments#items) object is also required.
Futhermore, a `phone_number` of the recipient and `description` of the shipment are also required for customs related shipments.
A customs declaration form will be automatically generated and returned when printing the label for this shipment.

## Registering your shipment with the carrier
After a shipment is created, the next step is the registration of your shipment with the carrier that corresponds to the chosen `service_contract`.
That's where the `register_at` attribute comes in. The `register_at` attribute expects a unix timestamp as integer value. 
Sending in a timestamp that lies in the future will queue the registration of the shipment for that exact time. 
Otherwise, sending in a timestamp that lies in the past or corresponds to the current time, will cause the shipment to be queued for registration immediately.
Lastly, because the `register_at` attribute is an optional attribute, you can choose to omit it from the request. 
This means that the shipment will not be registered with the carrier until it is patched with a `register_at` value. 

{{% notice warning %}} 
After a shipment is registered with a carrier, it is no longer possible to **edit** or **delete** that shipment!
{{% /notice %}}

## Example requests
Below are two examples for shipment requests. Note that one is an international shipment that includes customs information.
An example response of the domestic shipment request is also provided.

{{%expand "See example domestic shipment request" %}}
```http
POST /v1/shipments HTTP/1.1
Authorization: Bearer [access-token]
Content-Type: application/vnd.api+json

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
        "phone_number": "+44 234 567 890"
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
        "phone_number": "+44 234 567 890"
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
        "phone_number": "+44 234 567 890"
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

{{%expand "See example international shipment request that includes customs" %}}
```http
POST /v1/shipments HTTP/1.1
Authorization: Bearer [access-token]
Content-Type: application/vnd.api+json

{
  "data": {
    "type": "shipments",
    "attributes": {
      "recipient_address": {
        "street_1": "5th Avenue",
        "street_number": 890,
        "postal_code": "10021",
        "city": "New York",
        "country_code": "US",
        "first_name": "Bruce",
        "last_name": "Banner",
        "email": "bruce.banner@example-email.com",
        "phone_number": "+1 234 555 6789"
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
        "phone_number": "+44 234 567 890"
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
        "phone_number": "+44 234 567 890"
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

{{% expand "See example domestic shipment response" %}}
```http
HTTP/1.1 201 Created
Content-Type: application/vnd.api+json

{
  "data": {
    "type": "shipments",
    "id": "6b5db4f9-37ea-437a-b2f9-7f2d146d5bb8",
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
        "phone_number": "+44 234 567 890"
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
        "phone_number": "+44 234 567 890"
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
        "phone_number": "+44 234 567 890"
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
    "links": {
      "self": "https://api.myparcel.com/v1/shipments/6b5db4f9-37ea-437a-b2f9-7f2d146d5bb8"
    },
    "relationships": {
      "shop": {
        "data": {
          "type": "shops",
          "id": "35eddf50-1d84-47a3-8479-6bfda729cd99"
        },
        "links": {
          "related": "https://api.myparcel.com/v1/shops/35eddf50-1d84-47a3-8479-6bfda729cd99"
        }
      },
      "service_contract": {
        "data": {
          "type": "service-contracts",
          "id": "af5e65b6-a709-4f61-a565-7c12a752482f"
        },
        "links": {
          "related": "https://api.myparcel.com/v1/service-contracts/af5e65b6-a709-4f61-a565-7c12a752482f"
        }
      },
      "shipment_status": {
        "data": {
          "id": "5781d596-1bf2-44ba-bcaf-d356117cbb94",
          "type": "shipment-statuses"
        },
        "links": {
          "related": "https://api.myparcel.com/v1/shipments/6b5db4f9-37ea-437a-b2f9-7f2d146d5bb8/statuses/5781d596-1bf2-44ba-bcaf-d356117cbb94"
        }
      },
      "files": {
        "links": {
          "related": "https://api.myparcel.com/v1/shipments/6b5db4f9-37ea-437a-b2f9-7f2d146d5bb8/files"
        }
      }
    }
  }
}
```
{{% /expand %}}

