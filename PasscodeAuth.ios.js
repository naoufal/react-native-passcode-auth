/**
 * @providesModule Passcode
 * @flow
 */
'use strict';

var React = require('react-native');
var {
  NativeModules
} = React;

var NativePasscodeAuth = NativeModules.PasscodeAuth;

/**
 * High-level docs for the Passcode iOS API can be written here.
 */

var PasscodeAuth = {
  isSupported() {
    return new Promise(function(resolve, reject) {
      NativePasscodeAuth.isSupported(function(error) {
        if (error) {
          return reject(createError(error.message));
        }

        resolve(true);
      });
    });
  },

  authenticate(reason) {
    var authReason;

    // Set auth reason
    if (reason) {
      authReason = reason;
    // Set as empty string if no reason is passed
    } else {
      authReason = ' ';
    }

    return new Promise(function(resolve, reject) {
      NativePasscodeAuth.authenticate(authReason, function(error) {
        // Return error if rejected
        if (error) {
          return reject(createError(error.message));
        }

        resolve(true);
      });
    });
  }
};

function createError(error) {
  return new Error(error);
}

module.exports = PasscodeAuth;
