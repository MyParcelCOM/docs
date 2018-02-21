+++
title = "Invitations"
description = "Invitations you have sent to friends and the users you have connected this way."
weight = 6
+++

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/Invitations)

The invitations are used to invite new users to the MyParcel.com platform. When you create an invitation it will automatically send an email to the provided email address. If the link in this email is used to complete a registration, the new user will be linked to your user.

## Retrieve invitations
To get all the invitations you have created call the [GET /invitations](https://docs.myparcel.com/api-specification/#/Invitations/get_invitations) endpoint.

### Sample request
```http
GET /invitations HTTP/1.1
Content-Type: application/vnd.api+json
```

### Sample response
```http
HTTP/1.1 200 OK
Content-Type: application/vnd.api+json

{
  "data": [
      {
        "type": "invitations",
        "id": "c9ce29a4-6325-11e7-907b-a6006ad3dba0",
        "attributes": {
          "code": "15317471056093",
          "email": "john@doe.com",
          "name": "James Johnson",
          "message": "Hi James, this is your invitation to join myparcel.com",
          "status": "pending"
        },
        "links": {
          "self": "https://sandbox.myparcel.com/v1/invitations/c9ce29a4-6325-11e7-907b-a6006ad3dba0"
        }
      }
    ]
  ]
}
```

## Create invitations
You can create an invitation with the endpoint [POST /invitations](https://docs.myparcel.com/api-specification#/Invitations/post_invitations).

### Sample request
```http
POST /invitations HTTP/1.1
Content-Type: application/vnd.api+json

{
  "data": {
      "type": "invitations",
      "attributes": {
        "email": "john@doe.com",
        "name": "James Johnson",
        "message": "Hi James, this is your invitation to join myparcel.com"
      }
    }
}
```
