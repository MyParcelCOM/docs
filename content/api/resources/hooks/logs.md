+++
title = "Hook logs"
description = "Hook logs."
weight = 3
+++

A hook log specifies what happened when the hook was executed.

## Attributes

| Attribute     | Type             | Description                                                                            | Required |
| ------------- | ---------------- | -------------------------------------------------------------------------------------- | -------- |
| resource_diff | object           | An object of the changes done on this resource.                                        |          |
| errors        | array of strings | An array of strings containing the error(s) encountered while trying to run this hook. |          |
| created_at    | integer          | Unix timestamp for when the log was created.                                           |          |

## Retrieve all logs for a specific hook

{{< icon fa-file-text-o >}}[API specification](https://api-specification.myparcel.com/#tag/Hooks/paths/~1hooks~1{hook_id}~1logs/get)

**Request parameters**  
For more specific requests, the following parameters can be included as query parameters.

Parameter                     | Type    | Description
----------------------------- | ------- | ------------
filter[created_at][date_from] | string  | Date in ISO 8601 date format (YYYY-MM-DD). Only resources created >= this date will be returned.
filter[created_at][date_to]   | string  | Date in ISO 8601 date format (YYYY-MM-DD). Only resources created <= this date will be returned.
filter[has_errors]            | boolean | `true` will only return logs **with** errors<br>`false` will only return logs **without** errors.<br>Omit this filter if you want to retrieve all logs, regardless of errors.

**Request**
```http
GET /hooks/{hook_id}/logs HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/hooks/be7f6752-34e0-49a1-a832-bcc209450ea9/logs?filter[created_at][date_from]=2021-01-21
```

## Retrieve a hook log

{{< icon fa-file-text-o >}}[API specification](https://api-specification.myparcel.com/#tag/HookLogs)

**Request**
```http
GET /hook-logs/{hook_log_id} HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/hook-logs/8e141db6-d638-9ae0-e33d-8e97469b10ce
```

**Successful hook log response example**
```json
{
  "data": {
    "type": "hook-logs",
    "id": "8e141db6-d638-9ae0-e33d-8e97469b10ce",
    "attributes": {
      "resource_diff": {
        "relationships": {
          "service": {
            "data": {
              "type": "services",
              "id": "7b808eee-bf1c-40cd-98f2-3c335a06417e"
            }
          }
        }
      },
      "created_at": 1504801719
    },
    "relationships": {
      "hook": {
        "data": {
          "id": "be7f6752-34e0-49a1-a832-bcc209450ea9",
          "type": "hooks"
        },
        "links": {
          "related": "https://localhost:9443/hooks/be7f6752-34e0-49a1-a832-bcc209450ea9"
        }
      },
      "resource": {
        "data": {
          "type": "shipments",
          "id": "7b808eee-bf1c-40cd-98f2-3c335a06417e"
        }
      }
    },
    "links": {
      "self": "https://sandbox-api.myparcel.com/hook-logs/8e141db6-d638-9ae0-e33d-8e97469b10ce"
    }
  }
}
```

**Failed hook log response example**
```json
{
  "data": {
    "type": "hook-logs",
    "id": "8e141db6-d638-9ae0-e33d-8e97469b10ce",
    "attributes": {
      "errors": [
        "Applying the hook failed because the desired service was not available for the shipment contract."
      ],
      "created_at": 1504801719
    },
    "relationships": {
      "hook": {
        "data": {
          "id": "be7f6752-34e0-49a1-a832-bcc209450ea9",
          "type": "hooks"
        },
        "links": {
          "related": "https://localhost:9443/hooks/be7f6752-34e0-49a1-a832-bcc209450ea9"
        }
      },
      "resource": {
        "data": {
          "type": "shipments",
          "id": "7b808eee-bf1c-40cd-98f2-3c335a06417e"
        }
      }
    },
    "links": {
      "self": "https://sandbox-api.myparcel.com/hook-logs/8e141db6-d638-9ae0-e33d-8e97469b10ce"
    }
  }
}
```
