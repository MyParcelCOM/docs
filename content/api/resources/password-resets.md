+++
title = "Password Resets"
description = "Functionality to create or reset the password of a user."
weight = 7
+++

The password reset resource is available in order to change the password for a MyParcel.com user. A password reset can be initiated by providing the email address of a user. If this email is recognized, an email with a password reset link will be sent to that email address. The user should visit this link to choose a new password. These reset links are one time use and will only be valid for one day. If a new link is sent to the same email address, their old links will no longer work.

## Password Reset

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/PasswordResets)

Attribute | Description
--------- | -----------
email     | A valid email address, used to send an email with the reset link.
password  | New password for the user.

### Create

{{< icon fa-file-text-o >}}[POST /password-resets](https://docs.myparcel.com/api-specification#/PasswordResets/post_password_resets)

This endpoint creates a new password reset with the posted data. A password reset link will be sent via email. Any previous password resets for this user will be disabled.

### Update

{{< icon fa-file-text-o >}}[PATCH /password-resets/{password_reset_id}](https://docs.myparcel.com/api-specification#/PasswordResets/post_password_resets)

With the `password_reset_id` from the password reset link you are able to update this resource. In the `PATCH` request, you only have to specify the new `password` attribute. If the request is accepted, the user is able to use the new password.

### Delete

Password resets cannot be deleted. They automatically expire after 24 hours or if a new one is created.
