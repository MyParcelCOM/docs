+++
title = "Hook action"
description = "Hook action."
weight = 2
+++

A hook action specifies what should happen when a hook is triggered.

## Attributes
| Attribute    | Type                              | Description                                                           | Required  |
| ------------ | --------------------------------- | --------------------------------------------------------------------- | --------- |
| action_type  | string enum: `update-resource`    | The type of action that should be performed when a hook is triggered. | ✓         |
| values       | array of [value](#value) objects  |  |           |

{{% notice info %}}
At this time, only hooks that are triggered by the **shipments** resource_type will actually be executed!
{{% /notice %}}

### Predicate
A predicate is a statement that contains variables and resolves to be either true or false depending on the values of these variables.  
To resolve a predicate, an operator, a pointer and a value are required.

| Attribute | Type                                                              | Description                                                                                                                               | Required  |
| --------- | ----------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| operator  | string enum: `==` <br> `!=` <br> `>` <br> `<` <br> `>=` <br> `<=` | Mathematical operator used to compare two values.                                                                                         | ✓         |
| pointer   | string                                                            | JSON pointer formatted string pointing to the resource property that should be compared with the `value` attribute using the `operator`.  | ✓         |
| value     | string, float or integer                                          | The value to compare the resource property indicated by the `pointer` attribute to.                                                       | ✓         |

## Examples
The trigger listed below, will cause a hook to activate whenever any shipment is updated.

```json
{
  "resource_type": "shipments",
  "resource_action": "updated"
}
``` 

The following trigger contains predicates and will cause its associated hook to trigger only when a shipment is created with a weight below 5 kg.

```json
{
  "resource_type": "shipments",
  "resource_action": "created",
  "predicates": [
    {
      "operator": "<",
      "pointer": "attributes/physical_properties/weight",
      "value": 5000
    }
  ]
}
```

A trigger can has many predicates as the user might find necessary.  
The below trigger will cause a hook to trigger when a shipment is created that weighs less than 5 kg and is sent to anywhere in Spain but Madrid.

```json
{
  "resource_type": "shipments",
  "resource_action": "created",
  "predicates": [
    {
      "operator": "<",
      "pointer": "attributes/physical_properties/weight",
      "value": 5000
    },
    {
      "operator": "==",
      "pointer": "attributes/recipient_address/country_code",
      "value": "ES"
    },
    {
      "operator": "!=",
      "pointer": "attributes/recipient_address/city",
      "value": "Madrid"
    }
  ]
}
```
