+++
title = "Using hooks"
description = "How to use hooks."
weight = 5
+++

Hooks are used to automate processes on the API. They decrease the amount of manual actions a user performs.  
  
An example use case for hooks would be to automatically set a service and contract on a shipment when it is created.
This use case could be interesting for an England based business that ships most of its products to England (and therefore always using the same service).
A hook could be created to automatically set the desired service and contract on all shipments to England, 
which eliminates a big part of the shipment creation process.

## Creating a hook
A hook is created by calling the POST [/hooks endpoint](/api/resources/hooks/#endpoints), 
which will create a [hook resource](/api/resources/hooks) in the MyParcel.com API.
Creating a hook resource can be complicated, but can be split up by asking two questions:

- When should the hook take effect ([triggers](#triggers))?
- What should happen when the hook is triggered ([actions](#actions))?

### Triggers
In order for a hook to trigger, specific conditions can be specified. 
Using the example above, the hook would have to trigger on all shipments that have England as destination. 

The hook trigger for any shipment to England would look like this:
```json
{
  "resource_type": "shipments",
  "resource_action": "create",
  "predicates": [
    {
      "operator": "==",
      "pointer": "/attributes/recipient_address/country_code",
      "value": "GB"
    },
    {
      "operator": "==",
      "pointer": "/attributes/recipient_address/region_code",
      "value": "ENG"
    }
  ]
}
```

{{% notice info %}}
For more information about triggers, see the resource page on [hook triggers](/api/resources/hooks/trigger).
{{% /notice %}}

### Actions
Looking at the example above, the actions for this hook would be to set a service and contract on the shipment resource when it is created.
First, the uuid of the chosen service needs to be retrieved. In this case, an imaginary uuid will be used to represent the chosen service: `ea7bf0c0-2eb5-4348-b90d-2fabd03c424c`.

Secondly, a contract should be retrieved to set on the shipment that contains prices for the chosen service. 
For this example an imaginary uuid is again used to represent the contract id: `e04134d0-1a43-4b29-a5de-d6c63f8d4f1b`.

{{% notice info %}}
More information on [services](/api/resources/services) and [contracts](/api/resources/contracts) and how to retrieve them can be found on the their resource pages.
{{% /notice %}}

The hook action for the above example would look like this: 

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

{{% notice info %}} 
For more information about hook actions, see the resource page on [hook actions](/api/resources/hooks/action).
{{% /notice %}}

### Hook ownership
In order for a hook to trigger on a shipment creation, the owner (shop or organization) of the created hook should also be the owner (shop) of the shipment.
Therefore, a shop id should also be retrieved to assign as owner of the hook. `1bb3e441-8a70-4be8-b910-1315460859f2` is used as the shop id that is the owner of the hook.

## Chaining hooks and ordering
// Something something.


{{% expand "Domestic service to England" %}}
While the below hook is active, all shipments to England, that are saved to the MyParcel.com API, for the shop with id `1bb3e441-8a70-4be8-b910-1315460859f2`, 
will default to the chosen service ("Domestic") if no service is set in the POST /shipments request. 

```json
{
  "data": {
    "type": "hooks",
    "attributes": {
      "name": "Domestic service for shipments to England",
      "order": 100,
      "active": true,
      "trigger": {
        "resource_type": "shipments",
        "resource_action": "create",
        "predicates": [
          {
            "operator": "==",
            "pointer": "/attributes/recipient_address/country_code",
            "value": "GB"
          },
          {
            "operator": "==",
            "pointer": "/attributes/recipient_address/region_code",
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
{{% /expand %}}


