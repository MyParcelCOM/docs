+++
title = "Files"
description = "PDF labels and other file resources returned by the carriers."
weight = 8
+++

A file resource can represent all kinds of files like shipment labels, available in different file formats.

## File

{{< icon fa-file-text-o >}}[API specification](https://api-specification.myparcel.com/#tag/Files)

Attribute     | Description
------------- | -----------
document_type | Category the file belongs to, for example label or invoice.
formats       | List of [Format](/api/resources/files/format) objects holding the extension and mime type in which the file is available.

### Format
If you request a file using the default `Accept` header `application/vnd.api+json`, you will get a list of the supported formats of that file. This list can contain the following mime types:

- `application/pdf`
- `application/zpl`
- `image/png`
- `text/csv`

## Retrieve a file in a specific format

{{< icon fa-file-text-o >}}[GET /files/{file_id}](https://api-specification.myparcel.com/#tag/Files/paths/~1files~1{file_id}/get)

Use one of the available formats in the `Accept` header to retrieve the actual file as binary data. For example:

```http
GET /files/a9e3852c-b8b2-4066-a32a-651ea661ba30 HTTP/1.1
Accept: application/pdf
```

The response will be of the same mime type and contain the raw file data.

```http
HTTP/1.1 200 OK
Content-Type: application/pdf

%PDF-1.4 [...] %%EOF
```
