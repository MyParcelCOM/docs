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
At this time, only hooks that are triggered by the `shipments` `resource_type` are supported.
{{% /notice %}}
