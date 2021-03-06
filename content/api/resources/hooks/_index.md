+++
title = "Hooks"
description = "Hooks are there to automate processes on the API."
weight = 10
+++

Hooks are used to automate processes in the API.  
A hook listens to certain [triggers](/api/resources/hooks/trigger) and executes its associated [action](/api/resources/hooks/action).  

## Attributes

{{< icon fa-file-text-o >}}[API specification](https://api-specification.myparcel.com/#tag/Hooks)

| Attribute     | Type                                                                  | Description                                                                                                               | Required  |
|---------------|-----------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------|-----------|
| name          | string                                                                | A name for users to recognize the hook by.                                                                                | ✓         |
| order         | integer                                                               | Position of the hook in the queue of hooks when multiple hooks apply (lower order indicates it will be executed earlier). | ✓         |
| active        | boolean                                                               | Whether or not the hook should executed.                                                                                  | ✓         |
| trigger       | [hook trigger](/api/resources/hooks/trigger)                          | Specification of what resource (and action) the hook listens to and additional optional predicates.                       | ✓         |
| action        | [hook action](/api/resources/hooks/action)                            | Specification of what should be performed when the hook gets executed.                                                    | ✓         |

| Relationship  | Type                                                                                      | Description                                                                                                               | Required   |
|---------------|-------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------|------------|
| owner         | [organizations](/api/resources/organizations) <br> OR <br> [shops](/api/resources/shops)  | The owner (generally the creator) of the hook. The owner influences when a hook is triggered and its priority.    | ✓          |

### Hook ordering
Multiple hooks can be triggered by the same resource action. This means that the hooks will take turns executing.
The order of the hooks is determined by two things: the owner of the hook and the `order` attribute of the hook.

{{% notice warning %}}
A hook will not overwrite any values. If multiple hooks set the same resource property using the [update-resource action](/api/resources/hooks/action/#update-resource), 
the first hook to execute will set the value. All subsequent hooks will not overwrite the same property.
{{% /notice %}}

#### The owner of the hook
Hooks follow hierarchy in the API. This means that if the owner of a hook is of type `organizations`, 
all (child) shops that relate to that organization will automatically have the hook applied as well.
As mentioned before, the order in which the hooks are executed is influenced by the owner of the hook, 
prioritizing lower ranked owners first.
This means that first all hooks created by a shop will be executed and then all hooks created by the shop's parent organization will execute.

#### The order attribute
The order in which hooks with the **same** owner are executed is influenced by the `order` attribute of the hook. 
Hooks with a lower `order` are executed earlier. 

{{% notice tip %}}
To avoid having to adjust the order of all other hooks when creating a new hook that should be executed before existing ones, the value of the `order` attribute should be multiplications of 100.
This makes it easier to "insert" a new hook between/before existing ones.
{{% /notice %}}

{{% notice warning %}}
If two hooks have the same `owner` and the same value for `order`, they will be executed in effectively random order!
{{% /notice %}}

The diagram below shows the order in which hooks are executed in a more visual manner.
{{< figure src="/images/hooks-order.png" title="The order in which hooks are executed" alt="Hooks ordering" >}}

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
        "order": 300,
        "active": true,
        "trigger": {
          "resource_type": "shipments",
          "resource_action": "create",
          "predicates": [
            {
              "pointer": "/attributes/physical_properties/weight",
              "operator": "==",
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
            },
            {
              "pointer": "/relationships/service/data/type",
              "value": "services"
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
      "order": 300,
      "active": true,
      "trigger": {
        "resource_type": "shipments",
        "resource_action": "create",
        "predicates": [
          {
            "pointer": "/attributes/physical_properties/weight",
            "operator": "==",
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
          },
          {
            "pointer": "/relationships/service/data/type",
            "value": "services"
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
      "order": 300,
      "active": true,
      "trigger": {
        "resource_type": "shipments",
        "resource_action": "create",
        "predicates": [
          {
            "pointer": "/attributes/physical_properties/weight",
            "operator": "==",
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
          },
          {
            "pointer": "/relationships/service/data/type",
            "value": "services"
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
      "order": 300,
      "active": true,
      "trigger": {
        "resource_type": "shipments",
        "resource_action": "create",
        "predicates": [
          {
            "pointer": "/attributes/physical_properties/weight",
            "operator": "==",
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
          },
          {
            "pointer": "/relationships/service/data/type",
            "value": "services"
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
      "order": 100
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
      "order": 100,
      "active": true,
      "trigger": {
        "resource_type": "shipments",
        "resource_action": "create",
        "predicates": [
          {
            "pointer": "/attributes/physical_properties/weight",
            "operator": "==",
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
          },
          {
            "pointer": "/relationships/service/data/type",
            "value": "services"
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
