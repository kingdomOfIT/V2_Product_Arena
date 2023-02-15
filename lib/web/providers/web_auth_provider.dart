// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously, prefer_const_constructors, unused_local_variable, empty_catches

import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:v2_product_arena/amplifyconfiguration.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_verification_screen.dart';
import '../features/auth/widgets/loading_spinner.dart';
import '../features/onboarding/screens/web_onboarding_screen.dart';

class WebAuth with ChangeNotifier {
  String errorTextOTP = '';
  bool isOTPerror = false;
  String errorText = '';
  String userEmail = '';
  bool isSignUpComplete = false;
  bool isLoading = false;

  bool isNameError = false;
  bool isSurnameError = false;
  bool isBirthDateError = false;
  bool isCityError = false;
  bool isPhoneNumError = false;
  bool isEmailError = false;
  bool isPasswordError = false;

  Future<void> _configureAmplify() async {
    try {
      // amplify plugins

      final apiPlugin = AmplifyAPI();
      final authPlugin = AmplifyAuthCognito();

      // add Amplify plugins
      await Amplify.addPlugins([apiPlugin, authPlugin]);

      await Amplify.configure(amplifyconfig);
    } catch (e) {}
  }

  Future<void> signUpUser(
    String name,
    String surname,
    String birthDate,
    String city,
    String status,
    String phone,
    String email,
    String password,
    BuildContext context,
    String routeName,
  ) async {
    await _configureAmplify();

    try {
      final userAttributes = <CognitoUserAttributeKey, String>{
        CognitoUserAttributeKey.email: email,
        CognitoUserAttributeKey.phoneNumber: phone,
        CognitoUserAttributeKey.givenName: name,
        CognitoUserAttributeKey.familyName: surname,
        CognitoUserAttributeKey.address: city,
        CognitoUserAttributeKey.birthdate: birthDate,
        CognitoUserAttributeKey.custom("status"): status,
      };
      final result = await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: CognitoSignUpOptions(userAttributes: userAttributes),
      );
      isSignUpComplete = result.isSignUpComplete;
      // // //Loading icon
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       return Center(
      //         child: Loader(),
      //       );
      //     });
      // // //////////////
      Navigator.of(context).pushNamed(SignupConfirmation.routeName);
    } on AuthException catch (e) {
      safePrint(e.message);
      errorText = e.message;
    }
    notifyListeners();
    // Navigator.of(context).pushReplacementNamed('/confirmation');
  }

  Future<void> confirmUser(
    String email,
    String confirmationCode,
    BuildContext context,
    String routeName,
  ) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
          username: email, confirmationCode: confirmationCode);

      Navigator.of(context).pushReplacementNamed(WebOnboardingView.routeName);
    } on AuthException catch (e) {
      safePrint(e.message);
      errorTextOTP = e.message;
      if (errorTextOTP.isNotEmpty) {
        isOTPerror = true;
        notifyListeners();
      }
    }
  }
}
