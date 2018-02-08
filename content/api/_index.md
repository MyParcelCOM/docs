+++
title = "API"
weight = 1
+++

This part of the documentation describes how you could talk directly to our REST API. For convenience we advise you to use our [PHP-SDK](/php-sdk) whenever possible.
If you think you are ready to dive right in but just want to see all the available resources in more detail you can look at the [API resources](/api/resources/). 
For more structural details and examples of the endpoints see the swagger [API specification](https://docs.myparcel.com/api-specification).

## Getting Started
This section is devoted to give you a little introduction to the [JSON API specification](http://jsonapi.org/format/). If you already know it, implementing our API just got even easier. But don't worry if you don't. It is an easy spec to comprehend. We wrote up a reference with some pointers below as a quick crash course.

### Content-Type
The JSON API specification describes its own content type. Whenever you use the `Content-Type` or `Accept` headers, it should be set to `application/vnd.api+json`. With small exceptions here and there where you are deliberately requesting other file formats. For example when requesting label files, you could use `Accept: application/pdf`.

Don't worry about forgetting these headers. When left out, our API will default to the `application/vnd.api+json` content type.

### Document Structure
Requests/responses to/from the API always have the following structure:

- A root JSON object with at least 1 of the following.
  - **data**: the documents "primary data". Always either an `object`, `array` or `null`.
  - **errors**: an array of [error objects](http://jsonapi.org/format/#errors)
  - **meta**: a [meta object](http://jsonapi.org/format/#document-meta) that contains non-standard meta-information

For example, the request to our API root: <br>
(Ignore the links for now. We'll get to them later.)

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
Below you will find an example of a simple resource object. It always contains the *type* of the resource and its *id*. Optionally are also the *attributes* of the resource and *relationships*. Normally when requesting a resource, the attributes are present in the response. But for the relationships the attributes are left out. If you need the attributes of the related resource, you can retrieve it by following the corresponding link. (More on links below the example.)

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
          "id": "[services-id]"
        },
        "links": {
          "related": "https://api.myparcel.com/v1/services/[services-id]"
        }
      }
    }
  }
}
```

There are two links in the above example. The first one is the **self** link that points to the url where you can request the given resource. Most of the time you won't be needing this since you already have the resource. But it is there for when you do need it.

The other link looks very similar, but belongs to a relationship. It has the key **related** and points to the endpoint to retrieve the full resource. The reason this is not called **self** is because the self link would refer to the relationship itself, instead of the resource that it is pointed towards.

Aside from these **self** and **related** links, any kind of useful link could be provided. Like the **specification** relation seen in our earlier [API root](#document-structure) request example above.

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

### Further Reading
If you would like to dive deep into the fundamentals of the JSON API specification or our own API specification, you can do so following the links below.

- [JSON API specification](http://jsonapi.org/format/)
- [MyParcel.com API specification](https://docs.myparcel.com/api-specification)
