import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class MobileAuth with ChangeNotifier {
  String errorText = '';
  String errorTextOTP = '';
  String loginErrorText = '';
  bool isOTPerror = false;
  String userEmail = '';
  String userPassword = '';
  bool isSignUpComplete = false;
  bool isSignInComplete = false;
  String userName = '';
  String userSurname = '';
  String emailUser = '';

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

  // Future<void> _configureAmplify() async {
  //   try {
  //     // amplify plugins

  //     final apiPlugin = AmplifyAPI();
  //     final authPlugin = AmplifyAuthCognito();

  //     // add Amplify plugins
  //     await Amplify.addPlugins([apiPlugin, authPlugin]);

  //     await Amplify.configure(amplifyconfig);
  //   } catch (e) {}
  // }
  final List _lecture = [];
  final List _lectureVideos = [];
  int numberOfLessons = 0;
  List<String> _roles = [];
  List _lecturesRole1 = [];
  List _lecturesRole2 = [];

  List get lecture => _lecture;
  List get lectureVideos => _lectureVideos;
  List get lectureRole1 => _lecturesRole1;
  List get lectureRole2 => _lecturesRole2;
  List<String> get roles => _roles;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isSidebarOpened = false;
  bool get isSidebarOpened => _isSidebarOpened;
  void changeSidebar() {
    _isSidebarOpened = !_isSidebarOpened;
    notifyListeners();
  }

  bool _isSidebarOpened1 = false;
  bool get isSidebarOpened1 => _isSidebarOpened1;
  void changeSidebar1() {
    _isSidebarOpened1 = !_isSidebarOpened1;
    notifyListeners();
  }

  bool _isSidebarOpened2 = false;
  bool get isSidebarOpened2 => _isSidebarOpened2;
  void changeSidebar2() {
    _isSidebarOpened2 = !_isSidebarOpened2;
    notifyListeners();
  }

  bool _isSidebarOpened3 = false;
  bool get isSidebarOpened3 => _isSidebarOpened3;
  void changeSidebar3() {
    _isSidebarOpened3 = !_isSidebarOpened3;
    notifyListeners();
  }

  bool isPlayingInFullscr = false;

  void changePlaying() {
    isPlayingInFullscr = !isPlayingInFullscr;
    notifyListeners();
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
    // await _configureAmplify();

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
      // ignore: use_build_context_synchronously
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
      await Amplify.Auth.confirmSignUp(
          username: email, confirmationCode: confirmationCode);
      // ignore: use_build_context_synchronously

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
    // await _configureAmplify();
    try {
      final result = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );

      isSignInComplete = result.isSignedIn;
      notifyListeners();

      safePrint('logged in');
      await getUserLectures();
      // ignore: use_build_context_synchronously
      await fetchCurrentUserAttributes();
      Navigator.of(context).pushReplacementNamed(routeName);
    } on AuthException catch (e) {
      safePrint(e.message);
      loginErrorText = e.message;
    }
    notifyListeners();
  }

  Future<void> signOutCurrentUser() async {
    try {
      await Amplify.Auth.signOut();
    } on AuthException catch (e) {
      safePrint(e);
    }
    notifyListeners();
  }

  Future<void> fetchCurrentUserAttributes() async {
    try {
      final result = await Amplify.Auth.fetchUserAttributes();

      // for (final element in result) {
      //   print('key: ${element.userAttributeKey}; value: ${element.value}');
      // }
      userName = result
          .firstWhere((element) =>
              element.userAttributeKey.toString() ==
              'CognitoUserAttributeKey "given_name"')
          .value;
      userSurname = result
          .firstWhere((element) =>
              element.userAttributeKey.toString() ==
              'CognitoUserAttributeKey "family_name"')
          .value;
      emailUser = result
          .firstWhere((element) =>
              element.userAttributeKey.toString() ==
              'CognitoUserAttributeKey "email"')
          .value;
      safePrint(userName);
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

  Future<void> getUserLectures() async {
    // await signInUser(username, password, context, routeName);

    try {
      final restOperation = Amplify.API.get('/api/user/lectures',
          apiName: 'getLecturesAlfa', queryParameters: {'paDate': 'Feb2023'});
      final response = await restOperation.response;
      Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());

      List temp = [];
      responseMap['lectures'].forEach((lecture) {
        temp.addAll(lecture['roles']);
      });

      Set<String> set = Set<String>.from(temp);
      _roles = set.toList();

      safePrint(_roles);
      var oneLecture;
      responseMap['lectures'].forEach((lecture) {
        oneLecture = lecture;

        _lecture.add(oneLecture);
      });
      if (_roles.length == 1) {
        _lecturesRole1 = _lecture
            .where((lecture) => lecture['roles'].contains(_roles[0]))
            .toList();
      } else {
        _lecturesRole1 = _lecture
            .where((lecture) => lecture['roles'].contains(_roles[0]))
            .toList();

        _lecturesRole2 = _lecture
            .where((lecture) => lecture['roles'].contains(_roles[1]))
            .toList();

        // for (i = 0; i < _lecturesRole2.length; i++) {
        //   for (j = i + 1; j < _lecturesRole2.length; j++) {
        //     if (_lecturesRole2[i]['name'] == _lecturesRole2[j]['name']) {
        //       _lecturesRole2.remove(_lecturesRole2[j]);
        //     }
        //   }
        // }
      }
    } on ApiException catch (e) {
      safePrint('GET call failed: $e');
    }
  }
}
