// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously, prefer_const_constructors, unused_local_variable, empty_catches, avoid_print, prefer_final_fields

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:v2_product_arena/amplifyconfiguration.dart';
import 'package:v2_product_arena/web/features/home/models/lecture.dart';

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

  List _lectures = [];
  List _roles = [];

  List get lectures {
    return [..._lectures];
  }

  List get roles {
    return [..._roles];
  }

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

  Future<void> signInUser() async {
    try {
      final result = await Amplify.Auth.signIn(
        username: 'mirza.karic575@gmail.com',
        password: 'Pass123!',
      );
      print('Loginovan');
    } on AuthException catch (e) {
      safePrint(e.message);
    }
    notifyListeners();
  }

  Future<bool> isUserLoggedIn() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();
      return session.isSignedIn;
    } catch (e) {
      print('Error checking authentication status: $e');
      return false;
    }
  }

///////////////////////////////GETTING LECTURES/////////////////////////////////////

  Future<void> getUserLectures() async {
    await signInUser();
    try {
      final restOperation = Amplify.API.get('/api/user/lectures',
          apiName: 'getLecturesAlfa',
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
      _roles = set.toList();

      print(roles);
      var oneLecture;
      responseMap['lectures'].forEach((lecture) {
        oneLecture = lecture;

        _lectures.add(oneLecture);
      });

      print(_lectures[0]['name']);
      // print('GET call succeeded: ${responseMap['lectures'][1]['name']}');
      notifyListeners();
    } on ApiException catch (e) {
      print('GET call failed: $e');
    }
  }

///////////////////////////////GETTING LECTURES ORDER/////////////////////////////////////
  Future<void> getLectureOrder() async {
    await signInUser();
    try {
      final restOperation = Amplify.API.get('/api/lectures/order',
          apiName: 'getLecturesOrder',
          queryParameters: {
            'paDate': 'Feb2023'
            // , 'name': 'Flutter widgets'
          });
      final response = await restOperation.response;
      Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());
      print(
          'GET call succeeded: ${responseMap['lectureOrders']['productManager']}');
      print(jsonEncode(responseMap));
    } on ApiException catch (e) {
      print('GET call failed: ${e.message}');
    }
  }
}
