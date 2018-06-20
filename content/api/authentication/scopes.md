+++
title = "Scopes"
weight = 22
+++

This is a list of scopes which can be included when requesting an access token.

Scope                | The application will be able to
-------------------- | -----------
organizations.make   | create new organizations
organizations.manage | see all organization details as well as create, update and delete organizations
organizations.show   | see all details relating to this organization
shipments.manage     | see all shipment details as well as create, update and delete shipments
shipments.show       | see all details relating to the shipments of this shop
shops.manage         | see all shop details as well as create, update and delete shops
shops.show           | see all details relating to this shop
users.manage         | see all user details as well as update user information
users.show           | see all details relating to the user

{{% notice tip %}}
When requesting a token from the auth server, you can use a wildcard `*` to include all scopes available to your user.
{{% /notice %}}
