+++
title = "RPC endpoints"
description = "MyParcel.com API RPC endpoints."
weight = 6
+++

The MyParcel.com API consists mostly of RESTful endpoints that work with resources as described in the [json-api](https://jsonapi.org) standard. However, there are situations where it makes more sense to step away from that standard. In these cases RPC endpoints might be a more fitting solution. These endpoints allow you to call an action on the API for a specific purpose that would not make sense in a resource oriented structure.

## RPC structure

While RESTful endpoints consist solely of nouns, RPC endpoints take the following form:

```
verb-noun
```

For example, to retrieve suggestions for an address, you would make a *POST* request to `/suggest-address`.

These endpoints are either **GET** or **POST**. The content type of the request and response will be `application/json`. Not the json-api specific content type the resource endpoints use.

{{% notice warning %}}
When there is an error during an RPC request, it will still return a json-api error with the content type `application/vnd.api+json`.
{{% /notice %}}


