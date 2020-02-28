[![Secret-shield enabled](https://github.com/mapbox/secret-shield/blob/assets/secret-shield-enabled-badge.svg)](https://github.com/mapbox/secret-shield/blob/master/docs/enabledBadge.md)

# Mapbox Vision SDK Examples

Example application showing usage of [Mapbox Vision SDK](https://vision.mapbox.com/).

## Dependencies

To install dependencies, first, install [brew](https://brew.sh). Then run the following commands:
1. `brew install SwiftGen` (6.0 or later)
1. `brew install carthage` (0.33.0 or later)

## Tokens
In order to fetch and use Vision SDK, you will need to obtain two tokens at [tokens page in your Mapbox account](https://account.mapbox.com/access-tokens/create/).

Make sure you have Mapbox account. If you don't, you have to sign up.

Create 2 tokens:
1. **Public token:** which should include the `vision:read` scope.
1. **Secret token:** whoch should include the `vision:download` scope.

## Installation
1. `git clone https://github.com/mapbox/vision-ios-examples.git` - clone the repository.
1. `cd vision-ios-examples` - navigate into the repo's root dir.
1. Edit `Cartfile` file and uncomment two lines concerning Vision:
	- `binary "https://api.mapbox.com/downloads/...`
	- `github "mapbox/mapbox-vision-ios"...`
1. Put your *private* token into a `~/.netrc` file.
#1. Put your *private* token instead of `<ADD-TOKEN-HERE>` in `Cartfile`
1. `carthage update --platform ios`
1. `open demo.xcodeproj`
1. Put your *public* token into the value of the `MGLMapboxAccessToken` key within the `Info.plist` file
1. Run the application

## Contribution

We use [secret-shield](https://github.com/mapbox/secret-shield) tool which runs as a pre-commit hook. In order to enable it you should install it with:
```sh
npm install -g @mapbox/secret-shield
```

Then you have to add a pre-commit git hook. The simplest option is to copy the following script into a `vision-ios-examples/.git/hooks/pre-commit`:
```sh
#!/bin/sh
secret-shield --pre-commit -C verydeep --enable "Mapbox Public Key" --disable "High-entropy base64 string" "Short high-entropy string" "Long high-entropy string"
```

Don't forget to make it executable:
```sh
chmod +x .git/hooks/pre-commit
```

As an option you can Integrate hook via git hooks manager (like [Husky](https://github.com/typicode/husky) or [Komondor](https://github.com/shibapm/Komondor)).
More information about installation is available [here](https://github.com/mapbox/secret-shield#install).
