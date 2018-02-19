+++
title = "Common use case"
weight = 4
+++

The MyParcel.com API is used mainly for creating shipments and retrieving labels for the shipments. There are a couple of steps you will have to do for each shipment:
- Create a shipment resource.
- Wait for the status to transition from `shipment_concept` to `shipment_registered`.
- Download the label.
- Hand the physical parcel over to the carrier.

## Creating the shipment
To create a new shipment, you should create a new instance of a `Shipment`, set the required properties on the shipment and have it sent to the MyParcel.com API by calling the method `MyParcelComApi::createShipment()`.

The minimal required properties to set on a shipment are a sender address and a weight. There are however a lot more properties you can (and should) set on the shipment. These are the shop, sender address and service contract. Whenever these are not set, the SDK will automatically set them for you. The default shop will be chosen and that shop's return address will be used as a sender address. For the service contract, the cheapest one will be calculated and selected.

This behaviour is not a problem for when you only have one shop and don't mind what carrier you use. However, when you have more than one shop, have multiple locations you want to send from or want to select the service (and contract) to use, you should set (one or more of) these values.


```php
use MyParcelCom\ApiSdk\Resources\Address;
use MyParcelCom\ApiSdk\Resources\Shipment;

// Define the sender address.
$sender = new Address();
$sender
    ->setStreet1('Street name')
    ->setStreetNumber(12)
    ->setCity('City name')
    ->setPostalCode('Postal code')
    ->setCountryCode('GB')
    ->setCompany('My company');

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


// Get your shops from the api.
$shops = $api->getShops();

// Select one of the shops to use.
$myShop = ...


// Get the available services from the API.
$services = $api->getServices();

// From the services select the service and the contract.
// (use the `PriceCalculator` if you want to base your choice on the price)
$myServiceContract = ...


// Define the weight.
$shipment = new Shipment();
$shipment
    ->setSenderAddress($sender)
    ->setRecipientAddress($recipient)
    ->setShop($myShopp)
    ->setServiceContract($myServiceContract)
    ->setWeight(500, Shipment::WEIGHT_GRAM);

// Create the shipment
$createdShipment = $api->createShipment($shipment);
```

Now that you've created a shipment, you should store its id (`$createdShipment->getId()`) somewhere so you can later retrieve any files associated with the shipment and check for status updates.

## Downloading the shipment label
When you create a shipment, it's status will be `shipment_concept`. The shipment will be registered at the carrier as soon as possible and then transition to `shipment_registered`. This should normally not take more than a minute, but depending on the carrier, it can take a little bit longer. To check the status of a shipment you can retrieve the shipment through the API and then retrieve the status.

```php
// Retrieve the shipment id from where you stored it.
$id = ...

// Get the shipment from the api.
$shipment = $api->getShipment($id);

// Get the shipment status.
$shipmentStatus = $shipment->getStatus();

// This can hold extra data given by the carrier, like the carrier's status code
// description.
$shipmentStatus->setCarrierStatusCode();
$shipmentStatus->getCarrierStatusDescription();

// But most importantly it holds the normalized status.
$status = $shipmentStatus->getStatus();

// Which holds a level, that we can check if it's a success or failed status.
if ($status->getLevel() === 'success') {
    // The shipment has transitioned to a successful state!
    // We can now retrieve the label.
}
```

Now that you know that the shipment has successfully been registered. You can retrieve the label through the API. You can find more information about files [here](/php-sdk/retrieving-resources/#files).

```php
// Get the file resource that are of type label from the shipment.
$labels = $shipment->getFiles(File::DOCUMENT_TYPE_LABEL);
```

If the shipment is trackable, it wil also have a tracking code and a tracking url set.

```php
$trackingCode = $shipment->getTrackingCode();
$trackingUrl = $shipment->getTrackingUrl();
```

## Handing over the parcel to the carrier
Depending on what service (or service option) was chosen, you either need to drop the parcel off at one of the carrier's location or the carrier will come and collect the parcel. After you've done that, the status will be tracked by the MyParcel.com API so you can keep track of your shipments.
