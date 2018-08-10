+++
title = "Authentication"
weight = 1
+++

The MyParcel.com API uses OAuth 2.0 for authentication.

## OAuth 2.0
[OAuth 2.0](https://oauth.net/2) is the industry-standard protocol for authentication. This makes it easy to implement because there are many tutorials, explanations and libraries available to help out. In these chapters we will explain the flow to work with the MyParcel.com authentication server and highlight a few important caveats when implementing it in your own project.

{{% notice note %}}
Although the MyParcel.com API uses the content type `application/vnd.api+json`, the authentication server does not. It uses regular `application/json` to be more in line with other OAuth 2.0 implementations.
{{% /notice %}}

### Grant Types
OAuth 2.0 describes a number of grants ("methods") to acquire an access token which can be used to authenticate a request to an API endpoint. Which grant you should use depends on several factors, but for now the MyParcel.com API only supports the Client Credentials grant publicly. This grant is used for machine-to-machine communication.

More information about the Client Credentials grant can be found [here](./client-credentials-grant).

[Contact us](https://www.myparcel.com/contact) if you need support for a different grant type.
