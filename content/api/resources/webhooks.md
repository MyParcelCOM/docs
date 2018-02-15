+++
title = "Webhooks"
weight = 20
+++

<em class="fa fa-fw fa-file-text-o"></em>[API specification](https://docs.myparcel.com/api-specification#/Webhooks)

Webhooks are triggers that listen to a specified events on the api. Every webhook can listen to a diverged event described in the webhook description. You can subscribe to the webhook with the [webhook subscription](/api/resources/webhook-subscriptions/) so that if the listener detects the event the updated data will be sent to the by you provided callback `url`.
