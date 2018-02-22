+++
title = "Webhooks"
description = "The webhooks offered by our API. Shops can be subscribed to push messages upon these events."
weight = 20
+++

Webhooks are triggers that listen to events in our system. A shop can subscribe to a webhook by creating a webhook subscription. When the listener detects an event, the corresponding event data will be sent to the callback url of the subscription.

## Webhook

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/Webhooks)

Attribute   | Description
----------- | -----------
code        | Event code, used in our event handlers.
name        | Event name, useful for displaying to users.
description | Explanation when this event is triggered.

## Webhook subscription

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/Shops/get_shops__shop_id__webhook_subscriptions)

Attribute   | Description
----------- | -----------
url         | Callback URL to receive push messages.
created_at  | Unix timestamp when the subscription was created.

Relationship | Description
------------ | -----------
shop         | Owner of the subscription.
webhook      | Event being watched.
