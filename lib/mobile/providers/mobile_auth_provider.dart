import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:v2_product_arena/amplifyconfiguration.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/mobile_login_screen.dart';

class MobileAuth with ChangeNotifier {
  String errorText = '';
  String errorTextOTP = '';
  bool isOTPerror = false;
  String userEmail = '';
  String userPassword = '';
  bool isSignUpComplete = false;
  bool isSignInComplete = false;

  bool isLoading = false;
  bool isNameError = false;
  bool isSurnameError = false;
  bool isBirthDateError = false;
  bool isCityError = false;
  bool isPhoneNumError = false;
  bool isEmailError = false;
  bool isPasswordError = false;

  bool isLoginEmailError = false;
  bool isLoginPasswordError = false;

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
        const CognitoUserAttributeKey.custom("status"): status,
      };
      final result = await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: CognitoSignUpOptions(userAttributes: userAttributes),
      );
      isSignUpComplete = result.isSignUpComplete;
      Navigator.of(context).pushReplacementNamed(routeName);
      notifyListeners();
    } on AuthException catch (e) {
      safePrint(e.message);
      errorText = e.message;
    }
    notifyListeners();
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
      Navigator.of(context).pushReplacementNamed(routeName);

      // print(result);

    } on AuthException catch (e) {
      safePrint(e.message);
      errorTextOTP = e.message;
      if (errorTextOTP.isNotEmpty) {
        isOTPerror = true;
        notifyListeners();
      }
    }
  }

  Future<void> signInUser(String username, String password,
      BuildContext context, String routeName) async {
    await _configureAmplify();
    try {
      final result = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );

      isSignInComplete = result.isSignedIn;
      notifyListeners();
      Navigator.of(context).pushReplacementNamed(routeName);
    } on AuthException catch (e) {
      safePrint(e.message);
      errorText = e.message;
    }
    notifyListeners();
  }

  Future<void> signOutCurrentUser(BuildContext context) async {
    try {
      await Amplify.Auth.signOut();
      Navigator.of(context).pushReplacementNamed(MobileLoginScreen.routeName);
    } on AuthException catch (e) {}
    notifyListeners();
  }
}
