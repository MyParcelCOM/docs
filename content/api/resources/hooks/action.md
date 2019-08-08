+++
title = "Hook action"
description = "Hook action."
weight = 2
+++

A hook action specifies what should happen when a hook is executed.

## Attributes
| Attribute    | Type                           | Description                                                                   | Required |
| ------------ | ------------------------------ | ----------------------------------------------------------------------------- | -------- |
| action_type  | string enum: `update-resource`, `send-resource` | The type of action that should be performed when a hook is triggered.         | ✓        |
| values       | array of objects               | An array of objects containing specific data depending on the `action_type`.  | ✓        |

{{% notice info %}}
Different `action_types` might require differently formatted objects as `values` in the future when more `action_types` are supported.  
{{% /notice %}}

### Update resource
If you need to update the resource when an `hook_action` is preformed use the `update-resource` as an `action_type`. 
It will update the resource that triggered the hook with the specified `values`. 
The format for a value object for `action_type` `update-resource` is shown in the table below.

| Attribute | Type                                              | Description                                                                                                                       | Required  |
| --------- | ------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- | --------- |
| pointer   | string                                            | [JSON pointer](https://tools.ietf.org/html/rfc6901) formatted string pointing to the resource property that should be assigned.   | ✓         | 
| value     | string, integer, float, boolean, array or object  | The new value that the resource property, resolved by the `pointer` attribute, should get.                                        | ✓         |

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

### Send resource
If you need the resource to be send to a `url` with a POST request of your url when an `hook_action` is preformed use the `update-resource` as an `action_type`. 
It will send the resource that triggered the hook to the specified `url` with a POST request. 
The format for a value object for `action_type` `send-resource` is shown in the table below.

| Attribute | Type                                              | Description                                                                                                                       | Required  |
| --------- | ------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- | --------- |
| url       | string                                            | The url where the resource POST request is send to.                                                                      | ✓         | 
| secret    | string                                            | A secret string that will be send in the `X-MYPARCELCOM-SIGNATURE` header with every POST request .                                        |           |
| includes  | array                                             | An array of include keys that will be added to the resource body.                                                |           |

#### Examples
The example hook action below will send the data of the target resource with a POST request to your provided `url`. 
```json
{
  "action_type": "send-resource",
  "values": [
    {
      "url": "https://your.api.url"
    }
  ]
}
```

It is possible to add multiple value objects to a hook action.  
The following example will send the data of the target resource to both provided urls.
```json
{
  "action_type": "send-resource",
  "values": [
    {
      "url": "https://your.api.url1"
    },
    {
      "url": "https://your.api.url2"
    }
  ]
}
```

It is possible to add multiple includes to the action by adding includes.
These revere to the relationships of the affected resource.
It will add the data of these relationships resource to the body of the POST request.
```json
{
  "action_type": "send-resource",
  "values": [
    {
      "url": "https://your.api.url",
      "includes": ["service","contract"]
    }
  ]
}
```

It is also possible to add a secret to the hook action.
This will than be sent with every POST request to your `url` in a `X-MYPARCELCOM-SIGNATURE` header.
This way you can validate that this request comes from a trusted sender. 
```json
{
  "action_type": "send-resource",
  "values": [
    {
      "url": "https://your.api.url",
      "secret": "your.super.secret.string"
    }
  ]
}
```