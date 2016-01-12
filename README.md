# React Native Passcode Auth

[![npm version](https://img.shields.io/npm/v/react-native-passcode-auth.svg?style=flat-square)](https://www.npmjs.com/package/react-native-passcode-auth)
[![npm downloads](https://img.shields.io/npm/dm/react-native-passcode-auth.svg?style=flat-square)](https://www.npmjs.com/package/react-native-passcode-auth)

React Native Passcode Auth is a [React Native](http://facebook.github.io/react-native/) library for authenticating users with iOS Passcode.  It is an excellent fallback for when [Touch ID](https://github.com/naoufal/react-native-touch-id) is not available.

![react-native-passcode-auth](https://cloud.githubusercontent.com/assets/1627824/12255178/ed7b46e2-b8be-11e5-8552-f7b60959b43c.gif)

## Documentation
- [Install](https://github.com/naoufal/react-native-passcode-auth#install)
- [Usage](https://github.com/naoufal/react-native-passcode-auth#usage)
- [Example](https://github.com/naoufal/react-native-passcode-auth#example)
- [Methods](https://github.com/naoufal/react-native-passcode-auth#methods)
- [Errors](https://github.com/naoufal/react-native-passcode-auth#errors)
- [License](https://github.com/naoufal/react-native-passcode-auth#license)

## Install
React Native Passcode Auth __requires iOS 9.0 or later__.

```shell
npm i --save react-native-passcode-auth
```

## Usage
### Linking the Library
In order to use Passcode Auth, you must first link the library to your project.  There's excellent documentation on how to do this in the [React Native Docs](http://facebook.github.io/react-native/docs/linking-libraries-ios.html#content).

### Requesting Passcode Authentication
Once you've linked the library, you'll want to make it available to your app by requiring it:

```js
import PasscodeAuth from 'react-native-passcode-auth';
```

Requesting Passcode authentication is as simple as calling:
```js
PasscodeAuth.authenticate('to demo this react-native component')
  .then(success => {
    // Success code
  })
  .catch(error => {
    // Failure code
  });
```

## Example
Using PasscodeAuth in your app will usually look like this:
```js
import React, { Component, AlertIOS, TouchableHighlight, View, Text } from 'react-native';
import PasscodeAuth form 'react-native-passcode-auth';

class YourComponent extends Component {
  _pressHandler() {
    PasscodeAuth.authenticate('to demo this react-native component')
      .then(success => {
        AlertIOS.alert('Authenticated Successfully');
      })
      .catch(error => {
        AlertIOS.alert('Authentication Failed');
      });
  }

  render() {
    return (
      <View>
        ...
        <TouchableHighlight onPress={this._pressHandler}>
          <Text>
            Authenticate with Passcode
          </Text>
        </TouchableHighlight>
      </View>
    );
  }
});
```

## Methods
### authenticate(reason)
Attempts to authenticate with Passcode.
Returns a `Promise` object.

__Arguments__
- `reason` - An _optional_ `String` that provides a clear reason for requesting authentication.

__Examples__
```js
PasscodeAuth.authenticate('to demo this react-native component')
  .then(success => {
    // Success code
    console.log('User authenticated with Passcode');
  })
  .catch(error => {
    // Failure code
    console.log(error);
  });
```

### isSupported()
Verify's that Passcode Auth is supported and that Passcode is set.
Returns a `Promise` object.

__Examples__
```js
PasscodeAuth.isSupported()
  .then(supported => {
    // Success code
    console.log('Passcode Auth is supported.');
  })
  .catch(error => {
    // Failure code
    console.log(error);
  });
```

## Errors
There are various reasons why authenticating with Passcode may fail.  Whenever calling Passcode authentication fails, `PasscodeAuth.authenticate` will return an error code representing the reason.

Below is a list of error codes that can be returned:

| Code | Description |
|---|---|
| `LAErrorAuthenticationFailed` | Authentication was not successful because the user failed to provide valid credentials. |
| `LAErrorUserCancel` | Authentication was canceled by the user—for example, the user tapped Cancel in the dialog. |
| `LAErrorUserFallback` | Authentication was canceled because the user tapped the fallback button (Enter Password). |
| `LAErrorSystemCancel` | Authentication was canceled by system—for example, if another application came to foreground while the authentication dialog was up. |
| `LAErrorPasscodeNotSet` | Authentication could not start because the passcode is not set on the device. |
| `PasscodeAuthNotSet` | Authentication could not start because the passcode is not set on the device. |
| `PasscodeAuthNotSupported` | Device does not support Passcode Auth. |

_More information on errors can be found in [Apple's Documentation](https://developer.apple.com/library/prerelease/ios/documentation/LocalAuthentication/Reference/LAContext_Class/index.html#//apple_ref/c/tdef/LAError)._

## License
Copyright (c) 2015, [Naoufal Kadhom](http://naoufal.com/)

Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted, provided that the above copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
