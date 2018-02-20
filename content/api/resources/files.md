+++
title = "Files"
description = "PDF labels and other file resources returned by the carriers."
weight = 5
+++

{{< icon fa-file-text-o >}}[API specification](https://docs.myparcel.com/api-specification#/Files)

A file resource can represent all kinds of files like `labels`, `barcodes`, or `logos` that can be available in different file formats.

## Types
If you request a file using the default file type `application/vnd.api+json` as Accept header, you will get a list of the supported mime types for that file. This list can contain the following mime types:

- application/vnd.api+json
- application/pdf
- image/png
- image/jpeg

## Retrieving a file
To get a specific file call the [GET /files/{file_id}](https://docs.myparcel.com/api-specification#/Files/get_files__file_id_) endpoint.

#### Sample request
```http
GET /files/[file-id] HTTP/1.1
Content-Type: application/vnd.api+json
```

#### Sample response
```http
HTTP/1.1 200 OK
Content-Type: application/vnd.api+json

{
  "data": {
    "type": "files",
    "id": "[file-id]",
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
      "self": "/files/[file-id]"
    }
  }
}
```
