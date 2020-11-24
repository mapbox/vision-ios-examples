[![Secret-shield enabled](https://github.com/mapbox/secret-shield/blob/assets/secret-shield-enabled-badge.svg)](https://github.com/mapbox/secret-shield/blob/master/docs/enabledBadge.md)

# Mapbox Vision SDK Examples

Example application showing usage of [Mapbox Vision SDK](https://vision.mapbox.com/).

## Dependencies
1. `brew install SwiftGen` (6.0 or later)
1. `brew install carthage` (0.36.0 or later)

## Tokens
In order to fetch and use Vision SDK, you will need to obtain two tokens at [tokens page in your Mapbox account](https://account.mapbox.com/access-tokens/create/):
1. **Public token:** create a token that includes the `vision:read` scope
1. **Secret token:** create another one with the `vision:download` and `downloads:read` scopes

In order to use your secret token, you will need to store it a [.netrc](https://www.gnu.org/software/inetutils/manual/html_node/The-_002enetrc-file.html) file in your home directory. Depending on your environment, you may have this file already, so check first before creating a new one.

To set up the credentials required to download the SDK, add the following entry to your .netrc file:
```
machine api.mapbox.com 
login mapbox
password <INSERT API TOKEN>
```

You'll also need your secret token while editing `Cartfile` during installation.

## Installation
1. `git clone https://github.com/mapbox/vision-ios-examples.git`
1. `cd vision-ios-examples`
1. Open `Cartfile` and uncomment two lines concerning Vision:
	- `binary "https://api.mapbox.com/downloads/...`
	- `github "mapbox/mapbox-vision-ios"...`
1. Put your *secret* token instead of `<ADD-TOKEN-HERE>` in `Cartfile`
1. `carthage update --platform ios --use-netrc`
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
