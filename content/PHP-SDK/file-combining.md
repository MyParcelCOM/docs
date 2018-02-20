+++
title = "File combining"
weight = 5
+++

The SDK provides a class for combining files into 1 pdf. Using this you can create a pdf file with multiple labels for printing. The class takes an array of objects that implement `FileInterface` and returns a new object that implements `FileInterface`.

```php
use MyParcelCom\ApiSdk\LabelCombiner;
use MyParcelCom\ApiSdk\Resources\Interfaces\FileInterface;

$files = array_merge(
    $shipmentA->getFiles(FileInterface::RESOURCE_TYPE_LABEL),
    $shipmentB->getFiles(FileInterface::RESOURCE_TYPE_LABEL)
);

$labelCombiner = new LabelCombiner();
$combinedFile = $labelCombiner->combineLabels($files);
```

The page size (A4, A5, A6), the starting position as well as a margin can be specified when combining the labels.

```php
use MyParcelCom\ApiSdk\LabelCombinerInterface;

$combinedFile = $labelCombiner->combineLabels(
    $files,
    LabelCombinerInterface::PAGE_SIZE_A4,
    LabelCombinerInterface::LOCATION_BOTTOM_LEFT,
    20
);
```
