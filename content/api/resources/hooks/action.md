+++
title = "Hook action"
description = "Hook action."
weight = 2
+++

A hook action specifies what should happen when a hook is executed.

## Attributes
| Attribute    | Type                           | Description                                                                   | Required |
| ------------ | ------------------------------ | ----------------------------------------------------------------------------- | -------- |
| action_type  | string enum: `update-resource` | The type of action that should be performed when a hook is triggered.         | ✓        |
| values       | array of objects               | An array of objects containing specific data depending on the `action_type`.  | ✓        |

{{% notice info %}}
Different `action_types` require differently formatted objects as `values`.  
{{% /notice %}}

### Update resource
At this time, the only supported `action_type` is `update-resource`. 
This action type is used to update the resource that triggered the hook with the specified `values`. 
The format for a value object for `action_type` `update-resource` is shown in the table below.

| Attribute | Type                                              | Description                                                                                   | Required  |
| --------- | ------------------------------------------------- | --------------------------------------------------------------------------------------------- | --------- |
| pointer   | string                                            | JSON pointer formatted string pointing to the resource property that should be assigned.      | ✓         | 
| value     | string, integer, float, boolean, array or object  | The new value that the resource property, resolved by the `pointer` attribute, should get.    | ✓         |

{{% notice warning %}}
Using a hook to update a resource will not overwrite already set resource properties!
{{% /notice %}}

#### Examples
The example hook action below will set the target resource's description attribute to `Baseball cap`. 
This only works if the resource that triggered this hook, does not already have the description attribute set!
```json
{
  "action_type": "update-resource",
  "values": [
    {
      "pointer": "attributes/description",
      "value": "Baseball cap"
    }
  ]
}
```

It is possible to add multiple value objects to a hook action.  
The following example sets the service relationship of a shipment resource by setting both the type and id of the service relationship using two values:

```json
{
  "action_type": "update-resource",
  "values": [
    {
      "pointer": "relationships/service/data/type",
      "value": "services"
    },
    {
      "pointer": "relationships/service/data/id",
      "value": "69460e06-4dfe-440a-b349-83c45fc5ff10"
    }
  ]
}
```
