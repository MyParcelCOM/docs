+++
title = "Authorization"
weight = 1
+++

The MyParcel.com API uses OAuth 2.0 for authentication.

## OAuth 2.0
OAuth 2.0 is the industry-standard protocol for authorization. This makes it easy to implement because a vast amount of tutorials, explanations and libraries are available to implement it. In these chapters we will explain the flow to work with the MyParcel.com authentication server and highlight a few important caveats when implementing it in your own project.

### Grant Types
OAuth 2.0 describes a number of grants ("methods") to acquire an access token which can be used to authenticate a request to an API endpoint. Which grant you should use depends on the type of the application, the way your application communicates with the API and who the owner is of the access token.

Currently the MyParcel.com API only supports the Client Credentials grant publicly. This grant is used for machine-to-machine communication where the machine is the owner of the access token. More information about the Client Credentials grant can be found [here](./client-credentials-grant).

{{% notice warning %}}
You should **NOT** use the Client Credentials grant if the user is the owner of the access token.
{{% /notice %}}
[Contact us](https://www.myparcel.com/contact) if you need support for a different grant type.