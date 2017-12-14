+++
title = "API"
weight = 1
+++

This part of the documentation describes how you could talk directly to our REST API. For convenience we advice you to use our [PHP-SDK](/php-sdk) whenever possible.

## Getting Started
Before you dive into our documentation and [API specification](https://docs.myparcel.com/api-specification) we want to give you a little introduction to the [JSON API specification](http://jsonapi.org/format/). If you already now it, implementing our API just got even easier. But don't worry if you don't. It is an easy spec to comprehend. We wrote up a quick reference with some pointers below as a quick crash course.

### Content-Type
The JSON API specification describes its own content type. Whenever you use the `Content-Type` or `Accept` headers, it should be set to `application/vnd.api+json`. With small exceptions here and there where you are deliberately requesting other file formats. For example when requesting label files, you could use `Accept: application/pdf`.

Don't worry about forgetting these headers. When left out, our API will default to the `application/vnd.api+json` content type.

### Document Structure
Requests/responses to/from the API always have the following structure:

- A root JSON object with at least 1 of the following.
  - **data**: the documents "primary data". Always either an `object`, `array` or `null`.
  - **errors**: an array of [error objects](http://jsonapi.org/format/#errors)
  - **meta**: a [meta object](http://jsonapi.org/format/#document-meta) that contains non-standard meta-information

For example, the request to our api root: <br>
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
Below you will find an example of a simple resource object. It always contains the *type* of the resource and its *id*. Optionally are also the *attributes* of the resource and *relationships*. Normally when requesting a resource, the attributes are present in the response. But the attributes of a relationship are left out. If you need the attributes of the related resource, you can retrieve it by following the corresponding link. (More on links below the example.)

```json
{
  "data": {
    "type": "shipments",
    "id": "c9ce29a4-6325-11e7-907b-a6006ad3dba0",
    "attributes": {
      // ... this shipment's attributes
    },
    "links": {
      "self": "https://api.myparcel.com/v1/shipments/c9ce29a4-6325-11e7-907b-a6006ad3dba0"
    },
    "relationships": {
      "service": {
        "data": {
          "type": "services",
          "id": "8f7b9c85-e5de-4750-b4dd-5a203d0617bc"
        },
        "links": {
          "related": "https://api.myparcel.com/v1/services/c9ce29a4-6325-11e7-907b-a6006ad3dba0"
        }
      }
    }
  }
}
```

There are two links in the above example. The first one is the **self** link that points to the url where you can request the given resource. Most of the time this isn't really useful since you have the resource in front of you. But it is there for when you do need it.

The other link looks very similar, but belongs to a relationship. It has the key **related** and points to the endpoint to retrieve the full resource. The reason this is not called **self** is because the self link would refer to the relationship itself, instead of the resource that is pointed towards.

Aside from these **self** and **related** links, any kind of useful link could be provided. Just as seen in our api root request in the example above.

### Pagination
Something about pagination...

### Further Reading
Links to the JSON API spec and our API spec?
