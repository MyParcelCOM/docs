+++
title = "Hook logs"
description = "Hook logs."
weight = 3
+++

A hook log specifies what happened when the hook was executed.

## Attributes
| Attribute       | Type              | Description                                                                                   | Required |
| --------------- | ----------------- | ----------------------------------------------------------------------------------------------| -------- |
| resource_diff   | object            | An object of the changes done on this resource.                                               |          |
| errors          | array of strings  | An array of strings containing the error that was encountered while trying to run this hook.  |          |

{{% notice warning %}}
This resource is still experimental so it requires the `experimental` scope and might still change in the future.
{{% /notice %}}

## Retrieve hook logs

**Request**
```http
GET /hook-logs HTTP/1.1
Accept: application/vnd.api+json
Example: https://sandbox-api.myparcel.com/hook-logs/8e141db6-d638-9ae0-e33d-8e97469b10ce
```

**Successful hooks response example**
```json
{
  "data": [
    {
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
        }
      },
      "links": {
        "self": "https://sandbox-api.myparcel.com/hook-logs/8e141db6-d638-9ae0-e33d-8e97469b10ce"
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
      }
    }
  ],
  "meta": {
    "total_pages": 13,
    "total_records": 373
  },
  "links": {
    "self": "https://sandbox-api.myparcel.com/hook-logs?page[number]=3&page[size]=30",
    "first": "https://sandbox-api.myparcel.com/hook-logs?page[number]=1&page[size]=30",
    "prev": "https://sandbox-api.myparcel.com/hook-logs?page[number]=2&page[size]=30",
    "next": "https://sandbox-api.myparcel.com/hook-logs?page[number]=4&page[size]=30",
    "last": "https://sandbox-api.myparcel.com/hook-logs?page[number]=13&page[size]=30"
  }
}
```

**Failed hooks response example**
```json
{
  "data": [
    {
      "type": "hook-logs",
      "id": "8e141db6-d638-9ae0-e33d-8e97469b10ce",
      "attributes": {
        "errors": [
           "Applying the hook failed because the desired service was not available for the shipment contract."
         ]
      },
      "links": {
        "self": "https://sandbox-api.myparcel.com/hook-logs/8e141db6-d638-9ae0-e33d-8e97469b10ce"
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
      }
    }
  ],
  "meta": {
    "total_pages": 13,
    "total_records": 373
  },
  "links": {
    "self": "https://sandbox-api.myparcel.com/hook-logs?page[number]=3&page[size]=30",
    "first": "https://sandbox-api.myparcel.com/hook-logs?page[number]=1&page[size]=30",
    "prev": "https://sandbox-api.myparcel.com/hook-logs?page[number]=2&page[size]=30",
    "next": "https://sandbox-api.myparcel.com/hook-logs?page[number]=4&page[size]=30",
    "last": "https://sandbox-api.myparcel.com/hook-logs?page[number]=13&page[size]=30"
  }
}
```
