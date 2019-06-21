+++
title = "Physical Properties"
description = "Information about the dimensions of the shipment."
weight = 3
+++

Information about the dimensions of the shipment.

## Attributes

| Attribute         | Type    | Description                                                                                     | Required
|------------------ |---------|-------------------------------------------------------------------------------------------------|---------
| weight            | integer | Weight in grams.                                                                                | ✓
| height            | integer | Height in millimeters.                                                                          | 
| width             | integer | Width in millimeters.                                                                           |
| length            | integer | Length in millimeters.                                                                          |
| volume            | float   | Volume in liters. (dm3)                                                                         |
| volumetric_weight | integer | Volumetric weight in grams. This value is calculated by the API and cannot be sent by the user. | 
