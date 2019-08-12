+++
title = "Hook trigger"
description = "Hook trigger"
weight = 4
+++

A hook trigger contains the criteria for when a hook should trigger.  
It determines what resource and action should trigger the hook.

## Attributes
| Attribute         | Type                                                      | Description                                                           | Required  |
| ----------------- | --------------------------------------------------------- | --------------------------------------------------------------------- | --------- |
| resource_type     | string                                                    | The type of resource that causes the hook to trigger.                 | ✓         |
| resource_action   | string enum: <br> `create` <br> `update` <br> `delete`    | The resource action that should trigger the hook.                     | ✓         |
| predicates        | array of [predicate](#predicate) objects                 | Used to more specifically trigger hooks based on the target resource. |           |

{{% notice info %}}
At this time, only hooks that are triggered by the `shipments` and `shipment-statuses` `resource_type` are supported.
{{% /notice %}}

### Predicate
A predicate is a statement that contains variables and resolves to be either `true` or `false` depending on the values of these variables.
To resolve a predicate, an `operator`, a `pointer` and a `value` are required.
If all predicates resolve to `true` the [hook action](/api/resources/hooks/action) will be executed.

| Attribute | Type                                                              | Description                                                                                                                                                                       | Required  |
| --------- | ----------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| pointer   | string                                                            | [JSON pointer](https://tools.ietf.org/html/rfc6901) formatted string pointing to the resource property that should be compared with the `value` attribute using the `operator`.   | ✓         |
| operator  | string enum: `==` <br> `!=` <br> `>` <br> `<` <br> `>=` <br> `<=` | Comparison operator used to compare two values.                                                                                                                                   | ✓         |
| value     | string, float or integer                                          | The value to compare the resource property indicated by the `pointer` attribute to.                                                                                               | ✓         |

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

A trigger can have as many predicates as the user might find necessary.  
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
