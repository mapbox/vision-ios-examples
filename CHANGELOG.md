# Changelog

## 1.0-28

- `MapboxVision` v0.10.0
- Added detection of construction cones
- General bugfixes
- Improved quality of detection/segmentation, especially at night
- Improved segmentation, now it's more focused on road specific elements. New segmentation model recognizes the following classes: Crosswalk, Hood, MarkupDashed, MarkupDouble, MarkupOther, MarkupSolid, Other, Road, RoadEdge, Sidewalk

## 1.0-27

- `MapboxVision` v0.9.0
- Improved and refined AR navigation experience
- Fixed video frame scaling issue in AR navigation mode

## 1.0-25

- `MapboxVision` v0.8.0

## 1.0-24

- `MapboxVision` v0.7.0
- Improved lane detection

## 1.0-23

- `MapboxVision` v0.6.0
- Fixed crash on showing info
- Removed portrait mode for iPad

## 1.0-22

- Changed handling of `NavigationService` with its rerouting, etc. events, it's moved out of `MapboxVisionAR` module, now it is in `ARContainerViewController`
- Added support for UK(EU) signs
- Changed welcome message and links to Terms of Service and Privacy Policy
- Added MapboxNavigation and MapboxDirections dependencies
- Updated assets for Chinese signs

## 1.0-21

- Added support for Swift 4.2
- Removed usages of `LaneDepartureState`
