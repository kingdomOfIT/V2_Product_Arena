import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class MobileAuth with ChangeNotifier {
  Future<void> _configureAmplify() async {
    try {
      // amplify plugins

      final apiPlugin = AmplifyAPI();
      final authPlugin = AmplifyAuthCognito();

      // add Amplify plugins
      await Amplify.addPlugins([apiPlugin, authPlugin]);

      // await Amplify.configure(amplifyconfig);
    } catch (e) {}
  }
}
