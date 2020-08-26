+++
title = "Scopes"
weight = 22
+++

Below is a list of scopes which can be included when requesting an access token.

{{% notice tip %}}
When requesting a token from the auth server, you can use a wildcard `*` to include all scopes available to your user.
{{% /notice %}}

Scope                | The application will be able to
-------------------- | -----------
broker.member        | Retrieve broker related resources and create organizations for that broker.
contracts.manage     | Manage contract resources.
organizations.manage | Manage organization related resources on behalf of a single organization or all organizations belonging to a broker.
shipments.manage     | Manage shipments on behalf of all shops belonging to an organization or broker.
system.manage        | Manage all system related resources.
users.manage         | Manage user resources.
experimental         | Access to experimental endpoints.
