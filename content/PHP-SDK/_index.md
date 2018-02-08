+++
title = "PHP-SDK"
weight = 2
+++

The PHP-SDK can be used to easily communicate with the MyParcel.com API. For more information about the MyParcel.com API, see the [API section](/api) of the documentation.

## Features
As the API is updated with new features, these features will be added to the sdk for easier access. Currently the following features are supported by the sdk:

- Authentication with our (OAuth 2.0) authentication server, using the [client_credentials](https://tools.ietf.org/html/rfc6749#section-4.4) grant.
- Shipment creation.
- Resource retrieval of the following types:
  - [shops](/api/resources/shops)
  - [regions](/api/resources/regions)
  - [shipments](/api/resources/shipments)
  - [files](/api/resources/files)
  - [carriers](/api/resources/carriers)
  - [pick-up/drop-off locations](/api/resources/pudolocations)

## Installation

You can install the sdk using [composer](https://getcomposer.org/doc/00-intro.md).

```bash
composer require myparcelcom/sdk
```

## Usage
To start communicating with the MyParcel.com API, you need to create an instance of the `MyParcelComApi` class. This class will facilitate all interaction with the API. The URL to the API should be supplied as the first argument during construction. If no url is supplied it will default to our sandbox URL.

```php
$api = new \MyParcelCom\Sdk\MyParcelComApi(
    'https://sandbox-api.myparcel.com'
);
```

For convenience, a singleton of the `MyParcelComApi` class can be instantiated using its static methods.

```php
// Create the singleton once, to make it available everywhere.
$api = \MyParcelCom\Sdk\MyParcelComApi::createSingleton(
    new \MyParcelCom\Sdk\Authentication\ClientCredentials(
        'client-id',
        'client-secret',
        'https://sandbox-auth.myparcel.com'
    ),
    'https://sandbox-api.myparcel.com'
);

// The singleton instance can now be retrieved anywhere.
$api = \MyParcelCom\Sdk\MyParcelComApi::getSingleton();
```

## Authentication
Most interactions with the API will require authorization. A class for authentication using the `client_credentials` grant can be used to authenticate the user. A `client id` and `client secret` are needed to authenticate with the OAuth 2.0 server. A URL should be supplied to define the location of the OAuth2.0 server.

```php
$authenticator = new \MyParcelCom\Sdk\Authentication\ClientCredentials(
    'your-client-id',
    'your-client-secret', 
    'https://sandbox-auth.myparcel.com'
);

$api->authenticate($authenticator);
```

## Resources
Most of the resources available in the API can be accessed using the sdk. All resources will be mapped to classes implementing their specific interface. These interfaces are all defined in the
`\MyParcelCom\Sdk\Resources\Interfaces` namespace.

### Shops
All the shops or the default shop for the currently authenticated user can be retrieved. The shops will be mapped to objects implementing `\MyParcelCom\Sdk\Resources\Interfaces\ShopInterface`.

```php
// Get all shops.
$shops = $api->getShops();

// Get the default shop.
$shop = $api->getDefaultShop();
```

### Shipments
Shipments are the resources that you will interact with the most. Creating and retrieving shipments can be done through the sdk. As wel as retrieving the shipment status and any files associated with the shipment.

To create a shipment an object implementing `\MyParcelCom\Sdk\Resources\Interfaces\ShipmentInterface` should be created. A class implementing this interface has been provided in `\MyParcelCom\Sdk\Resources\Shipment`. At least a recipient address and a weight should be provided in the shipment. All other fields are optional or will be filled with defaults by the sdk.

```php
use MyParcelCom\Sdk\Resources\Address;
use MyParcelCom\Sdk\Resources\Shipment;

// Define the recipient address.
$recipient = new Address();
$recipient
    ->setStreet1('Street name')
    ->setStreetNumber(9)
    ->setCity('City name')
    ->setPostalCode('Postal code')
    ->setFirstName('First name')
    ->setLastName('Last name')
    ->setCountryCode('GB')
    ->setEmail('email@example.com');

// Define the weight.
$shipment = new Shipment();
$shipment
    ->setRecipientAddress($recipient)
    ->setWeight(500, Shipment::WEIGHT_GRAM);

// Create the shipment
$createdShipment = $api->createShipment($shipment);
```

If the shipment being created is invalid or there is no valid service available, an exception will be thrown.

If you wish to use your own contracts with your shipment, you should assign it to the shipment before creating it.

After the shipment has been created, it will be updated with an id and a price. Using the id, the shipment can be retrieved from the API to check the status and retrieve any associated files.

```php
// Get the shipment based on its id. 
$shipment = $api->getShipment('31a5657d-d845-4266-83ac-50b72ccb195f');

// Get the current status of the shipment.
$status = $shipment->getStatus();

// Get the files associated with the shipment, eg label.
$files = $shipment->getFiles();
```

### Files
When a shipment has been successfully registered with a carrier, a shipping label will be available for the shipment. In some cases the shipping label is accompanied by one of more additional files. (eg when creating a PostNL shipment we also return a print code, that can be used to print a label on a
pick-up/drop-off location in case the customer has no printer). These files can be requested from a shipment.

### Carriers
Services for different carriers are available through the API. The sdk can retrieve all the carriers the currently authenticated user can access. All carriers will be mapped to objects implementing `MyParcelCom\Sdk\Resources\Interfaces\CarrierInterface`.

```php
// Get the carriers.
$carriers = $api->getCarriers();
```

### Services
The services (eg 'DPD next day') available in the API can be retrieved using the sdk. There are three ways to retrieve them. Either get all available services, the services available for a specific shipment, or all available services from a specific carrier.

```php
// Get all services.
$services = $api->getServices();

// Get all services that can handle the shipment.
$services = $api->getServices($shipment);

// Get all services for specific carrier.
$services = $api->getServicesForCarrier($carrier);
```

### Contracts
Each service has contracts associated with it. A contract determines the price for the shipment and what options are available (eg 'sign on delivery'). You can use our offered contracts or use a contract you have directly with the carrier you want to use. These contracts can be retrieved from a service.

```php
// Get the contracts for this service.
$contracts = $service->getContracts();
$contract = $contracts[0];

// Get the weight groups for this contract and the prices.
$contract->getGroups();

// Get the insurance groups for this contract and the prices.
$contract->getInsurances();

// Get the options for this contract (eg 'sign on delivery').
$contract->getOptions();
```

When creating a shipment either a specific contract can be selected, or the sdk will select a preferred contract.

### Pick-up/drop-off locations
Most carriers allow the recipient to define a pick-up location and a sender to define a drop-off location. The sdk can retrieve these locations from the API and can easily be displayed using the [MyParcel.com Delivery Plugin](https://github.com/MyParcelCOM/delivery-plugin).

Most carriers only need a postal code in a specific country, but some carriers also require a street name and number. It is therefore recommended to always supply all this information to the sdk.

The last (optional) parameter is a specific carrier. Including this will return an array of the pick-up/drop-off locations for only that carrier. 

When no specific carrier is defined, the pick-up/drop-off locations of all available carriers will be returned as an array of the carrier ids as keys and an array of their locations as the values. When requesting the locations from one of the carriers fails, the array of locations for that carrier is replaced with `null`. 

Note that when you do specify a specific carrier an exception will be thrown when the request fails.

```php
// Get all pick-up/drop-off locations near the area with postal code '1AR BR2'
// in the United Kingdom for all carriers.  
$locations = $api->getPickUpDropOffLocations('GB', '1AR BR2', 'Street name', 4);

// Same as above, but for specified carrier.
$locations = $api->getPickUpDropOffLocations('GB', '1AR BR2', 'Street name', 4, $carrier);
```

### Regions
The API supports sending parcels from one country/state/province to another. These are split up into `regions` in the API. These are mostly used to define which services are available between what regions. A
list of these regions as defined by the API can be retrieved through the sdk.

```php
// Get all the regions.
$api->getRegions();

// Get all the regions in the United Kingdom.
$api->getRegions('GB');

// Get the region for Scotland.
$api->getRegions('GB', 'SCH');
```

## File Combining
The sdk provides a class for combining files into 1 pdf. Using this you can create a pdf file with multiple labels for printing. The class takes an array of objects that implement `FileInterface` and returns a new object that implements `FileInterface`.

```php
use MyParcelCom\Sdk\LabelCombiner;
use MyParcelCom\Sdk\Resources\Interfaces\FileInterface;

$files = array_merge(
    $shipmentA->getFiles(FileInterface::RESOURCE_TYPE_LABEL),
    $shipmentB->getFiles(FileInterface::RESOURCE_TYPE_LABEL)
);

$labelCombiner = new LabelCombiner();
$combinedFile = $labelCombiner->combineLabels($files);
```

The page size (A4, A5, A6), the starting position as well as a margin can be specified when combining the labels.

```php
use MyParcelCom\Sdk\LabelCombinerInterface;

$combinedFile = $labelCombiner->combineLabels(
    $files,
    LabelCombinerInterface::PAGE_SIZE_A4,
    LabelCombinerInterface::LOCATION_BOTTOM_LEFT,
    20
);
```

## Advanced usage

### Caching
By default the sdk uses the filesystem to cache both resources and access tokens. To use another type of caching, any cache instance implementing `Psr\SimpleCache\CacheInterface` can be used. This instance should be supplied at construction of `MyParcelComApi` and `ClientCredentials`.

```php
$redis = new RedisCache();
$api = new \MyParcelCom\Sdk\MyParcelComApi(
    'https://sandbox-api.myparcel.com',
    $redis
);

$authenticator = new \MyParcelCom\Sdk\Authentication\ClientCredentials(
    'your-client-id',
    'your-client-secret', 
    'https://sandbox-auth.myparcel.com',
    $redis
);
```

### Configuring a different http client
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

### Custom resource classes
The sdk uses the `MyParcelCom\Sdk\Resources\ResourceFactory` to instantiate and hydrate all resource objects. If you want the sdk to instantiate your own classes and hydrate them, a `ResourceFactory` can be created and factory callables can be added to it to define how to instantiate a resource. Note that
when using your custom classes, they should still implement the corresponding resource's interface.

```php
use MyParcelCom\Sdk\Resources\Interfaces\ShipmentInterface;
use MyParcelCom\Sdk\Resources\Interfaces\ResourceInterface;
use MyParcelCom\Sdk\Resources\ResourceFactory;

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

## Support
Do not hesitate to contact us if you have any further questions or feedback about our sdk. We would love to hear from you. You can get in touch [here](https://myparcel.com/contact).
