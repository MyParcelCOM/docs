+++
title = "Register a user"
description = "You need a user and a shop before you can start using other resources."
weight = 1
+++

You need a `client` connected to a `user` and a `shop` before you can start using protected API resources.

- Use the [registration form](https://backoffice.myparcel.com/registration) on our website.
- Create a password using the link in the email.
- Provide your shop details after logging in.

## API key

- Login to the [MyParcel.com backoffice](https://backoffice.myparcel.com).
- Create a new `client` to receive a client ID and client secret.
- The combination of this ID and secret can be used to request a `token`.
- This `token` can be used to do API requests until it expires.
