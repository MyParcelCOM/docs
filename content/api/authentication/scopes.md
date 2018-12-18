+++
title = "Scopes"
weight = 22
+++

This is a list of scopes which can be included when requesting an access token.

Scope                | The application will be able to
-------------------- | -----------
organizations.manage | Manage organization related resources on behalf of a single organization or all organizations belonging to a broker.
shipments.manage     | Manage shipments on behalf of all shops belonging to a single organization or all shops belonging to a broker.
system.manage        | Manage all system related resources.
experimental         | This scope contains all permissions for experimental endpoints.

{{% notice tip %}}
When requesting a token from the auth server, you can use a wildcard `*` to include all scopes available to your user.
{{% /notice %}}
