+++
title = "Connecting with the API"
weight = 2
+++

To start communicating with the MyParcel.com API, you need to create an instance of the `MyParcelComApi` class. This class will facilitate all interaction with the API. The URL to the API should be supplied as the first argument during construction. This will default to our sandbox URL, which is great for testing and developing, but should be changed to our production URL when you deploy your application.

```php
$api = new \MyParcelCom\ApiSdk\MyParcelComApi(
    null,
    'https://sandbox-api.myparcel.com'
);
```

## Http Clients
The first parameter of the MyParcelComApi constructor method can be any HTTP client that implements the [PSR-18 interface](https://www.php-fig.org/psr/psr-18/). 
If an HTTP client is not provided, the SDK will try to detect which HTTP clients are available and attempt to use one of those through an adapter.
Currently, the following are supported:
- Guzzle 5 (`composer require php-http/guzzle5-adapter`)
- Guzzle 6 (`composer require php-http/guzzle6-adapter`)
- Curl (`composer require php-http/curl-client`)
 

## Authentication

Most interactions with the API will require authorization. A class for authentication using the `client_credentials` grant can be used to authenticate the user. A `client id` and `client secret` are needed to authenticate with the OAuth 2.0 server. A URL should be supplied to define the location of the OAuth2.0 server. This will also default to our sandbox URL and should be changed for production.

```php
$authenticator = new \MyParcelCom\ApiSdk\Authentication\ClientCredentials(
    'your-client-id',
    'your-client-secret',
    'https://sandbox-auth.myparcel.com'
);

$api->authenticate($authenticator);
```

## Singleton instance

We recommend using an IoC container to instantiate a singleton of the `MyParcelComApi` class. However, we also supply a couple of static functions to instantiate a singleton instance and give you the ability to retrieve it anywhere in your code. This can be convenient when developing plugins or working in legacy code where an IoC container is not available.

```php
// Create the singleton once, to make it available everywhere.
$api = \MyParcelCom\ApiSdk\MyParcelComApi::createSingleton(
    new \MyParcelCom\ApiSdk\Authentication\ClientCredentials(
        'client-id',
        'client-secret',
        'https://sandbox-auth.myparcel.com'
    ),
    null,
    'https://sandbox-api.myparcel.com'
);

// The singleton instance can now be retrieved anywhere.
$api = \MyParcelCom\ApiSdk\MyParcelComApi::getSingleton();
```
