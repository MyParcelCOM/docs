+++
title = "Hook action"
description = "Hook action."
weight = 1
+++

A hook action specifies what should happen when a hook is executed.

## Attributes
| Attribute    | Type                                            | Description                                                                   | Required |
| ------------ | ----------------------------------------------- | ----------------------------------------------------------------------------- | -------- |
| action_type  | string enum: `update-resource`, `send-resource` | The type of action that should be performed when a hook is triggered.         | ✓        |
| values       | array of objects                                | An array of objects containing specific data depending on the `action_type`.  | ✓        |

{{% notice info %}}
Different `action_types` might require differently formatted objects as `values` in the future when more `action_types` are supported.  
{{% /notice %}}

## Update resource
When performing a `hook_action` the `update-resource` `action_type` can be used to update the resource.
This will update the resource that triggered the hook with the specified `values`.
The format for a value object for `action_type` `update-resource` is shown in the table below.

| Attribute | Type                                              | Description                                                                                                                                           | Required  |
| --------- | ------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- | --------- |
| pointer   | string                                            | [JSON pointer](https://tools.ietf.org/html/rfc6901) formatted string pointing to the resource property that should be assigned.                       | ✓         | 
| value     | string, integer, float, boolean, array or object  | The new value that the resource property, resolved by the `pointer` attribute, should get.                                                            | ✓         |
| converter | string enum: `service-code-to-id`                 | One of the available [converters](#converters) to convert the `value` property into another value, based on context. |           |

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

### Converters
In some scenarios, it might be desirable to not set a specific value, but rather a value that will convert into a specific value, based on resource context.
To clarify, let's use the example of the currently only available value converter: the `service-code-to-id` converter.

The `service-code-to-id` converter is only available when attempting to set a [service](/api/resources/services) on a [shipment](/api/resources/shipments), using the `update-resource` hook action.
By using a service code as the value for the relationship's `id` property and specifying that the `service-code-to-id` converter should be used,
the API will attempt to convert the specified service code to a `UUID` that belongs to a service that matches the shipment. 

This is useful when the same service is desired for shipments that go to different destinations. 
In the MyParcel.com API, multiple services can have the same `name` and `code`, but still have different `UUID`'s
because some service specific information, like `transit_time`, will differ per destination/origin of the service.
The converter property makes it possible to create one hook resource, that can set a service, 
based on its code, rather than its UUID on shipments to multiple destinations.

#### Example
The example shown in the below code block shows a hook action that utilizes a converter. 

```json
{
  "action_type": "update-resource",
  "values": [
    {
      "pointer": "/relationships/service/data/id",
      "value": "dpd-classic",
      "converter": "service-code-to-id"
    },
    {
      "pointer": "relationships/service/data/type",
      "value": "services"
    }
  ]
}
```

When this hook is active while a shipment is created that complies to the hook's [triggers](/api/resources/hooks/trigger) and does not already have a service,
the API will try to find a `DPD Classic` service that matches the shipment's origin and destination and is available for the used contract. 
If a matching service is found, the service's UUID is set on the `/relationships/service/data/id` pointer. 
If no service is found, nothing will happen, and a [hook_log](/api/resources/hooks/logs) resource, with additional information will be available.

## Send resource
When a `hook_action` is performed the `send-resource` `action_type` is used to send the resource to a specific `url`. 
This `action_type` will send the resource that triggered the hook to the specified `url` through a POST request.
The format for a value object for `action_type` `send-resource` is shown in the table below.

| Attribute | Type                                              | Description                                                                                                                       | Required  |
| --------- | ------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- | --------- |
| url       | string                                            | The url where the resource POST request is send to.                                                                               | ✓         | 
| secret    | string                                            | A secret string used to HMAC SHA-256 sign every POST request via the `X-MYPARCELCOM-SIGNATURE` header. More information below.    |           |
| includes  | array                                             | An array of include keys that will be added to the resource body.                                                                 |           |

### Verifying requests
Use the `secret` attribute to set a key which is used to sign every POST request. The generated signature is an HMAC SHA-256 authentication code which is unique for each request.
The message used to generate the HMAC code is the raw JSON request body. 

#### HMAC SHA-256 verification (PHP)
With PHP you can verify the validity of the request using the `hmac_hash` function:
```php
// where $body is the request json encoded raw body (as string) and APP_KEY is the secret key
$isTrusted = hash_hmac('sha256', $body, APP_KEY) === $_SERVER['HTTP_MYPARCELCOM_SIGNATURE'];
```

#### HMAC SHA-256 verification (JavaScript)
With JavaScript you can use the [crypto-js](http://code.google.com/p/crypto-js/) library:
```javascript
// where body is the request json encoded raw body (as string) and appKey is the secret key
const isTrusted = CryptoJS.HmacSHA256(body, appKey) === request.headers.get('X-MYPARCELCOM-SIGNATURE');
```

### Examples
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

Additionally, it is possible to add multiple includes to the action by adding includes.
These refer to the relationships of the affected resource.
The following example will add the data of `service` and `contract` relationship resources to the body of the POST request.
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
 
Furthermore, it is also possible to add a secret to the hook action in order to perform validation that the requests come from a trusted sender.
The `secret` string will be used to sign every POST request from MyParcel.com's side and pass the signature in the `X-MYPARCELCOM-SIGNATURE` header. 
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
