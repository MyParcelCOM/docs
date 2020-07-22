+++
title = "Using hooks"
description = "How to use hooks."
weight = 5
+++

Hooks are used to automate processes on the API. They decrease the amount of manual actions a user performs.  
  
An example use case for hooks would be to automatically set a service and contract on a shipment when it is created.
This use case could be interesting for an England based business that ships most of its products to England (and therefore always uses the same service).
A hook could be created to automatically set the desired service and contract when a shipment to England is created, 
thus eliminating a big part of the shipment creation process.

## Building a hook
Creating a [hooks](/api/resources/hooks) resource can be complicated, but can be split up by asking two questions:

- When should the hook be executed ([trigger](#trigger))?
- What should happen when the hook is executed ([action](#action))?

### Trigger
In order for a hook to trigger, specific conditions can be specified. 

A hook for the example used below, would have to trigger when any shipment to England is created.
```json
{
  "resource_type": "shipments",
  "resource_action": "create",
  "predicates": [
    {
      "pointer": "/attributes/recipient_address/country_code",
      "operator": "==",
      "value": "GB"
    },
    {
      "pointer": "/attributes/recipient_address/region_code",
      "operator": "==",
      "value": "ENG"
    }
  ]
}
```

Looking at the hook trigger above, the `resource_type` and `resource_action` attributes indicate that the hook should trigger when a resource of type `shipments` is created.
Furthermore, the predicates specify that this hook should only trigger when when the `country_code` and `region_code` of the shipment's `recipient_address` attribute are `GB` and `ENG` respectively.

{{% notice tip %}}
When creating a hook for shipments, the shipment's `tags` attribute can be used to create really flexible triggers!
```json
{
  "pointer": "/attributes/tags",
  "operator": "contains",
  "value": "my-custom-tag"
}
```
Be sure to use the `contains` [operator](/api/resources/hooks/trigger#predicate) when using tags as evaluated field, since `tags` is an array!
{{% /notice %}}

{{% notice info %}}
For more information about triggers, see the resource page on [hook triggers](/api/resources/hooks/trigger).
{{% /notice %}}

### Action
Looking at the example above, the actions for this hook would be to set a service and contract on the shipments resource when it is created.
First, the uuid of the chosen service needs to be retrieved. In this case, an imaginary uuid will be used to represent the chosen service: `ea7bf0c0-2eb5-4348-b90d-2fabd03c424c`.

Secondly, a contract should be retrieved to set on the shipment that contains prices for the chosen service. 
An imaginary uuid is used again, this time to represent the contract id: `e04134d0-1a43-4b29-a5de-d6c63f8d4f1b`.

{{% notice info %}}
More information on [services](/api/resources/services) and [contracts](/api/resources/contracts) and how to retrieve them can be found on the their resource pages.
{{% /notice %}}

A hook action for the example used above would have to set the service and contract relationships on shipment creation. 

```json
{
  "action_type": "update-resource",
  "values": [
    {
      "pointer": "/relationships/service/data/id",
      "value": "ea7bf0c0-2eb5-4348-b90d-2fabd03c424c"
    },
    {
      "pointer": "/relationships/service/data/type",
      "value": "services"
    },
    {
      "pointer": "/relationships/contract/data/id",
      "value": "e04134d0-1a43-4b29-a5de-d6c63f8d4f1b"
    },
    {
      "pointer": "/relationships/contract/data/type",
      "value": "contracts"
    }
  ]
}
```

The `action_type` property indicates what kind of action the hook would perform when it is triggered.
In this case it should update a shipments resource with the service and contract relationships.
The `values` property can contain multiple values that the hook needs to set.
In this case, the `pointer` properties of each value object resolve to the service and contract's relationships objects.
The `value` properties contain what value should be set on the resource property indicated by the `pointer`. 
In this case the id and type of the service and contract relationships objects are set to their id's and resource types.

{{% notice warning %}}
A hook can only set resource properties that have not already been set. It will not overwrite any values!
{{% /notice %}}

{{% notice info %}}
For more information about hook actions, see the resource page on [hook actions](/api/resources/hooks/action).
{{% /notice %}}

### Hook ownership
In order for a hook to trigger on a shipment creation, the shop creating the shipment should have access to it.
Because hooks follow hierarchy, the hook in this example should be owned by either the shop creating the shipment or its parent organization.
In this case the shop creating the shipment is the owner of the hook. The uuid `1bb3e441-8a70-4be8-b910-1315460859f2` is used as shop id.

{{% notice note %}}
A `shops` type resource has a parent resource of type `organizations`. This means that if a hook is owned by an organization, all shops will automatically use that hook. 
{{% /notice %}}

### Creating the hooks resource
After establishing when a hook should trigger and what it should do, the hook can be created.
A hook is created by calling the POST [/hooks endpoint](/api/resources/hooks/#endpoints), 
which will create a [hooks resource](/api/resources/hooks) in the MyParcel.com API.

```json
{
  "data": {
    "type": "hooks",
    "attributes": {
      "name": "Set service and contract for shipments to England",
      "order": 100,
      "active": true,
      "trigger": {
        "resource_type": "shipments",
        "resource_action": "create",
        "predicates": [
          {
            "pointer": "/attributes/recipient_address/country_code",
            "operator": "==",
            "value": "GB"
          },
          {
            "pointer": "/attributes/recipient_address/region_code",
            "operator": "==",
            "value": "ENG"
          }
        ]
      },
      "action": {
        "action_type": "update-resource",
        "values": [
          {
            "pointer": "/relationships/service/data/id",
            "value": "ea7bf0c0-2eb5-4348-b90d-2fabd03c424c"
          },
          {
            "pointer": "/relationships/service/data/type",
            "value": "services"
          },
          {
            "pointer": "/relationships/contract/data/id",
            "value": "e04134d0-1a43-4b29-a5de-d6c63f8d4f1b"
          },
          {
            "pointer": "/relationships/contract/data/type",
            "value": "contracts"
          }
        ]
      }
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "shops",
          "id": "1bb3e441-8a70-4be8-b910-1315460859f2"
        }
      }
    }
  }
}
```

The code block above shows what the request body for a hook that sets a service and contract on any shipment that has England as destination.

## Chaining hooks and ordering
Multiple hooks can be triggered by the same resource action. 
Using the example from before, it would be possible to use two hooks: 

{{% expand "A hook for setting the service relationship if the destination is England" %}}
This hooks resource will only set the service of a shipment to England, but not the contract.
```json
{
  "data": {
    "type": "hooks",
    "attributes": {
      "name": "Set service for shipments to England",
      "order": 100,
      "active": true,
      "trigger": {
        "resource_type": "shipments",
        "resource_action": "create",
        "predicates": [
          {
            "pointer": "/attributes/recipient_address/country_code",
            "operator": "==",
            "value": "GB"
          },
          {
            "pointer": "/attributes/recipient_address/region_code",
            "operator": "==",
            "value": "ENG"
          }
        ]
      },
      "action": {
        "action_type": "update-resource",
        "values": [
          {
            "pointer": "/relationships/service/data/id",
            "value": "ea7bf0c0-2eb5-4348-b90d-2fabd03c424c"
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
          "type": "shops",
          "id": "1bb3e441-8a70-4be8-b910-1315460859f2"
        }
      }
    }
  }
}
```
{{% /expand %}}
 
{{% expand "A hook to set the desired contract when a shipment is created with the mentioned service" %}}
This hook will trigger when a shipment is created with service id `ea7bf0c0-2eb5-4348-b90d-2fabd03c424c` and set the contract relationship accordingly. 
This contract will now be set for **all** shipments that are created with service id `ea7bf0c0-2eb5-4348-b90d-2fabd03c424c`, but have no contract.
```json
{
  "data": {
    "type": "hooks",
    "attributes": {
      "name": "Set contract for shipments with England service",
      "order": 200,
      "active": true,
      "trigger": {
        "resource_type": "shipments",
        "resource_action": "create",
        "predicates": [
          {
            "pointer": "/relationships/service/data/id",
            "operator": "==",
            "value": "ea7bf0c0-2eb5-4348-b90d-2fabd03c424c"
          }
        ]
      },
      "action": {
        "action_type": "update-resource",
        "values": [
          {
            "pointer": "/relationships/contract/data/id",
            "value": "e04134d0-1a43-4b29-a5de-d6c63f8d4f1b"
          },
          {
            "pointer": "/relationships/contract/data/type",
            "value": "contracts"
          }
        ]
      }
    },
    "relationships": {
      "owner": {
        "data": {
          "type": "shops",
          "id": "1bb3e441-8a70-4be8-b910-1315460859f2"
        }
      }
    }
  }
}
```
{{% /expand %}}

In order for the second hook (to set the contract relationship) to trigger, the first hook needs to be executed first. 
The `order` attribute of the hooks resource determines the priority of a hook when multiple hooks apply. 
A lower `order` means that it has higher priority.
In this case, because the order of the first hook is lower (`100`) than the order of the second hook (`200`), the first hook is executed first. 

{{% notice tip %}}
Using multiplications of 100 for the `order` attribute makes it easier to "insert" new hooks before existing ones without having to update all of the existing hook's `order` attributes. 
{{% /notice %}}
