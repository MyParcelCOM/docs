+++
title = "Files"
weight = 5
+++

<em class="fa fa-fw fa-file-text-o"></em>[API specification](https://docs.myparcel.com/api-specification#/Files)

A file resource can represent all kind of file like `labels`, `barcodes`, or `logos` that can all be be available in multiple file formats. 

## Types
If you call the file with the default file type `application/vnd.api+json` you will get a list of the supported file types for that file in the formats attribute.
This list can contain the following file types:

* application/vnd.api+json
* application/pdf
* image/png
* image/jpeg

If you call the [/files](https://docs.myparcel.com/api-specification#/Files/get_files__file_id_) endpoint with any of the other file types the response wil be in that format.

## Retrieving a file
To get all specific files call the [GET /files/{file_id}](https://docs.myparcel.com/api-specification#/Files/get_files__file_id_) endpoint.

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
