+++
title = "Delivery Plugin"
weight = 3
+++

The Delivery Plugin lets you easily integrate a popup into your website that allows your users to choose a pick-up or drop-off location near them.

## Example project
If you would prefer to learn from example, we made an example project that implemented the plugin using our [PHP-SDK](/php-sdk) to retrieve the locations. The example is also heavily commented. You can find it on [GitHub](https://github.com/MyParcelCOM/delivery-plugin-example).

## Setup
The first step in setting up the plugin is including the provided CSS and JavaScript files.

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <!-- head elements... -->
  <link rel="stylesheet" href="/css/mp-delivery.css">
</head>
<body>
  <!-- body elements... -->
  <script src="/js/mp-delivery.js"></script>
</body>
</html>
```

### Google Maps API key
The plugin uses several functions from the Google Maps JavaScript API and thus requires credentials to use their API. You can create your key [here](https://console.cloud.google.com/apis). Make sure both the `Google Maps JavaScript API` and the `Google Maps Geocoding API` are enabled.

### HTML target
When opening, the popup requires an HTML target to replace. This target is a plain HTML element with a chosen id.

```html
<div id="my-delivery-popup-id"></div>
```

### Opening the popup
To open the popup, call the `window.myparcelcom.openDeliveryWindow()` method. It requires the following 3 arguments:

1) The first argument is the id of the html target to open the popup on.
2) The second argument is an object with the initial countryCode and postalCode to open the popup on.
3) The third argument is the settings object for the popup. More on this below. 

```javascript
let initialLocation = {
  countryCode: 'NL',
  postalCode: '2131BC'
}

window.myparcelcom.openDeliveryWindow(
  '#my-delivery-popup-id', 
  initialLocation, 
  settings
)
```

### Settings object
The settings object consists of the following 4 attributes:

#### `google_maps_key`
The key string you received from Google. See this [step](#google-maps-api-key)

#### `retrievePickupLocationsCallback`
**Called**: When the popup is opened. <br>
**Parameters**: The `countryCode` and `postalCode` required to retrieve locations from the API. <br>
**Returns**: A promise that resolves to all available `pickupLocation` objects.

#### `onSuccessCallback`
**Called**: When a pickup location is chosen. <br>
**Parameters**: The original `pickupLocation` that was provided when retrieving pickup locations.

#### `onCancelCallback`
**Called**: When a the popup is closed without choosing a location. <br>
**Parameters**: None.

```javascript
let settings = {
  google_maps_key: 'your-google-maps-key',
  retrievePickupLocationsCallback: function(countryCode, postalCode) {
    // Use the country code and postal code to retrieve pickup locations from our API...
     
    // ...return a Promise
  },
  onSuccessCallback: function(pickupLocation) {
    // Do something with the chosen pickupLocation...
  },
  onCancelCallback: function() {
    // Do something when picking the location is cancelled...
  }
}
```

{{% notice note %}}
The `retrievePickupLocationsCallback` method also works with `async` and `await`. Just make the method `async` to make it resolve to a promise.
{{% /notice %}}

### z-index issues
The popup has a `z-index` value of 1. If you are running into issues because you work with higher z-indices in your project, the popup will not come out on top. To fix this, simply wrap the popup target in a wrapper and apply the following css rules:

```html
<style>
  .delivery-plugin-wrapper {
    position: relative;
    z-index: 0;
  }
</style>

<div class="delivery-plugin-wrapper">
  <div id="my-delivery-popup-id"></div>
</div>
```

## Support
Do not hesitate to contact us if you have any further questions or feedback about our plugin. We would love to hear from you. You can get in touch through our [contact page](https://myparcel.com/contact).
