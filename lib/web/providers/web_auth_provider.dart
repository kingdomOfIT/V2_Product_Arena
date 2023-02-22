// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously, prefer_const_constructors, unused_local_variable, empty_catches, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:v2_product_arena/amplifyconfiguration.dart';

class WebAuth with ChangeNotifier {
  String errorTextOTP = '';
  bool isOTPerror = false;
  String errorText = '';
  String userEmail = '';
  String userPassword = '';
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
      // // //Loading icon
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       return Center(
      //         child: Loader(),
      //       );
      //     });
      // // //////////////
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

      Navigator.of(context).pushNamed(routeName);
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
    } on AuthException catch (e) {
      safePrint(e.message);
      errorTextOTP = e.message;
      if (errorTextOTP.isNotEmpty) {
        isOTPerror = true;
        notifyListeners();
      }
    }
  }

///////////////////////////////GETTING LECTURES/////////////////////////////////////

  Future<void> getUserLectures() async {
    try {
      final restOperation = Amplify.API.get('/getLectures',
          apiName: 'getUserLecturesAlfa',
          queryParameters: {
            'paDate': 'Feb2023'
            // , 'name': 'Flutter widgets'
          });
      final response = await restOperation.response;
      Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());

      List temp = [];
      responseMap['lectures'].forEach((lecture) {
        temp.addAll(lecture['roles']);
      });
      Set<String> set = Set<String>.from(temp);
      List<String> roles = set.toList();
      print(roles);

      print('GET call succeeded: ${responseMap['lectures']}');
    } on ApiException catch (e) {
      print('GET call failed: $e');
    }
  }
}
