# defaultmail
Sets the default mail client for mailto links in macOS.

macOS 10.14.3 and earlier will require [Swift Runtime Support](https://support.apple.com/kb/dl1998?locale=en_US).

## Usage
`defaultmail --outlook`

`defaultmail --set org.mozilla.thunderbird`

### Setting the default client
To set the default client you can use one of three arguments:
  - `--reset` which will reset mailto links to using Apple Mail
  - `--outlook` which will set mailto links to using Microsoft Outlook
  - `--set <bundle-id>` which will let you set it to any other mail client you want using its application bundle identifier

### Getting the default client
If you want to see what the app bundle identifier is for the current default application for mailto links you can use the `--get` argument.

## --help
```
OVERVIEW: Sets the default mail client for mailto: links.

USAGE: defaultmail [--get] [--reset] [--outlook] [--set <bundle-id>] [--version]

OPTIONS:
  --get                   Show the default mailto: bundle id.
  --reset                 Sets Apple Mail as the default mailto:.
  --outlook               Sets Microsoft Outlook as the default mailto:.
  -s, --set <bundle-id>   Sets the default mailto: to the provided bundle ID.
  -v, --version           Show the version number.
  -h, --help              Show help information.
```
