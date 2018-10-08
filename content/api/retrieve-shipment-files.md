+++
title = "Retrieve shipment files"
weight = 3
+++

Before you can hand your shipment over to the carrier, the parcel must be provided with a label. In some cases customs documents should also be provided for passing customs. This section explains how to retrieve the available files and write them to your local file system.

## Shipment registration required

Before you can retrieve files for your shipment, it first needs to be registered with the carrier that will ship the parcel. The MyParcel.com API can then retrieve or create the necessary files for you. Shipments that were just registered have a status with the code `shipment_registered`. But all shipments with a status of level `success` should have any necessary files available.

You can learn more about [retrieving shipment statuses](/api/retrieve-shipment-statuses) and [registering a shipment](/api/create-a-shipment/#registering-your-shipment-with-the-carrier) at their corresponding sections.

## Retrieving available files

Before you can download a file, you should check what files are available for the given shipment. To request the files, send a `GET` request to `/shipments/{shipment_id}/files`.

{{% notice note %}}
To request shipment files, you need either the `shipments.show` or `shipments.manage` scope.
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
        "self": "https://api.myparcel.com/files/dd42199a-4553-4b6c-a40a-55000269998d"
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
GET https://api.myparcel.com/files/dd42199a-4553-4b6c-a40a-55000269998d HTTP/1.1
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
