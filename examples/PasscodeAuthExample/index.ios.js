'use strict';
import React, {
  AlertIOS,
  AppRegistry,
  Component,
  StyleSheet,
  Text,
  TouchableHighlight,
  View
} from 'react-native';

import PasscodeAuth from "react-native-passcode-auth";

class PasscodeAuthExample extends Component {
  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          react-native-passcode-auth
        </Text>

        <Text style={styles.instructions}>
          github.com/naoufal/react-native-passcode-auth
        </Text>
        <TouchableHighlight
          style={styles.btn}
          onPress={this._clickHandler}
          underlayColor="#0380BE"
          activeOpacity={1}
        >
          <Text style={{
            color: '#fff',
            fontWeight: '600'
          }}>
            Authenticate with Passcode
          </Text>
        </TouchableHighlight>
      </View>
    );
  }

  _clickHandler() {
    PasscodeAuth.isSupported()
      .then(authenticate)
      .catch(error => {
        AlertIOS.alert(error.message);
      });
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF'
  },
  welcome: {
    margin: 10,
    fontSize: 20,
    fontWeight: '600',
    textAlign: 'center'
  },
  instructions: {
    marginBottom: 5,
    color: '#333333',
    fontSize: 13,
    textAlign: 'center'
  },
  btn: {
    borderRadius: 3,
    marginTop: 200,
    paddingTop: 15,
    paddingBottom: 15,
    paddingLeft: 15,
    paddingRight: 15,
    backgroundColor: '#0391D7'
  }
});

function authenticate() {
  return PasscodeAuth.authenticate("To demo this module")
    .then((success) => {
      AlertIOS.alert('Authenticated Successfully');
    })
    .catch((error) => {
      console.log(error)
      AlertIOS.alert(error.message);
    });
}

AppRegistry.registerComponent('PasscodeAuthExample', () => PasscodeAuthExample);
