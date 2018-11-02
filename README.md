# Mapbox Vision SDK Examples

Example application showing usage of [Mapbox Vision SDK](https://vision.mapbox.com/).

## Dependencies
1. `brew install SwiftGen` (6.0 or later)
2. `brew install carthage` (0.31.0 or later)

## Installation
1. `git clone https://github.com/mapbox/vision-ios-examples.git`
1. `cd vision-ios-examples`
1. `carthage bootstrap --platform ios`
1. `open demo.xcodeproj`
1. Sign up or log in to your Mapbox account and grab a [Mapbox access token](https://www.mapbox.com/help/define-access-token/)
1. Enter your Mapbox access token into the value of the `MGLMapboxAccessToken` key within the Info.plist file
1. Run the application
