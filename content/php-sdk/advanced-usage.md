+++
title = "Advanced usage"
weight = 6
+++

## Caching
By default the SDK uses the filesystem to cache both resources and access tokens. To use another type of caching, any cache instance implementing `Psr\SimpleCache\CacheInterface` can be used. This instance should be supplied at construction of `MyParcelComApi` and `ClientCredentials`.

```php
$redis = new RedisCache();
$api = new \MyParcelCom\ApiSdk\MyParcelComApi(
    'https://sandbox-api.myparcel.com',
    null,
    $redis
);

$authenticator = new \MyParcelCom\ApiSdk\Authentication\ClientCredentials(
    'your-client-id',
    'your-client-secret',
    'https://sandbox-auth.myparcel.com',
    $redis
);
```

## Configuring a different http client
By default The SDK will try to use any of the installed Http clients, given that the client is an [implementation of php-http/httplug](https://packagist.org/providers/php-http/client-implementation).
To use a different HTTP client, either inject it through the constructor method, or use the `setHttpClient()` method. 

```php
// Create a Curl client.
$client = new Http\Client\Curl\Client();

// Add the client to the authenticator and api.
$authenticator->setHttpClient($client);
$api->setHttpClient($client);

// Or inject it through the constructor
$api = new MyParcelCom\ApiSdk\MyParcelComApi(
    'https://sandbox-api.myparcel.com',
    $client
);
$authenticator = new MyParcelCom\ApiSdk\Authentication\ClientCredentials(
    'your-client-id',
    'your-client-secret',
    'https://sandbox-auth.myparcel.com',
    null,
    $client
);
```

The example above uses the `php-http/curl-client` package, which is an implementation of the `php-http/httplug` package.

## Custom resource classes
The SDK uses the `MyParcelCom\ApiSdk\Resources\ResourceFactory` to instantiate and hydrate all resource objects. If you want the SDK to instantiate your own classes and hydrate them, a `ResourceFactory` can be created and factory callables can be added to it to define how to instantiate a resource. Note that
when using your custom classes, they should still implement the corresponding resource's interface.

```php
use MyParcelCom\ApiSdk\Resources\Interfaces\ShipmentInterface;
use MyParcelCom\ApiSdk\Resources\Interfaces\ResourceInterface;
use MyParcelCom\ApiSdk\Resources\ResourceFactory;

class CustomShipment implements ShipmentInterface
{
    // Your shipment implementation.
}

$customShipmentInitializer = function ($type, $attributes) {
    $shipment = new CustomShipment();

    // Your shipment initialization.

    return $shipment;
};

$factory = new ResourceFactory();
$factory->setFactoryForType(ResourceInterface::TYPE_SHIPMENT, $customShipmentInitializer);
$factory->setFactoryForType(ShipmentInterface::class, $customShipmentInitializer);

$api->setResourceFactory($factory);
```
