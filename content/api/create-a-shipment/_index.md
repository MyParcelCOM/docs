+++
title = "Create a shipment"
description = "The resources to use when creating a shipment."
weight = 2
+++

Before printing a label to put on a parcel, a [shipment](/api/resources/shipments) resource should be created in the MyParcel.com API.  
Creating such a shipment is done by making a `POST` request to the `/shipments` endpoint.  

In order to be able to create a shipment in the MyParcel.com API, the `shipments.manage` [scope](/api/authentication/scopes) needs to be present in the access token used in the request.

## Minimum shipment requirements
In order to successfully register a shipment with a carrier, the following attributes and relationships are always required.

### Attributes
The following attributes should always be included in a shipment request:

Attribute           | Description      
------------------- | ----------------- 
recipient_address   | [Address](/api/resources/common-objects/addresses) object containing information of the shipments recipient address.
sender_address      | [Address](/api/resources/common-objects/addresses) object containing information about where the shipment is sent from.
return_address      | [Address](/api/resources/common-objects/addresses) object containing information about where the shipment should be returned to.
physical_properties | [Physical properties](/api/resources/shipments#physical-properties) object containing information about the dimensions and weight of the shipment.

{{% notice note %}}
Depending on the carrier, additional information may be required. 
For more information, see our page about **[carrier specific requirements](/api/carrier-specific-requirements)**.
{{% /notice %}}

### Relationships
The shop relationship is always required in any shipment creation request. 
The service and contract relationships are required for registering the shipment with the carrier, 
but do not necessarily have to be set in the initial shipment creation request.

Relationship        | Description
------------------- | ------------------
shop                | A [shop](/api/resources/shops) relationship object containing the uuid of the shop for which this shipment should be created.
service             | A [service](/api/resources/services) relationship object containing the uuid of the desired service.
contract            | A [contract](/api/resources/contracts) relationship object containing the uuid of the desired contract.

Additionally you could add a `service_options` relationship if you would like to add service options to the shipment. For more information, see the [service options resource page](/api/resources/service-options).

#### Shop relationship
A shipment is always created for a shop. The shop's `uuid` should therefore always be included the shipment request. 
To retrieve your shop's `uuid`, simply call the `/shops` endpoint to retrieve all `shops` resources available to you.
You can then include the desired shop's `uuid` in the shipment request. For an overview of the shop resource, it's attributes and relationships and how to retrieve them, visit the [resource page on shops](/api/resources/shops).

#### Service relationship
Carriers often have different services available to ship parcels with. These are defined in the MyParcel.com API and should be included as a relationship when creating a shipment. Since services are [region](/api/resources/regions) specific they should be chosen with the shipments `sender_address` and `recipient_address` attributes in mind. A shipment from England to England will not be valid if the chosen service only has Spain as destination. For an overview of the service resource, its attributes and relationships and how to retrieve them, visit the [resource page on services](/api/resources/services). 

#### Contract relationship
Besides a service and a shop, a shipment needs a contract relationship. Contracts are used to communicate to the carrier which party is making the request. The carrier then bills that party accordingly. Different contracts can have different credentials, rates and even services, so it might be the case that a service is available for two different prices or it might not be available at all. This is what the contracts relationship is for. To create a valid shipment, the related contract of a shipment should be for the same carrier as the chosen service. For an overview of the contract resource, it's attributes and relationships and how to retrieve them, visit the [resource page on contracts](/api/resources/contracts).

#### Service rates
A service rate can not be linked to a shipment directly, but should instead be used to consider which service or contract to use for a shipment. The service rate resource is a combination of a service and contract and details the specifics of said service and contract. It contains information on the price, maximum dimensions, weight range and lists which service options are available for this specific combination of service and contract. More information on service rates can be found on the [service rate resource page](/api/resources/service-rates).

### Customs information
When shipping from one country to another, chances are that your parcel will have to go through customs. 
The required customs information can be included in the shipment request. 
Whenever the [customs](/api/resources/shipments#customs) object is present in the shipment request, the [items](/api/resources/shipments#items) object is also required.
Furthermore, a `phone_number` of the recipient and `description` of the shipment are also required for customs related shipments.
A customs declaration form will be automatically generated and returned when printing the label for this shipment.

## Registering your shipment with the carrier
After a shipment is created, the next step is the registration of your shipment with the carrier that corresponds to the chosen `service` and `contract`.
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
POST /shipments HTTP/1.1
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiSm9obiBEb2UiLCJhZG1pbiI6dHJ1ZX0.OLvs36KmqB9cmsUrMpUutfhV52_iSz4bQMYJjkI_TLQ
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
      "service": {
        "data": {
          "type": "services",
          "id": "af5e65b6-a709-4f61-a565-7c12a752482f"
        }
      },
      "contract": {
        "data": {
          "type": "contracts",
          "id": "448e55b3-0829-4783-a9ca-1078697cdb46"
        }
      }
    }
  }
}
```
{{% /expand %}}

{{%expand "See example international shipment request that includes customs" %}}
```http
POST /shipments HTTP/1.1
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiSm9obiBEb2UiLCJhZG1pbiI6dHJ1ZX0.OLvs36KmqB9cmsUrMpUutfhV52_iSz4bQMYJjkI_TLQ
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
      "service": {
        "data": {
          "type": "services",
          "id": "af5e65b6-a709-4f61-a565-7c12a752482f"
        }
      },
      "contract": {
        "data": {
          "type": "contracts",
          "id": "448e55b3-0829-4783-a9ca-1078697cdb46"
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
    "relationships": {
      "shop": {
        "data": {
          "type": "shops",
          "id": "35eddf50-1d84-47a3-8479-6bfda729cd99"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/shops/35eddf50-1d84-47a3-8479-6bfda729cd99"
        }
      },
      "service": {
        "data": {
          "type": "services",
          "id": "af5e65b6-a709-4f61-a565-7c12a752482f"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/services/af5e65b6-a709-4f61-a565-7c12a752482f"
        }
      },
      "contract": {
        "data": {
          "type": "contracts",
          "id": "448e55b3-0829-4783-a9ca-1078697cdb46"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/contracts/448e55b3-0829-4783-a9ca-1078697cdb46"
        }
      },
      "shipment_status": {
        "data": {
          "type": "shipment-statuses",
          "id": "5781d596-1bf2-44ba-bcaf-d356117cbb94"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/shipments/6b5db4f9-37ea-437a-b2f9-7f2d146d5bb8/statuses/5781d596-1bf2-44ba-bcaf-d356117cbb94"
        }
      }
    },
    "links": {
      "self": "https://sandbox-api.myparcel.com/shipments/6b5db4f9-37ea-437a-b2f9-7f2d146d5bb8",
      "files": "https://sandbox-api.myparcel.com/shipments/6b5db4f9-37ea-437a-b2f9-7f2d146d5bb8/files"
    }
  }
}
```
{{% /expand %}}

