+++
title = "API"
weight = 1
+++

This part of the documentation describes how you could communicate directly with the MyParcel.com API. For convenience we advise you to use the [PHP-SDK](/php-sdk) whenever possible. If you think you are ready to dive right in but just want to see all the available resources in more detail you can look at the [API resources](/api/resources/). For more structural details and examples of the endpoints see the [API specification](https://docs.myparcel.com/api-specification).

## Getting Started
This section is devoted to give you a little introduction to the [JSON API specification](http://jsonapi.org/format/). This specification defines how resources should be requested and responses should be formatted. In case you are not familiar with this specification, we wrote up a reference with some pointers below as a quick crash course.

### Content-Type
The JSON API specification describes its own content type: `application/vnd.api+json`. This should be used whenever you include the `Content-Type` or `Accept` headers. These headers are not mandatory, our API will default to `application/vnd.api+json` when no headers are specified.

Some endpoints offer exceptions where you are deliberately requesting other file formats. For example when requesting label files, you could use `Accept: application/pdf`.

### Document Structure
Requests to and responses from the API always have the following structure:

- A root JSON object with at least 1 of the following:
  - **data**: the documents "primary data", always either an `object`, `array` or `null`
  - **errors**: an array of [error objects](http://jsonapi.org/format/#errors)
  - **meta**: a [meta object](http://jsonapi.org/format/#document-meta) that contains non-standard meta-information

For example, the request to our API root: <br>
(ignore the links for now, we will get to them later)

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
The data and errors top level attributes cannot coexist in the same document.
{{% /notice %}}

### Resource Object, Relationships and Links
Below you will find an example of a simple resource object. It always contains the **type** of the resource and its **id**. Optionally are the **attributes** of the resource and **relationships**. Normally when requesting a resource, the attributes are present in the response. But for the relationships the attributes are left out. If you need the attributes of the related resource, you can retrieve it by following the corresponding link. (more on links below the example)

```json
{
  "data": {
    "type": "shipments",
    "id": "[shipment-id]",
    "attributes": {
      // ... this shipment's attributes
    },
    "links": {
      "self": "https://api.myparcel.com/v1/shipments/[shipment-id]"
    },
    "relationships": {
      "service": {
        "data": {
          "type": "services",
          "id": "[service-id]"
        },
        "links": {
          "related": "https://api.myparcel.com/v1/services/[service-id]"
        }
      }
    }
  }
}
```

There are two links in the above example. The first one is the **self** link that points to the url where you can request the given resource. Most of the time you won't be needing this since you already have the resource. But it is there for when you do need it.

The other link looks very similar, but belongs to a relationship. It has the key **related** and points to the endpoint to retrieve the full resource. The reason this is not called **self** is because the self link would refer to the relationship itself, instead of the resource that it is pointed towards.

Aside from these **self** and **related** links, any kind of useful link could be provided. Like the **specification** link seen in our earlier [API root](#document-structure) request example above.

### Pagination
Most responses that serve multiple resource items use pagination. Our pagination has a few helpers to easily create your own pagination controls or retrieve all items in batches.

As you can see below, the API provides you the total number of pages as well as the total records that can be retrieved. Alongside this is a list of links that correspond to all the actions normally provided by pagination. You could map your own pagination controls to these links (and for example show and hide the next/prev buttons based on the presence of the link in the current response).

You can retrieve all records available by looping through the pagination. As long as there is a **next** link, there are more records to retrieve. You are done retrieving records as soon as the next link is no longer present in the last response.

```json
{
  "data": [
    // ... A batch of resource items
  ],
  "meta": {
    "total_pages": 13,
    "total_records": 373
  },
  "links": {
    "self": "https://api.myparcel.com/v1/shipments?page[number]=3&page[size]=30",
    "first": "https://api.myparcel.com/v1/shipments?page[number]=1&page[size]=30",
    "prev": "https://api.myparcel.com/v1/shipments?page[number]=2&page[size]=30",
    "next": "https://api.myparcel.com/v1/shipments?page[number]=4&page[size]=30",
    "last": "https://api.myparcel.com/v1/shipments?page[number]=13&page[size]=30"
  }
}
```

### Errors
If the top level errors attributes exists it can contain one of the following errors:

Error code                  | Error number | Description
--------------------------- |:------------:|:-----------
NOT_FOUND                   | 10000        | Not Found
INTERNAL_SERVER_ERROR       | 10001        | Internal Server Error
RESOURCE_NOT_FOUND          | 10002        | Resource Not Found
INVALID_JSON_SCHEMA         | 10003        | Invalid JSON Schema
INVALID_REQUEST_HEADER      | 10004        | Invalid Request Header
RESOURCE_CANNOT_BE_MODIFIED | 10005        | Resource Cannot Be Modified
INVALID_ERROR_SCHEMA        | 10006        | Invalid Error Schema
RESOURCE_CONFLICT           | 10007        | Resource Conflict
UNPROCESSABLE_ENTITY        | 10008        | Unprocessable entity
EXTERNAL_REQUEST_ERROR      | 13001        | External Request Error
CARRIER_API_ERROR           | 13002        | Carrier API Error
INVALID_SECRET              | 13003        | Invalid Secret
AUTH_INVALID_CLIENT         | 14000        | Invalid OAuth Client
AUTH_INVALID_SCOPE          | 14001        | Scope Not Available To Client
AUTH_INVALID_TOKEN          | 14002        | Access Token Is Invalid
AUTH_MISSING_TOKEN          | 14003        | No Access Token Provided
AUTH_MISSING_SCOPE          | 14004        | Access Token Is Invalid
AUTH_SERVER_EXCEPTION       | 14050        | Unable To Process OAuth Request

### Further Reading
If you would like to dive deep into the fundamentals of the JSON API specification or our own API specification, you can do so following the links below.

- [JSON API specification](http://jsonapi.org/format/)
- [MyParcel.com API specification](https://docs.myparcel.com/api-specification)
