+++
title = "Contracts"
description = "Contracts define the service and prices available for a carrier."
weight = 10
+++

Contracts define the service, service options and prices available for a carrier. A contract might be available because it is shared with you or because you added your own contract (including API credentials for that carrier).

## Attributes

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/Contracts)

| Attribute   | Type                                                                                            | Description                                                                                                                                                                                                                                         | Required  |
|-------------|-------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------|
| name        | string                                                                                          | A name for users to recognize the contract by.                                                                                                                                                                                                      | ✓         |
| currency    | string enum: <br>`EUR`<br> `GBP`                                                                    | Currency code in [ISO 4217](https://en.wikipedia.org/wiki/ISO_4217) format.                                                                                                                                                                         | ✓         |
| credentials | See `credentials_format` for [carriers resource](http://localhost:1313/api/resources/carriers/) | The carriers resource has a `credentials_format` describing how the credentials for that specific carrier should be provided. Credentials will not be returned for a get request and are stored encrypted.                                          | ✓         |
| status      | string enum: <br>`pending` <br>`active` <br>`inactive` <br>`invalid`                                | Newly created contracts are pending until verified. The user can manually switch between active and inactive once verified. After updating credentials, the contract goes back to pending. If verification fails, the contract will become invalid. | read-only |

| Relationship | Type                                                                                       | Description                           | Required |
|--------------|--------------------------------------------------------------------------------------------|---------------------------------------|----------|
| carrier      | [carriers](/api/resources/carriers)                                                        | The carrier the contract is used for. | ✓        |
| owner        | [brokers](/api/resources/brokers) <br>OR <br>[organizations](/api/resources/organizations) | The owner of the contract.            | ✓        |

## Endpoints

{{%expand "GET /contracts" %}}

Retrieving a list of contracts.

**Scope**

Any of the following scopes:

- `shipments.manage`
- `organizations.manage`

**Request**
```http
GET /contracts HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/contracts
```

**Response**
```json
{
  "data": [
    {
      "type": "contracts",
      "id": "2cb32706-5762-4b96-9212-327e6afaeeff",
      "attributes": {
        "name": "My Custom Contract",
        "currency": "EUR",
        "status": "active"
      },
      "relationships": {
        "carrier": {
          "data": {
            "type": "carriers",
            "id": "be7f6752-34e0-49a1-a832-bcc209450ea9"
          },
          "links": {
            "related": "https://sandbox-api.myparcel.com/v1/carriers/be7f6752-34e0-49a1-a832-bcc209450ea9"
          }
        },
        "owner": {
          "data": {
            "type": "organizations",
            "id": "9cdf86e8-333f-4ed9-bb31-4935c780c947"
          },
          "links": {
            "related": "https://sandbox-api.myparcel.com/v1/organizations/9cdf86e8-333f-4ed9-bb31-4935c780c947"
          }
        }
      }
    }
  ],
  "meta": {
    "total_pages": 13,
    "total_records": 373
  },
  "links": {
    "self": "https://sandbox-api.myparcel.com/v1/contracts?page[number]=3&page[size]=30",
    "first": "https://sandbox-api.myparcel.com/v1/contracts?page[number]=1&page[size]=30",
    "prev": "https://sandbox-api.myparcel.com/v1/contracts?page[number]=2&page[size]=30",
    "next": "https://sandbox-api.myparcel.com/v1/contracts?page[number]=4&page[size]=30",
    "last": "https://sandbox-api.myparcel.com/v1/contracts?page[number]=13&page[size]=30"
  }
}
```

{{% /expand %}}

{{%expand "GET /contracts/{contract_id}" %}}

Retrieving a specific contract.

**Scope**

Any of the following scopes:

- `shipments.manage`
- `organizations.manage`

**Request**

```http
GET /contracts/{contract_id} HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/contracts/2cb32706-5762-4b96-9212-327e6afaeeff
```

**Response**

```json
{
  "data": {
    "type": "contracts",
    "id": "2cb32706-5762-4b96-9212-327e6afaeeff",
    "attributes": {
      "name": "My Custom Contract",
      "currency": "EUR",
      "status": "active"
    },
    "relationships": {
      "carrier": {
        "data": {
          "type": "carriers",
          "id": "be7f6752-34e0-49a1-a832-bcc209450ea9"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/v1/carriers/be7f6752-34e0-49a1-a832-bcc209450ea9"
        }
      },
      "owner": {
        "data": {
          "type": "organizations",
          "id": "9cdf86e8-333f-4ed9-bb31-4935c780c947"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/v1/organizations/9cdf86e8-333f-4ed9-bb31-4935c780c947"
        }
      }
    }
  }
}
```

{{% /expand %}}

{{%expand "POST /contracts" %}}

Create a contract.

**Scope**

Any of the following scopes:

- `organizations.manage`

**Request**

```http
POST /contracts HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/contracts
```

```json
{
  "data": {
    "type": "contracts",
    "attributes": {
      "name": "My Custom Contract",
      "currency": "EUR",
      "credentials": {
        "api_username": "your_api_username",
        "api_password": "your_api_password"
      }
    },
    "relationships": {
      "carrier": {
        "data": {
          "type": "carriers",
          "id": "be7f6752-34e0-49a1-a832-bcc209450ea9"
        }
      },
      "owner": {
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
    "type": "contracts",
    "id": "2cb32706-5762-4b96-9212-327e6afaeeff",
    "attributes": {
      "name": "My Custom Contract",
      "currency": "EUR",
      "status": "active"
    },
    "relationships": {
      "carrier": {
        "data": {
          "type": "carriers",
          "id": "be7f6752-34e0-49a1-a832-bcc209450ea9"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/v1/carriers/be7f6752-34e0-49a1-a832-bcc209450ea9"
        }
      },
      "owner": {
        "data": {
          "type": "organizations",
          "id": "9cdf86e8-333f-4ed9-bb31-4935c780c947"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/v1/organizations/9cdf86e8-333f-4ed9-bb31-4935c780c947"
        }
      }
    }
  }
}
```

{{% /expand %}}

{{%expand "PATCH /contracts/{contract_id}" %}}

Update an existing contract.

**Scope**

Any of the following scopes:

- `organizations.manage`

**Request**

*In this example we're changing the status of the contract to "inactive"*

```http
PATCH /contracts/{contract_id} HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/contracts/2cb32706-5762-4b96-9212-327e6afaeeff
```


```json
{
  "data": {
    "type": "contracts",
    "id": "2cb32706-5762-4b96-9212-327e6afaeeff",
    "attributes": {
      "status": "inactive"
    }
  }
}
```

**Response**

```json
{
  "data": {
    "type": "contracts",
    "id": "2cb32706-5762-4b96-9212-327e6afaeeff",
    "attributes": {
      "name": "My Custom Contract",
      "currency": "EUR",
      "status": "inactive"
    },
    "relationships": {
      "carrier": {
        "data": {
          "type": "carriers",
          "id": "be7f6752-34e0-49a1-a832-bcc209450ea9"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/v1/carriers/be7f6752-34e0-49a1-a832-bcc209450ea9"
        }
      },
      "owner": {
        "data": {
          "type": "organizations",
          "id": "9cdf86e8-333f-4ed9-bb31-4935c780c947"
        },
        "links": {
          "related": "https://sandbox-api.myparcel.com/v1/organizations/9cdf86e8-333f-4ed9-bb31-4935c780c947"
        }
      }
    }
  }
}
```

{{% /expand %}}
