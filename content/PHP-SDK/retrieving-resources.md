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

### Shipments
Shipments are the resources that you will interact with the most. Creating and retrieving shipments can be done through the SDK. As wel as retrieving the shipment status and any files associated with the shipment.

To create a shipment an object implementing `\MyParcelCom\ApiSdk\Resources\Interfaces\ShipmentInterface` should be created. A class implementing this interface has been provided in `\MyParcelCom\ApiSdk\Resources\Shipment`. At least a recipient address and a weight should be provided in the shipment. All other fields are optional or will be filled with defaults by the SDK.

```php
use MyParcelCom\ApiSdk\Resources\Address;
use MyParcelCom\ApiSdk\Resources\Shipment;

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

### Carriers
Services for different carriers are available through the API. The SDK can retrieve all the carriers the currently authenticated user can access. All carriers will be mapped to objects implementing `MyParcelCom\ApiSdk\Resources\Interfaces\CarrierInterface`.

```php
// Get the carriers.
$carriers = $api->getCarriers();
```

### Services
The services (eg 'DPD next day') available in the API can be retrieved using the SDK. There are three ways to retrieve them. Either get all available services, the services available for a specific shipment, or all available services from a specific carrier.

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
$contracts = $service->getServiceContracts();
$contract = $contracts[0];

// Get the weight groups for this contract and the prices.
$contract->getServiceGroups();

// Get the insurance groups for this contract and the prices.
$contract->getServiceInsurances();

// Get the options for this contract (eg 'sign on delivery').
$contract->getServiceOptions();
```

When creating a shipment either a specific contract can be selected, or the SDK will select a preferred contract.

### Pick-up/drop-off locations
Most carriers allow the recipient to define a pick-up location and a sender to define a drop-off location. The SDK can retrieve these locations from the API and can easily be displayed using the [MyParcel.com Delivery Plugin](https://github.com/MyParcelCOM/delivery-plugin).

Most carriers only need a postal code in a specific country, but some carriers also require a street name and number. It is therefore recommended to always supply all this information to the SDK.

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
The API supports sending parcels from one country/state/province to another. These are split up into `regions` in the API. These are mostly used to define which services are available between what regions. A list of these regions as defined by the API can be retrieved through the SDK.

```php
// Get all the regions.
$api->getRegions();

// Get all the regions in the United Kingdom.
$api->getRegions('GB');

// Get the region for Scotland.
$api->getRegions('GB', 'SCH');
```
