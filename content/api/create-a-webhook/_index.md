+++
title = "Create a webhook"
description = "The resources to use when creating a webhook."
weight = 3
+++

To create a webhook in our API you can use the [hook](/api/resources/hooks) resource.

With this [hook](/api/resources/hooks) resource you can describe an action on which a hook needs to trigger. 
For more information about the possibilities with these triggers read the [hook trigger](/api/resources/hooks/triggers) page
or go the the [using hooks](/api/using-hooks) page to get a guide on how to use the hooks in general.

Furthermore, when you create a hook and choose the [send-resource](/api/resources/hooks/action/#send-resource) action type you can choose a `url` where the data of the effected resource will be sent to. 

#### Examples
This example below will send the resource data of the newly created shipment with a POST request to your provided `url`. 
```json
{
  "data": {
    "type": "hooks",
    "attributes": {
      "name": "Send the shipment to my url when it is created",
      "order": 100,
      "active": true,
      "trigger": {
        "resource_type": "shipments",
        "resource_action": "create",
      },
      "action": {
        "action_type": "send-resource",
        "values": [
          {            
            "url": "https://your.api.url"
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
{{% notice info %}}
For more information about the hook actions, see the resource page on [send-resource action](/api/resources/hooks/action/#send-resource).
and for more information about the hook trigger, see the resource page on [hooks trigger](/api/resources/hooks/trigger).
{{% /notice %}}
