+++
title = "Retrieve shipment files"
weight = 3
+++

Before you can hand your shipment over to the carrier, the parcel must be provided with a label. In some cases customs documents should also be provided for passing customs. This section explains how to retrieve the available files and write them to your local file system.

## Prerequisites

{{% notice warning %}}
Files are only available when a shipment is **successfully registered** with the carrier. Make sure to verify this before requesting any shipment files.<br>
{{% /notice %}}

#### Shipment registration

Before you can retrieve files for your shipment, it first needs to be [registered with the carrier](/api/create-a-shipment/#registering-your-shipment-with-the-carrier) that will ship the parcel. The MyParcel.com API can then retrieve and create the necessary files for you.

#### Registered or registration failed

Registering a shipment with a carrier happens in a background process in the API and can take a few seconds to complete.
After the API process is done registering a shipment, the shipment will be updated with a new status:

- `shipment-registered` if the carrier accepted the shipment and returned a label. Files and optionally a tracking code are available (provided that the chosen service provides tracking).
- `shipment-registration-failed` if the carrier did not accept the shipment. No files will be available and the reason for failing registration will be mentioned in the errors attached to the shipment-status.

There are two ways to be informed about this new status:

Method               | Description | Documentation
-------------------- | ----------- | -------------
Webhooks (preferred) | **Our system** will notify **your system** as soon as the status is changed. | [Create a webhook](/api/create-a-webhook)
Polling              | **Your system** should retrieve the shipment statuses from **our system**<br>and retry this (after waiting 1 second) if the status is not yet updated. | [Retrieve current status](/api/retrieve-shipment-statuses/#current-status)

{{% notice warning %}}
In some exceptional cases, the status of a shipment will not change from `shipment-concept` to either `shipment-registered` or `shipment-registration-failed`, but rather stay `shipment-concept`. 
This is the result of an internal error (or external in case the carrier's services are not available). 
Our team will get notified of when this happens and try and resolve the issue as soon as possible.
{{% /notice %}}


## Retrieving available files

Before you can download a file, you should check what files are available for the given shipment. To request the files, send a `GET` request to `/shipments/{shipment_id}/files`.

{{% notice note %}}
To request shipment files, you need the `shipments.manage` scope.
{{% /notice %}}

```http
GET /shipments/c41f6c38-d55b-41fb-9f74-096f92e41b13/files HTTP/1.1
```

Will give a response that looks like:

```http
HTTP/1.1 200 OK
Content-Type: application/vnd.api+json

{
  "data": [
    {
      "id": "dd42199a-4553-4b6c-a40a-55000269998d",
      "type": "files",
      "attributes": {
        "document_type": "label",
        "formats": [
          {
            "extension": "pdf",
            "mime_type": "application/pdf"
          }
        ]
      },
      "links": {
        "self": "https://sandbox-api.myparcel.com/files/dd42199a-4553-4b6c-a40a-55000269998d"
      }
    }
  ]
}
```

The data of the response contains an array of available files, with each file specifying an array of formats in which the file is available. 
In this case there is one file with a `document_type` of `label` and it is only available in the format `pdf`.

#### Available Files

These are the files you can regularly expect on a shipment:

| File                       | Description                                                                   |
|----------------------------|-------------------------------------------------------------------------------|
| `label`                    | The shipping label.                                                           |
| `customs-declaration-form` | A customs declaration form generated based on your shipment information.      |
| `commercial-invoice`       | A commercial invoice required for customs, based on your shipment information.|

{{% attachments title="Example files" pattern=".*" %}}

## Downloading the file

To download a file, simply send a `GET` request to the corresponding `files` endpoint. You can use the `self` link of the previous request for easy access.

The request should contain an `Accept` header for the `format` in which you want to receive the file. To download the above label in pdf, you would do the following request:

```http
GET https://sandbox-api.myparcel.com/files/dd42199a-4553-4b6c-a40a-55000269998d HTTP/1.1
Accept: application/pdf
```

Which gives the following response:

```http
HTTP/1.1 200 OK
Content-Disposition: attachment; filename="download.pdf"
Content-Type: application/pdf

data:application/pdf;base64,iVBORw0KGgoAAAANSUhEUgAAAIAAAACA...
```

You can then store the file wherever you want. If you would like to serve the file directly to the user, check out [this](https://stackoverflow.com/questions/3665115/create-a-file-in-memory-for-user-to-download-not-through-server) StackOverflow thread for inspiration.
