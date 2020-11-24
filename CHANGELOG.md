# Changelog

## 1.0-37

- `MapboxVision` v0.13.2
- `MapboxNavigation` v0.40.0

## 1.0-36

- `MapboxVision` v0.13.1
- Fix crash on devices running iOS 14 beta

## 1.0-35

The latest version of the Vision Teaser brings automatic camera recalibration and improvements in lane detection. The full list of changes:

- `MapboxVision` v0.13.0
- Improve lane detection
- Stop sending some inaccurate events until the camera is calibrated
- Introduce automatic camera recalibration
- Expand Japan region to include Okinawa
- Fix bug with speed estimation when a vehicle is stopped
- Fix bug that prevented new China users authorization

## 1.0-32

The latest version of the Vision Teaser includes improvements in algorithm performance, camera calibration process, and lane detection accuracy. The new version contains new improved ML-models for CV tasks like detection, segmentation, and classification. The full list of changes:

- `MapboxVision` v0.12.0
- Added detection of Japanese traffic signs
- Improved lanes detection algorithm
- Improved camera calibration algorithm
- Utilized new ML models that reduce resource consumption

## 1.0-31

The latest version of the Vision Teaser includes numerous improvements to the AR Navigation experience, including improved detection of the vehicle’s current lane (ego lane), improved rendering of vehicle path based on real-time lane segmentation, and faster camera calibration. Vertical “fence-style” AR rendering has been improved, as well as overall performance on the iPhone 11. Finally, various iOS-specific crashes have been fixed.

- `MapboxVision` v0.11.0
- Removed location update in background
- Removed Object Mapping screen

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
