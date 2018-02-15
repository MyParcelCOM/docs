+++
title = "Invitations"
weight = 6
+++

<em class="fa fa-fw fa-file-text-o"></em>[API specification](https://docs.myparcel.com/api-specification#/Invitations)

The invitations are used to invite new users to the MyParcel.com services. When you created an invitation it will be automatically send an email to the provided email address. If this invitation is used by a new user to register that new user will be linked to the account of the invitation creator.

## Retrieve invitations
To get all the invitations you have created in the past call the [GET /invitations](https://docs.myparcel.com/api-specification/#/Invitations/get_invitations) endpoint.

#### Sample request
```http
GET /invitations HTTP/1.1
Content-Type: application/vnd.api+json
```

#### Sample response
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
To create an invitations you can create it with the endpoint [POST /carriers](https://docs.myparcel.com/api-specification#/Carriers/get_carriers).

#### Sample request
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
