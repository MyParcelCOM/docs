+++
title = "Retrieving resources"
weight = 2
+++

Most of the resources available in the API can be accessed using the SDK. All resources will be mapped to classes implementing their specific interface. These interfaces are all defined in the
`\MyParcelCom\ApiSdk\Resources\Interfaces` namespace.

### Shops
All the shops or the default shop for the currently authenticated user can be retrieved. The shops will be mapped to objects implementing `\MyParcelCom\ApiSdk\Resources\Interfaces\ShopInterface`.

```php
// Get all shops.
$shops = $api->getShops();

// Get the default shop.
$shop = $api->getDefaultShop();
```

### Carriers
Services for different carriers are available through the API. The SDK can retrieve all the carriers the currently authenticated user can access. All carriers will be mapped to objects implementing `MyParcelCom\ApiSdk\Resources\Interfaces\CarrierInterface`.

```php
// Get the carriers.
$carriers = $api->getCarriers();
```

### Pick-up/drop-off locations
Most carriers allow the recipient to define a pick-up location and a sender to define a drop-off location. The SDK can retrieve these locations from the API after which they can easily be displayed using the [MyParcel.com Delivery Plugin](https://github.com/MyParcelCOM/delivery-plugin).

Most carriers only need a postal code in a specific country, but some carriers also require a street name and number. It is therefore recommended to always supply all this information to the SDK.

Including the (optional) `specificCarrier` parameter will return an array of the pick-up/drop-off locations for only that carrier.

When no specific carrier is defined, the pick-up/drop-off locations of all available carriers will be returned as an array of the carrier ids as keys and an array of their locations as the values. When requesting the locations from one of the carriers fails, the array of locations for that carrier is replaced with `null`.

Note that when you do specify a specific carrier a `GuzzleHttp\Exception\RequestException` will be thrown when the request fails.

```php
// Get all pick-up/drop-off locations near the area with postal code 'NW1 6XE'
// in the United Kingdom for all carriers.
$locations = $api->getPickUpDropOffLocations('GB', 'NW1 6XE', 'Baker Street', 221);

// Same as above, but for specified carrier.
$locations = $api->getPickUpDropOffLocations('GB', 'NW1 6XE', 'Baker Street', 221, $carrier);
```

To only retrieve pick-up/drop-off locations for carriers for which the authenticated user has an active contract, the optional `onlyActiveContracts` parameter should be set to `true` in the method call.

```php
// The last parameter in the method call indicates whether to only retrieve pick-up/drop-off locations for carriers with an active contract or not.
$locations = $api->getPickUpDropOffLocations('GB', 'NW1 6XE', 'Baker Street', 221, null, true);
```

### Regions
The API supports sending parcels from one country/state/province to another. These are split up into `regions` in the API. These are mostly used to define which services are available between what regions. A list of these regions as defined by the API can be retrieved through the SDK. Regions should implement the `\MyParcelCom\ApiSdk\Resources\Interfaces\RegionInterface`.

```php
// Get all the regions.
$api->getRegions();

// Get all the regions in the United Kingdom.
$api->getRegions('GB');

// Get the region for Scotland.
$api->getRegions('GB', 'SCH');
```

### Services
The services (eg 'DPD next day') available in the API can be retrieved using the SDK. There are three ways to retrieve them. Either get all available services, the services available for a specific shipment, or all available services from a specific carrier. Services will be mapped to the `\MyParcelCom\ApiSdk\Resources\Interfaces\ServiceInterface`.

```php
// Get all services.
$services = $api->getServices();

// Get all services that can handle the shipment.
$services = $api->getServices($shipment);

// Get all services for specific carrier.
$services = $api->getServicesForCarrier($carrier);
```

### Service rates
The price of a service is detailed in a related service rate resource. A service resource can have multiple related service rate resources, each with different attributes like weight range or relationships like [contract](/api/resources/contracts) or [service options](/api/resources/service-options). Learn more about service rates on the [service rates resource page](/api/resources/service-rates).

There are currently three ways to retrieve service rates. Either get all available service rates, the service rates available for a shipment, or all available service rates belonging to a specific service. Service rates will be mapped to the `\MyParcelCom\ApiSdk\Resources\Interfaces\ServiceRateInterface`.

```php
// Get all available service rates.
$api->getServiceRates();

// Get all available service rates for a shipment.
$api->getServiceRatesForShipment($shipment);

// Get all available service rates for a service.
$service->getServiceRates();
```

Note that service rates can not be linked to a shipment directly. A service rate has a relation to a service resource, a contract resource and service option resources, and should only be used to determine which service, contract and service options to use when creating a shipment. 

### Service options
Service options add extra's to a service, often against a higher price. Retrieving service options is done by requesting them from a service rate. Service options will be mapped to the `\MyParcelCom\ApiSdk\Resources\Interfaces\ServiceOptionInterface`.

```php
// Get the service options for a service rate.
$serviceOptions = $serviceRate->getServiceOptions();
```

### Shipments
Shipments are the resources that you will interact with the most. Creating and retrieving shipments can be done through the SDK. As well as retrieving the shipment status and any files associated with the shipment.

#### Creating shipments
To create a shipment, an object implementing `\MyParcelCom\ApiSdk\Resources\Interfaces\ShipmentInterface` should be created. A class implementing this interface has been provided in `\MyParcelCom\ApiSdk\Resources\Shipment`. At least a recipient address and a weight should be provided in the shipment. All other fields are optional or will be filled with defaults by the SDK.

```php
use MyParcelCom\ApiSdk\Resources\Address;
use MyParcelCom\ApiSdk\Resources\Shipment;
use MyParcelCom\ApiSdk\Resources\Interfaces\PhysicalPropertiesInterface;

// Define the recipient address.
$recipient = new Address();
$recipient
    ->setStreet1('Baker Street')
    ->setStreetNumber(221)
    ->setCity('London')
    ->setPostalCode('NW1 6XE')
    ->setFirstName('Sherlock')
    ->setLastName('Holmes')
    ->setCountryCode('GB')
    ->setRegionCode('ENG')
    ->setEmail('s.holmes@holmesinvestigations.com');

// Create the shipment and set required parameters.
$shipment = new Shipment();
$shipment
    ->setRecipientAddress($recipient)
    ->setWeight(500, PhysicalPropertiesInterface::WEIGHT_GRAM);

// Have the SDK determine the cheapest service and post the shipment to the MyParcel.com API.
$createdShipment = $api->createShipment($shipment);
```

If the shipment being created is invalid or there is no valid service available, a `MyParcelCom\ApiSdk\Exceptions\InvalidResourceException` will be thrown.

If you wish to specify which service to use with your shipment, you should assign it to the shipment before creating it.
```php
use MyParcelCom\ApiSdk\Resources\Shipment;
use MyParcelCom\ApiSdk\Resources\Interfaces\PhysicalPropertiesInterface;

$shipment = new Shipment();
$shipment
    ->setRecipientAddress($recipient)
    ->setWeight(500, PhysicalPropertiesInterface::WEIGHT_GRAM)
    ->setService($service);
    
// Post the shipment to the API.
$createdShipment = $api->createShipment($shipment);
```

If you wish to add service options to a shipment before creating it in the API, you can do this in two ways. Either by setting all service options at once, or adding them one by one.

```php
use MyParcelCom\ApiSdk\Resources\Shipment;

$shipment = new Shipment();

// Setting a service option one by one.
$shipment->addServiceOption($serviceOption);

// Setting all service options at once.
$shipment->setServiceOptions($serviceOptions);
```

#### Retrieving shipments
After the shipment has been created, it will be updated with an id and a price. Using the id, the shipment can be retrieved from the API to check the status and retrieve any associated files.

```php
// Post your newly created shipment to the API.
$createdShipment = $api->createShipment($newShipment);

// Get the updated shipment from the API based on its id.
$updatedShipment = $api->getShipment($createdShipment->getId());

// Get the current status of the shipment.
$status = $updatedShipment->getShipmentStatus();

// Get the files associated with the shipment, eg label.
$files = $updatedShipment->getFiles();
```

It is also possible to retrieve all shipments. There are currently two ways to retrieve them. Either retrieve all available shipments or retrieve the shipments that were created using a specific shop.

```php
// Retrieve all available shipments.
$shipments = $api->getShipments();

// Retrieve all shipments created using a certain shop.
$shipments = $api->getShipments($shop);
```

### Files
When a shipment has been successfully registered with a carrier, a shipping label will be available for the shipment. In some cases the shipping label is accompanied by one of more additional files. (eg when creating an international shipment, a customs form may be made available). These files can be requested from a shipment.

```php
// Get the shipment based on its id.
$shipment = $api->getShipment('31a5657d-d845-4266-83ac-50b72ccb195f');

// Get all the files associated with the shipment.
$files = $shipment->getFiles();

// Get the shipment label(s).
$labels = $shipment->getFiles(FileInterface::DOCUMENT_TYPE_LABEL);
```

A file can be available in multiple formats (although the most common one is PDF). The formats are available in the file resource.

```php
// Get an array with all the formats this file is available in.
$file->getFormats();
```

The actual file can be retrieved in different ways, depending on your use case.

```php
// Get a stream for the file in pdf format. This is useful for when you want to
// send the file to a user in a stream.
// Note that this won't work if the file is not available in pdf format,
// check `getFormats()` before doing this request.
$stream = $file->getStream('application/pdf');

// Get the file data as a base64 encoded string. This is useful for when you want
// to embed the file in an email.
$data = $file->getBase64Data('application/pdf');

// Get the path to the temporary file stored on the system.
$path = $file->getTemporaryFilePath('application/pdf');
```
