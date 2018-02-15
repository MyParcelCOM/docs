+++
title = "Password Resets"
weight = 7
+++

<em class="fa fa-fw fa-file-text-o"></em>[API specification](https://docs.myparcel.com/api-specification#/PasswordResets)

The password resets resource is available in order to change the password for an MyParcel.com `user`. You do this by providing the email address of the user you want to be able to change there password. If that email is available as an user with MyParcel.com an email with the reset link will be send to that email address. With this link the `user` can choose a new password.
These reset links in the email are one time use and will only be valid for one day. If you sent a new link to the same email address that already had a link the old link will no longer work.

## Requesting email with password reset link
You can call the [POST /password-resets](https://docs.myparcel.com/api-specification#/PasswordResets/post_password_resets) endpoint with a email address to send someone the emil with the reset link.

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
