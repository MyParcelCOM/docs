+++
title = "Advanced usage"
weight = 6
+++

## Caching
By default the sdk uses the filesystem to cache both resources and access tokens. To use another type of caching, any cache instance implementing `Psr\SimpleCache\CacheInterface` can be used. This instance should be supplied at construction of `MyParcelComApi` and `ClientCredentials`.

```php
$redis = new RedisCache();
$api = new \MyParcelCom\ApiSdk\MyParcelComApi(
    'https://sandbox-api.myparcel.com',
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
The sdk uses [Guzzle](http://guzzlephp.org/) to send http requests to the API. If the Guzzle Client needs to be configured differently for your setup (eg. you need to connect through a proxy), then you can supply the sdk with a different client.

```php
// Create a Guzzle client that connects through a proxy.
$client = new \GuzzleHttp\Client([
    'proxy' => [
        'http'  => 'tcp://localhost:8125',
        'https' => 'tcp://localhost:9124',
    ],
]);

// Add the client to the authenticator and api.
$authenticator->setHttpClient($client);
$api->setHttpClient($client);
```

## Custom resource classes
The sdk uses the `MyParcelCom\ApiSdk\Resources\ResourceFactory` to instantiate and hydrate all resource objects. If you want the sdk to instantiate your own classes and hydrate them, a `ResourceFactory` can be created and factory callables can be added to it to define how to instantiate a resource. Note that
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
