+++
title = "Invitations"
description = "Invitations sent to friends and the users connected this way."
weight = 6
+++

The invitations are used to invite new users to the MyParcel.com platform. When an invitation is created, our system will automatically send an email to the provided email address. If the link in this email is used to complete a registration, the new user will be linked to the user who created the invite.

## invitation

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/Invitations)

Attribute | Description
--------- | -----------
code      | Needed to link the new user to the user who created the invite.
email     | A valid email address, used to send an email with invitation link.
name      | Name of the invited user.
message   | Message to the invited user. This will be included in the email body.
status    | If the invite is pending or accepted.
