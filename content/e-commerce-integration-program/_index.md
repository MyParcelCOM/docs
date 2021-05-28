+++
title = "e-Commerce Integration Program"
weight = 5
+++

Welcome to the documentation of the e-Commerce Integration Program.

### Introduction
E-commerce platforms make it easy for webshops to manage incoming orders. 
By integrating e-commerce platforms with shipping software, webshops can also easily print labels and keep track of these orders. 
The MyParcel.com ecosystem already supports a variety of e-commerce platforms, but we are always looking to add more.
We have started the e-commerce integration program as an initiative to make it easy for third party developers to create an integration between e-commerce platforms and MyParcel.com.

### Getting Started
#### Theory of operation
The diagram below shows how MyParcel.com would get shipments from a remote API (in this example the trading API of eBay):
{{< figure src="/images/e-com-integration-flow.png" title="The order in which hooks are executed" alt="e-Commerce Integration Flow" >}}

The following steps are executed:

1. MyParcel.com platform asks the integration for shipments
2. Integration asks remote API for orders
3. Remote API responds with list of orders
4. Integration transforms orders into MyParcel.com compatible shipments and responds with them

#### PHP Skeleton based on Laravel
We have created a Laravel-based [skeleton application](https://github.com/MyParcelCOM/integration-skeleton) for PHP developers.
This skeleton contains boilerplate for some functionality such as OAuth 2.0 authorization with Authorization Code flow and transforming shipment data to the requested format.
More information about this skeleton can be found in the readme on the [Github](https://github.com/MyParcelCOM/integration-skeleton) page.

To start working on the application using the skeleton, it is advised that you fork the repository.

#### Authentication / authorization with remote APIs
The integration-skeleton ships with a OAuth 2.0 Authorization Code Grant Type basics for authenticating with APIs that provide OAuth 2.0.
You can choose to build on top of the provided authentication code or build your own. Most cases with OAuth 2.0 Authorization Code flow you will need minimal involvement of MyParcel.com support, while other types of authentication/authorization would require assistance before approval.


### Contact
For any questions regarding development of new integrations please refer to our [GitHub Discussions page](https://github.com/MyParcelCOM/integration-skeleton/discussions). We motivate you to start new discussions in case you require help.
