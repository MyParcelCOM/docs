+++
title = "Users"
description = "Registering a user is required to communicate with our API."
weight = 19
+++

Users are able to access the system and execute actions on the attached shops. When creating a new user, a new shop can be automatically created by specifying a shop name in the meta data. The meta can also contain an invitation code which will connect the new user to an existing user whose [invitation](/api/resources/invitations/) has been accepted.

## User

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/Users)

Attribute    | Description
------------ | -----------
first_name   | First name.
last_name    | Last name, including any middle names.
company      | Company name.
email        | A valid email address, used to send a registration confirmation.
phone_number | Phone number.
created_at   | Unix timestamp when the user was created.

{{% notice note %}}
The meta below does not belong to the resource. It is only available for the **POST** request when creating a new user.
{{% /notice %}}

Meta            | Description
--------------- | -----------
shop_name       | Provide when you want to create a first shop for this new user.
invitation_code | Provide when accepting an invite, this user will be linked to the inviter.
