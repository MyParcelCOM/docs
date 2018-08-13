+++
title = "Retrieve shipment files"
weight = 3
+++

Before you can hand your shipment over to the carrier, the parcel must be provided with a label. In some cases even documents required for passing customs. This section explains how to retrieve the available files and write them to your local file system.

## Shipment registration required

Before being able to provide you with files for your shipment, it first needs to be registered with the carrier that will ship the parcel. This allows us to retrieve or create the necessary files for you. Shipments that were just registered have a status with the code `shipment_registered`. But all shipments with a status that has the level `success` should have any necessary files available.

You can learn more about [retrieving shipment statuses](#todo) and [registering a shipment](#todo) at their corresponding sections.

## Retrieving available files

Before you can download a file, you should check what files are available for the given shipment. To request the files, send a `GET` request to `/v1/shipments/[shipment-id]/files`. For example:

A `GET` request to `https://api.myparcel.com/v1/shipments/c41f6c38-d55b-41fb-9f74-096f92e41b13/files`.
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
                "self": "https://api.myparcel.com/v1/files/dd42199a-4553-4b6c-a40a-55000269998d"
            }
        }
    ]
}
```

The data of the response contains and array of available files. With each file specifying an array of formats in which the file is available. In this case there is one file with a `document_type` of `label` and one format for `pdf`.

#### Available Files

These are the files you can regularly expect on a shipment:

| File                       | Description                                                                   |
|----------------------------|-------------------------------------------------------------------------------|
| `label`                    | The shipping label.                                                           |
| `customs-declaration-form` | A customs declaration form generated based on your shipment information.      |
| `commercial-invoice`       | A commercial invoice required for customs based on your shipment information. |

{{% attachments title="Example files" pattern=".*" %}}

## Downloading the file

To download a file, simply send a `GET` request to the corresponding `files` endpoint. You can use the `self` link of the previous request for easy access.

The request should contain an `Accept` header for the `format` in which you want to receive the file. For downloading the above label in pdf, you would do the following request:

```http
GET https://api.myparcel.com/v1/files/dd42199a-4553-4b6c-a40a-55000269998d HTTP/1.1
Accept: application/pdf
```

Gives the following response:

```http
HTTP/1.1 200 OK
Content-Disposition: attachment; filename="download.pdf"
Content-Type: application/pdf

data:application/pdf;base64,iVBORw0KGgoAAAANSUhEUgAAAIAAAACA...
```

You can then store the file wherever you want. If you would like to serve the file directly to the user, check out [this](https://stackoverflow.com/questions/3665115/create-a-file-in-memory-for-user-to-download-not-through-server) StackOverflow thread for inspiration.
