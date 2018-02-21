+++
title = "Password Resets"
description = "Functionality to create or reset the password of a user."
weight = 7
+++

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/PasswordResets)

The password reset resource is available in order to change the password for a MyParcel.com user. A password reset can be initiated by providing the email address of a user. If this email is recognized an email with a password reset link will be sent to that email address. The user should visit this link to choose a new password. These reset links are one time use and will only be valid for one day. If a new link to the same email address their old links will no longer work.

## Requesting email with password reset link
You can call the [POST /password-resets](https://docs.myparcel.com/api-specification#/PasswordResets/post_password_resets) endpoint with a email address to send someone the email with the reset link.

#### Sample request
```http
POST /password-resets HTTP/1.1
Content-Type: application/vnd.api+json

{
  "data": {
    "type": "password-resets",
    "attributes": {
      "email": "john@doe.com"
    }
  }
}
```
