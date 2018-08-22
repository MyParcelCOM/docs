+++
title = "API"
weight = 1
+++

This part of the documentation describes how to communicate directly with the MyParcel.com REST API. For convenience, it is advised that you use the [MyParcel.com PHP-SDK](/php-sdk) whenever possible. If you think you are ready to dive right in, but just want to see all the available resources in more detail you can look at the [API resources](/api/resources/). For more structural details and examples of the endpoints see the [MyParcel.com OpenAPI specification](https://docs.myparcel.com/api-specification).

## Getting Started
This section is devoted to give you a little introduction to the [JSON API specification](http://jsonapi.org/format/). This specification defines how resources should be requested and responses should be formatted. In case you are not familiar with this specification, you will find a reference with some pointers as a quick crash course below.

### MIME type
The JSON API specification describes its own media type: `application/vnd.api+json`. This should be used whenever you include the `Content-Type` or `Accept` headers. These headers are not mandatory, since the MyParcel.com API will default to `application/vnd.api+json` when no headers are specified.

Some endpoints offer exceptions where you are deliberately requesting other file formats. For example when requesting label files, you could use `Accept: application/pdf`.

### Document Structure
Requests to and responses from the API always have the following structure:

- A root JSON object with at least 1 of the following:
  - **data**: the documents "primary data", always either an `object`, `array` or `null`
  - **errors**: an array of [error objects](http://jsonapi.org/format/#errors)
  - **meta**: a [meta object](http://jsonapi.org/format/#document-meta) that contains non-standard meta-information

For example, the response from the API root: <br>
(ignore the links for now, they will be explained a little later on)

```http
HTTP/1.1 200 OK
Content-Type: application/vnd.api+json

{
    "meta": {
        "title": "MyParcel.com API",
        "status": "OK"
    },
    "links": {
        "specification": "https://docs.myparcel.com/api-specification"
    }
}
```

{{% notice note %}}
The `data` and `errors` top level attributes cannot coexist in the same document.
{{% /notice %}}

### Resource Object, Relationships and Links
Below you will find an example of a simple resource object. It always contains the `type` of the resource and optionally its `id`,  `attributes` and `relationships` to other resources. Normally when requesting a resource, the `attributes` are present in the response. But for the relationships, the `attributes` are left out. If you need the `attributes` of the related resource, you can retrieve it by following the corresponding link.

```json
{
  "data": {
    "type": "shipments",
    "id": "7b808eee-bf1c-40cd-98f2-3c335a06417e",
    "attributes": {
      "recipient_address": "...",
      "sender_address": "...",
      "return_address": "...",
      "description": "Order #8008135",
      "barcode": "3SABCD0123456789",
      "tracking_code": "3SABCD0123456789",
      "price": {
        "amount": 999,
        "currency": "EUR"
      },
      "physical_properties": "..."
    },
    "links": {
      "self": "https://api.myparcel.com/v1/shipments/7b808eee-bf1c-40cd-98f2-3c335a06417e"
    },
    "relationships": {
      "service-contract": {
        "data": {
          "type": "service-contracts",
          "id": "35eddf50-1d84-47a3-8479-6bfda729cd99"
        },
        "links": {
          "related": "https://api.myparcel.com/v1/service-contracts/35eddf50-1d84-47a3-8479-6bfda729cd99"
        }
      },
      "shop": {
        "data": {
          "type": "shops",
          "id": "68738eb4-7f25-43bb-81a9-2d78b9aef9df"
        },
        "links": {
          "related": "https://api.myparcel.com/v1/shops/68738eb4-7f25-43bb-81a9-2d78b9aef9df"
        }
      }
    }
  }
}
```

There are two types of links in the above example. The first one is the `self` link that points to the url where you can request the given resource. Most of the time you won't be needing this since you already have the resource. But it is there for when you do need it.

The other link looks very similar, but belongs to a relationship. It has the key `related` and points to the endpoint to retrieve the full resource. The reason this is not called `self` is because the self link would refer to the relationship itself, instead of the resource that it is pointed towards.

Aside from these `self` and `related` links, any kind of useful link could be provided. Like the `specification` link seen in the[API root](#document-structure) request example above.

### Pagination
Most responses that serve multiple resource items use pagination. The MyParcel.com API offers a few helpers to easily create your own pagination controls or retrieve all items in batches.

As you can see below, the API provides you the total number of pages as well as the total records that can be retrieved. Alongside this is a list of links that correspond to all the actions normally provided by pagination. You could map your own pagination controls to these links (and for example show and hide the next/prev buttons based on the presence of the link in the current response).

You can retrieve all available records by looping through the pagination. As long as there is a `next` link, there are more records to retrieve. You are done retrieving records as soon as the `next` link is no longer present in the last response.

```json
{
  "data": [
    {
      "type": "shipments",
      "id": "15d02deb-1601-4c22-a1d7-785a02de3576",
      "attributes": "...",
      "relationships": "...",
      "links": "..."
    }, 
    {
      "type": "shipments",
      "id": "8de25324-4f4b-4156-bf82-6e66eda349a6",
      "attributes": "...",
      "relationships": "...",
      "links": "..."    
    }, 
    {
      "etc...": "..."
    }
  ],
  "meta": {
    "total_pages": 13,
    "total_records": 373
  },
  "links": {
    "self": "https://api.myparcel.com/v1/shipments?page[size]=30&page[number]=3",
    "first": "https://api.myparcel.com/v1/shipments?page[size]=30&page[number]=1",
    "prev": "https://api.myparcel.com/v1/shipments?page[size]=30&page[number]=2",
    "next": "https://api.myparcel.com/v1/shipments?page[size]=30&page[number]=4",
    "last": "https://api.myparcel.com/v1/shipments?page[size]=30&page[number]=13"
  }
}
```

##### Pagination parameters
These are the parameters used for pagination:

Parameter                  | Description | Value | Default
-------------------------- |:------------:|:-----------:|:-----:
page[size]                 | Determines how many record you retrieve per page        | Any number higher than 0 and lower or the same as the max record size. | 30
page[number]               | Indicates from which page the records are retrieved     | Any number higher than 0. | 1

When an unsupported value is used for one of the parameters the default value will be used instead. If an positive page number is used that is higher than the amount of excising pages, the API wont be able to find any records and will simply return an empty record set instead.

##### Max record size
The default max record size is **30**. There are some resources listed below that override the default max record size with a different value:

Resource                  | Max record size 
------------------------- |:------------:
Regions                   | **500**     

### Errors
If the top level `errors` attribute exists, it can contain one of the following errors:

Error code                  | Error number | Description
--------------------------- |:------------:|:-----------
NOT_FOUND                   | 10000        | The requested endpoint could not be found.
INTERNAL_SERVER_ERROR       | 10001        | An internal server error has occurred, this is usually a problem on the MyParcel.com end. Please contact support if it persists.
RESOURCE_NOT_FOUND          | 10002        | The resource you are trying to get the data of could not be found.
INVALID_JSON_SCHEMA         | 10003        | The request does not conform to the [MyParcel.com API specification](/api-specification).
INVALID_REQUEST_HEADER      | 10004        | One or more of your request headers is invalid. 
RESOURCE_CANNOT_BE_MODIFIED | 10005        | Either this resource can't be modified or you do not have permission to modify this resource.
INVALID_ERROR_SCHEMA        | 10006        | An error was thrown during the request to an external source. No more information can be provided since the returned error was improperly formatted.
RESOURCE_CONFLICT           | 10007        | The `type` or `id` of one of the resources was not computable or the resource `id` is not valid.
UNPROCESSABLE_ENTITY        | 10008        | The server understands the content type and the syntax is correct, but the server was unable to process the contained instructions.
MISSING_BILLING_INFORMATION | 11000        | In order to complete this request, some missing billing information should be provided first. 
EXTERNAL_REQUEST_ERROR      | 13001        | An error occurred while making a request to an external service. When available, details can be found in the meta of the response.
CARRIER_API_ERROR           | 13002        | There was a problem with the request to the carrier. The original response can be found in the meta under `carrier_response`.
AUTH_INVALID_CLIENT         | 14000        | The supplied client credentials are invalid or the client does not have access to this grant type.
AUTH_INVALID_SCOPE          | 14001        | The requested scope is not available for your client.
AUTH_INVALID_TOKEN          | 14002        | The provided access token does not seem to be valid.
AUTH_MISSING_TOKEN          | 14003        | An access token is required but no access token was provided.
AUTH_MISSING_SCOPE          | 14004        | The used access token does not contain the required scope(s).
AUTH_SERVER_EXCEPTION       | 14050        | Unable to process the OAuth request. This is a generic OAuth error with no direct known cause. Please contact support if the problem persists.

The error responses conform to the JSON API standard. For more information about what they might contain, visit [the errors section of the specification](http://jsonapi.org/format/#errors).

### Further Reading
If you would like to dive deep into the fundamentals of the JSON API specification or the MyParcel.com API specification, you can do so following the links below.

- [JSON API specification](http://jsonapi.org/format/)
- [MyParcel.com API specification](https://docs.myparcel.com/api-specification)
