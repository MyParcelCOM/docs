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
To create a new shipment, you should create a new instance of a `MyParcelCom\ApiSdk\Resources\Shipment`, set the required properties on the shipment and have it sent to the MyParcel.com API by calling the method `MyParcelCom\ApiSdk\MyParcelComApi::createShipment()`.

The minimal required properties to set on a shipment are a recipient address and a weight. There are however a lot more properties you can (and should) set on the shipment. Some of these are the shop, sender address and service. Whenever these are not set, the SDK will automatically set them for you. The default shop will be chosen and that shop's return address will be used as a sender address. For the service, the cheapest one will be calculated and selected.

This behavior is not a problem for when you only have one shop and don't mind what carrier you use. However, when you have more than one shop, have multiple locations you want to send from or want to select the service to use, you should set (one or more of) these values.

```php
use MyParcelCom\ApiSdk\Resources\Address;
use MyParcelCom\ApiSdk\Resources\Shipment;
use MyParcelCom\ApiSdk\Resources\Interfaces\PhysicalPropertiesInterface;

// Define the sender address.
$sender = new Address();
$sender
    ->setStreet1('Baker Street')
    ->setStreetNumber(221)
    ->setCity('London')
    ->setPostalCode('NW1 6XE')
    ->setCountryCode('GB')
    ->setPhoneNumber('+31 234 567 890')
    ->setCompany('Holmes Investigations');

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
    ->setEmail('s.holmes@holmesinvestigations.com');


// Get your shops from the api.
$shops = $api->getShops();

// Select one of the shops to use.
$myShop = ...

// Prepare your shipment.
$shipment = new Shipment();
$shipment
    ->setSenderAddress($sender)
    ->setRecipientAddress($recipient)
    ->setShop($myShop)
    ->setWeight(500, PhysicalPropertiesInterface::WEIGHT_GRAM);

// Get the available services for this shipment from the API.
$services = $api->getServices($shipment);

// Choose a service and set it on the shipment. 
// You can use the price calculator if you want to base your choice on the price.
$shipment->setService($service);

// Create the shipment.
$createdShipment = $api->createShipment($shipment);
```

Now that you've created a shipment, you should store its id (`$createdShipment->getId()`) somewhere so you can later retrieve any files associated with the shipment and check for status updates.

## Downloading the shipment label
When you create a shipment, it's status will be `shipment_concept`. While the shipment has this status it can be modified. When you are ready to register the shipment with the carrier, you should set the `register_at` property. This can be set into the future if you want to schedule registering the shipment or you can use the current time to register it immediatly. This should normally not take more than a minute, but depending on the carrier, it can take a little bit longer.

```php
// Set register_at to now to have the shipment registered immediately.
$shipment->setRegisterAt(new \DateTime());

// Update the shipment at the api to start registering.
$api->updateShipment($shipment);
```

Once the shipment has been registered at the carrier the status will transition to `shipment_registered`.  To check the status of a shipment you can retrieve the shipment through the API and then retrieve the status.

```php
// Retrieve the shipment id from where you stored it.
$id = ...

// Get the shipment from the api.
$shipment = $api->getShipment($id);

// Get the shipment status.
$shipmentStatus = $shipment->getShipmentStatus();

// This can hold extra data given by the carrier, like the carrier's status code
// description.
$shipmentStatus->setCarrierStatusCode();
$shipmentStatus->getCarrierStatusDescription();

// But most importantly it holds the normalized status.
$status = $shipmentStatus->getStatus();

// Which holds a level, that we can check if it's a pending, success or failed
// type of status. Success meaning that nothing has gone wrong as of yet.
if ($status->getLevel() === 'success') {
    // The shipment has transitioned to a successful state!
    // We can now retrieve the label.
}

// We can also check what the specific status is by retrieving the code.
if ($status->getCode() === 'shipment_registered') {
    // The shipment has been registered with the carrier.
}
```

Now that you know that the shipment has successfully been registered. You can retrieve the label through the API. You can find more information about files [here](/php-SDK/retrieving-resources/#files).

```php
// Get the file resources that are of type label from the shipment.
$labels = $shipment->getFiles(File::DOCUMENT_TYPE_LABEL);
```

If the shipment is trackable, it wil also have a tracking code and a tracking url set.

```php
$trackingCode = $shipment->getTrackingCode();
$trackingUrl = $shipment->getTrackingUrl();
```

## Handing over the parcel to the carrier
Depending on what service (or service option) was chosen, you either need to drop the parcel off at one of the carrier's drop-off location or the carrier will come and collect the parcel at the specified sender address. After you've done that, the status will be tracked by the MyParcel.com API so you can keep track of your shipments.
