+++
title = "Hooks"
description = "Hooks are there to automate processes on the API."
weight = 6
+++

Hooks are used to automate processes in the API.  
A hook listens to certain [triggers](/api/resources/hooks/trigger) and performs its associated [action](/api/resources/hooks/action).  

## Attributes

{{< icon fa-file-text-o >}}[API specification](/api-specification#/Hooks)

| Attribute     | Type                                                                  | Description                                                                                                               | Required  |
|---------------|-----------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------|-----------|
| Name          | string                                                                | A name for users to recognize the hook by.                                                                                | ✓         |
| Order         | integer                                                               | Position of the hook in the queue of hooks when multiple hooks apply (lower order indicates it will be executed earlier). | ✓         |
| Active        | boolean                                                               | Whether or not the hook should executed.                                                                                  | ✓         |
| Trigger       | [hook trigger](/api/resources/hooks/trigger)                          | Specification of what resource (and action) the hook listens to and additional optional predicates.                       | ✓         |
| Action        | [hook action](/api/resources/hooks/action)                            | Specification of what should be performed when the hook gets executed.                                                    | ✓         |

| Relationship  | Type                                                                                                          | Description                                       | Required   |
|---------------|---------------------------------------------------------------------------------------------------------------|---------------------------------------------------|------------|
| Owner         | brokers <br> OR <br> [organizations](/api/resources/organizations) <br> OR <br> [shops](/api/resources/shops) | The owner (generally the creator) of the hook.    | ✓          |

## Endpoints

{{%expand "GET /hooks" %}}

Retrieving a list of hooks.

**Scope**

Any of the following scopes:

- `organizations.manage`

**Request**
```http
GET /hooks HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/hooks
```

**Example response**
```json
{
  "data": [
    {
      "type": "hooks",
      "id": "be7f6752-34e0-49a1-a832-bcc209450ea9",
      "attributes": {
        "name": "DPD Next Day for medium packages",
        "order": 3,
        "active": true,
        "trigger": {
          "resource_type": "shipments",
          "resource_action": "create",
          "predicates": [
            {
              "operator": "==",
              "pointer": "/attributes/physical_properties/weight",
              "value": 1000
            }
          ]
        },
        "action": {
          "action_type": "update-resource",
          "values": [
            {
              "pointer": "/relationships/service/data/id",
              "value": "8321796d-5205-4e13-963f-61bf7db34390"
            }
          ]
        }
      },
      "relationships": {
        "owner": {
          "data": {
            "type": "organizations",
            "id": "9cdf86e8-333f-4ed9-bb31-4935c780c947"
          }
        }
      },
      "links": {
        "self": "https://sandbox-api.myparcel.com/hooks/5c868557-0827-4d21-a7f4-9820f01769f4"
      }
    }
  ],
  "meta": {
    "total_pages": 1,
    "total_records": 1
  },
  "links": {
    "self": "https://sandbox-api.myparcel.com/hooks?page[number]=1&page[size]=30",
    "first": "https://sandbox-api.myparcel.com/hooks?page[number]=1&page[size]=30",
    "last": "https://sandbox-api.myparcel.com/hooks?page[number]=1&page[size]=30"
  }
}
```

{{% /expand %}}

{{%expand "GET /hooks/{hook_id}" %}}

Retrieving a specific hook.

**Scope**

Any of the following scopes:

- `organizations.manage`

**Request**

```http
GET /hooks/{hook_id} HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/hooks/be7f6752-34e0-49a1-a832-bcc209450ea9
```

**Example response**
```json
{
  "data": {
    "type": "hooks",
    "id": "be7f6752-34e0-49a1-a832-bcc209450ea9",
    "attributes": {
      "name": "DPD Next Day for medium packages",
      "order": 3,
      "active": true,
      "trigger": {
        "resource_type": "shipments",
        "resource_action": "create",
        "predicates": [
          {
            "operator": "==",
            "pointer": "/attributes/physical_properties/weight",
            "value": 1000
          }
        ]
      },
      "action": {
        "action_type": "update-resource",
        "values": [
          {
            "pointer": "/relationships/service/data/id",
            "value": "8321796d-5205-4e13-963f-61bf7db34390"
          }
        ]
      }
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "organizations",
          "id": "9cdf86e8-333f-4ed9-bb31-4935c780c947"
        }
      }
    },
    "links": {
      "self": "https://sandbox-api.myparcel.com/hooks/5c868557-0827-4d21-a7f4-9820f01769f4"
    }
  }
}
```

{{% /expand %}}

{{%expand "POST /hooks" %}}

Create a hook.

**Scope**

Any of the following scopes:

- `organizations.manage`

**Request**

```http
POST /hooks HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/hooks
```

```json
{
  "data": {
    "type": "hooks",
    "attributes": {
      "name": "DPD Next Day for medium packages",
      "order": 3,
      "active": true,
      "trigger": {
        "resource_type": "shipments",
        "resource_action": "create",
        "predicates": [
          {
            "operator": "==",
            "pointer": "/attributes/physical_properties/weight",
            "value": 1000
          }
        ]
      },
      "action": {
        "action_type": "update-resource",
        "values": [
          {
            "pointer": "/relationships/service/data/id",
            "value": "8321796d-5205-4e13-963f-61bf7db34390"
          }
        ]
      }
    },
    "relationships": {
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

**Example response**

```json
{
  "data": {
    "type": "hooks",
    "id": "be7f6752-34e0-49a1-a832-bcc209450ea9",
    "attributes": {
      "name": "DPD Next Day for medium packages",
      "order": 3,
      "active": true,
      "trigger": {
        "resource_type": "shipments",
        "resource_action": "create",
        "predicates": [
          {
            "operator": "==",
            "pointer": "/attributes/physical_properties/weight",
            "value": 1000
          }
        ]
      },
      "action": {
        "action_type": "update-resource",
        "values": [
          {
            "pointer": "/relationships/service/data/id",
            "value": "8321796d-5205-4e13-963f-61bf7db34390"
          }
        ]
      }
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "organizations",
          "id": "9cdf86e8-333f-4ed9-bb31-4935c780c947"
        }
      }
    },
    "links": {
      "self": "https://sandbox-api.myparcel.com/hooks/5c868557-0827-4d21-a7f4-9820f01769f4"
    }
  }
}
```

{{% /expand %}}

{{%expand "PATCH /hooks/{hook_id}" %}}

Update a hook.

**Scope**

Any of the following scopes:

- `organizations.manage`

**Request**

*In this request the priority of this hook is adjusted.*

```http
POST /hooks/{hook_id} HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/hooks/be7f6752-34e0-49a1-a832-bcc209450ea9
```

```json
{
  "data": {
    "type": "hooks",
    "id": "be7f6752-34e0-49a1-a832-bcc209450ea9",
    "attributes": {
      "order": 1
    }
  }
}
```

**Example response**

```json
{
  "data": {
    "type": "hooks",
    "id": "be7f6752-34e0-49a1-a832-bcc209450ea9",
    "attributes": {
      "name": "DPD Next Day for medium packages",
      "order": 1,
      "active": true,
      "trigger": {
        "resource_type": "shipments",
        "resource_action": "create",
        "predicates": [
          {
            "operator": "==",
            "pointer": "/attributes/physical_properties/weight",
            "value": 1000
          }
        ]
      },
      "action": {
        "action_type": "update-resource",
        "values": [
          {
            "pointer": "/relationships/service/data/id",
            "value": "8321796d-5205-4e13-963f-61bf7db34390"
          }
        ]
      }
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "organizations",
          "id": "9cdf86e8-333f-4ed9-bb31-4935c780c947"
        }
      }
    },
    "links": {
      "self": "https://sandbox-api.myparcel.com/hooks/5c868557-0827-4d21-a7f4-9820f01769f4"
    }
  }
}
```

{{% /expand %}}
