+++
title = "Price calculator"
weight = 3
+++

When deciding on what service and contract to use, a big deciding factor is the price. The price of a shipment is usually composed of 3 parts: the weight of the shipment, the chosen insurance amount and the selected service options.

We've created the `PriceCalculator` class to calculate the price of the shipment based on these parameters. When using this class you need to pass in a shipment and a service contract.

```php
use MyParcelCom\ApiSdk\Shipments\PriceCalculator;

$calculator = new PriceCalculator();

// Calculate the price for given service contract.
$price = $calculator->calculate($shipment, $serviceContract);
```
