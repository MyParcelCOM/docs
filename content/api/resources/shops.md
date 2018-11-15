+++
title = "Shops"
description = "A user needs at least one shop to be able to create shipments."
weight = 16
+++

A user can have one or more shops and be able to read or manage attached resources like shipments. A shipment
is always associated with a shop.

## Attributes

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/Shops)

Attribute      |  Type                                              | Description                                              | Required
-------------- | --------------------------------------------------- | -------------------------------------------------------- | --------
name           | string                                              | Name of the shop                                         | ✓
website        | string                                              | URL of the website of the shop                           |
return_address | [address](/api/resources/common-objects/addresses/) | The address a parcel is returned to when delivery fails. |
sender_address | [address](/api/resources/common-objects/addresses/) | The address parcels for this shop are sent from.         |
created_at     | integer                                             | Unix timestamp when the shop was created.                |

Relationship | Type                                                                                         | Description                          | Required
------------ | --------------------------------------------------------------------------------------------- | ------------------------------------ | --------
organization | [organizations](https://docs.myparcel.com/api-specification/#/Organizations/get_organizations) | The organization the shop belongs to | ✓

## Endpoints

{{%expand "GET /shops" %}}
Retrieving a list of shops.

**Scope**

Any of the following scopes:

- `shops.show`
- `shops.manage`

**Request**
```http
GET /shops HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/shops
```

**Response**
```json
{
  "data": [
    {
      "type": "shops",
      "id": "35eddf50-1d84-47a3-8479-6bfda729cd99",
      "attributes": {
        "name": "MyParcel.com",
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
          "phone_number": "+31 234 567 890"
        },
        "website": "https://www.myparcel.com",
        "created_at": 1504801719
      },
      "relationships": {
        "organization": {
          "data": {
            "type": "organizations",
            "id": "9cdf86e8-333f-4ed9-bb31-4935c780c947"
          },
          "links": {
            "related": "https://sandbox-api.myparcel.com/organizations/9cdf86e8-333f-4ed9-bb31-4935c780c947"
          }
        }
      },
      "links": {
        "self": "https://sandbox-api.myparcel.com/shops/35eddf50-1d84-47a3-8479-6bfda729cd99"
      }
    }
  ],
  "meta": {
    "total_pages": 1,
    "total_records": 1
  },
  "links": {
    "self": "https://sandbox-api.myparcel.com/shops?page[number]=1&page[size]=30",
    "first": "https://sandbox-api.myparcel.com/shops?page[number]=1&page[size]=30",
    "last": "https://sandbox-api.myparcel.com/shops?page[number]=1&page[size]=30"
  }
}
```
{{% /expand%}}

{{%expand "GET /shops/shop_id" %}}
Retrieve a specific shop.

**Scope**

Any of the following scopes:

- `shops.show`
- `shops.manage`

**Request**
```http
GET /shops/{shop_id} HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/shops/35eddf50-1d84-47a3-8479-6bfda729cd99
```

**Response**
```json
{
  "data": {
    "type": "shops",
    "id": "35eddf50-1d84-47a3-8479-6bfda729cd99",
    "attributes": {
      "name": "MyParcel.com",
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
        "phone_number": "+31 234 567 890"
      },
      "website": "https://www.myparcel.com",
      "created_at": 1504801719
    },
    "relationships": {
      "organization": {
        "data": {
          "type": "organizations",
          "id": "9cdf86e8-333f-4ed9-bb31-4935c780c947"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/organizations/9cdf86e8-333f-4ed9-bb31-4935c780c947"
        }
      }
    },
    "links": {
      "self": "https://sandbox-api.myparcel.com/shops/35eddf50-1d84-47a3-8479-6bfda729cd99"
    }
  }
}
```
{{% /expand%}}

{{%expand "POST shops" %}}
Create a shop.

**Scope**

- `shops.manage`

**Request**
```http
POST /shops HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/shops
```
```json
{
  "data": {
    "type": "shops",
    "attributes": {
      "name": "MyParcel.com",
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
        "phone_number": "+31 234 567 890"
      },
      "website": "https://www.myparcel.com"
    },
    "relationships": {
      "organization": {
        "data": {
          "type": "organizations",
          "id": "9cdf86e8-333f-4ed9-bb31-4935c780c947"
        }
      }
    }
  }
}
```

**Response**
```json
{
  "data": {
    "type": "shops",
    "id": "35eddf50-1d84-47a3-8479-6bfda729cd99",
    "attributes": {
      "name": "MyParcel.com",
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
        "phone_number": "+31 234 567 890"
      },
      "website": "https://www.myparcel.com",
      "created_at": 1504801719
    },
    "relationships": {
      "organization": {
        "data": {
          "type": "organizations",
          "id": "9cdf86e8-333f-4ed9-bb31-4935c780c947"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/organizations/9cdf86e8-333f-4ed9-bb31-4935c780c947"
        }
      }
    },
    "links": {
      "self": "https://sandbox-api.myparcel.com/shops/35eddf50-1d84-47a3-8479-6bfda729cd99"
    }
  }
}
```
{{% /expand%}}

{{%expand "PATCH /shops/shop_id" %}}
Update an existing shop.

**Scope**

- `shops.manage`

**Request**

*In this example we're changing the name of the shop to "Sherlock Holmes' trinkets"*

```http
PATCH /shops/{shop_id} HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/shops/35eddf50-1d84-47a3-8479-6bfda729cd99
```


```json
{
  "data": {
    "type": "shops",
    "id": "35eddf50-1d84-47a3-8479-6bfda729cd99",
    "attributes": {
      "name": "Sherlock Holmes' trinkets",
    }
  }
}
```

**Response**
```json
{
  "data": {
    "type": "shops",
    "id": "35eddf50-1d84-47a3-8479-6bfda729cd99",
    "attributes": {
      "name": "Sherlock Holmes' trinkets",
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
        "phone_number": "+31 234 567 890"
      },
      "website": "https://www.myparcel.com",
      "created_at": 1504801719
    },
    "relationships": {
      "organization": {
        "data": {
          "type": "organizations",
          "id": "9cdf86e8-333f-4ed9-bb31-4935c780c947"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/organizations/9cdf86e8-333f-4ed9-bb31-4935c780c947"
        }
      }
    },
    "links": {
      "self": "https://sandbox-api.myparcel.com/shops/35eddf50-1d84-47a3-8479-6bfda729cd99"
    }
  }
}
```
{{% /expand%}}
