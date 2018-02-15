+++
title = "Webhook Subscriptions"
weight = 21
+++

<em class="fa fa-fw fa-file-text-o"></em>[API specification](https://docs.myparcel.com/api-specification#/Shops/get_shops__shop_id__webhook_subscriptions)

Webhooks subscriptions are the connections between a [webhook](/api/resources/webhooks/) resource and an provided url in your system. So that if the webhook is called the changed data will be sent to this url.

## Relations
The webhook always has a relation with one [webhook](/api/resources/webhooks/).
