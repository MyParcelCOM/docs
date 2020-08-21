+++
title = "Price calculator"
weight = 3
+++

When deciding on what service to use, a big deciding factor is the price. The price of a shipment is determined by the weight of the shipment, the chosen service and the selected service options.

We've created the `PriceCalculator` class to calculate the price of the shipment based on these parameters. By passing in a valid shipment to the `calculate()` method, the price calculator will return the price of the shipment.

```php
use MyParcelCom\ApiSdk\Shipments\PriceCalculator;

$calculator = new PriceCalculator();

// Calculate the price for your shipment.
// This requires the shipment to have a valid weight set.
$price = $calculator->calculate($shipment);
```

Alternatively, it is also possible to calculate the price of a shipment with a specific service rate by passing in the service rate as second parameter in the `calculate()` method.

```php
$price = $calculator->calculate($shipment, $serviceRate);
```

{{% notice warning %}}
If the shipment contains service options that are not available in the specified service rate, the price calculator will throw a `MyParcelCom\ApiSdk\Exceptions\CalculationException`.
{{% /notice %}}

{{% notice warning %}}
If the service rate of the shipment itself or the service rate in the second parameter has a price amount of `null` the price calculator will also return `null`.
{{% /notice %}}

{{% notice warning %}}
If one of the options of the shipment has a price amount of `null` the price calculator will also return `null`, because in that case it cannot calculate the correct total price.
{{% /notice %}}
