+++
title = "Reports"
description = "Reports you have generated, containing shipments matching the passed filters."
weight = 15
+++

Reports are user generated collections of their shipments, generated based on a set of filters.

## Report

{{< icon fa-file-text-o >}}[API specification](https://api-specification.myparcel.com/#tag/Reports)

Attribute  | Type    | Description
---------- | ------- | -----------
name       | string  | User defined name to identify the report,
filters    | object  | List of filter criteria to determine the shipments represented in the CSV. Required properties are `date_from` and `date_to`.
created_at | integer | Unix timestamp when the report was created.

Relationship | Type                                 | Description
------------ | ------------------------------------ | -----------
status       | [statuses](/api/resources/statuses/) | Our generic status indicating if the report has been completed.
file         | [files](/api/resources/files/)       | The CSV file once it is available.

### Report statuses

Status code          | Description
-------------------- | -----------
`report-queued`      | The initial status of a report.
`report-in-progress` | The CSV file is currently being created.
`report-finished`    | The CSV file is available.
`report-failed`      | An error has occurred.

{{% notice note %}}
Only reports with the status `report-finished` or `report-failed` can be deleted.
{{% /notice %}}
