+++
title = "Delivery Plugin"
weight = 3
+++

The Delivery Plugin lets you easily integrate a popup into your website that allows your users to choose a pick-up or drop-off location near them.

## Example project
If you would prefer to learn from example, we made an example project that implemented the plugin using our [PHP-SDK](/php-sdk) to retrieve the locations. The example is also heavily commented. You can find it [here](https://github.com/MyParcelCOM/delivery-plugin-example).

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


```javascript
var initialLocation = {
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
pickup location is original object. You can add stuff...

```javascript
var settings = {
  google_maps_key: 'your-google-maps-key',
  onSuccessCallback: function(pickupLocation) {
    // Do something with the chosen pickupLocation...
  },
  onCancelCallback: function() {
    // Do something when picking the location is cancelled...
  },
  retrievePickupLocationsCallback: function(countryCode, postalCode) {
    // Use the country code and postal code to retrieve pickup locations from our API...
    // This method must return a Promise.
  }
}
```

## Support
Do not hesitate to contact us if you have any further questions or feedback about our plugin. We would love to hear from you. You can get in touch [here](https://myparcel.com/contact).
