//
import 'dart:convert';
import 'package:googleapis/youtube/v3.dart';
import 'package:flutter/material.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//import 'package:amplify_datastore/amplify_datastore.dart';

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

  final List _lecture = [];
  final List _lectureVideos = [];
  int numberOfLessons = 0;
  List<String> _roles = [];
  List _lecturesRole1 = [];
  List _lecturesRole2 = [];

  void clearLectures() {
    _lecture.clear();
    notifyListeners();
  }

  void clearRoles() {
    _roles.clear();
    notifyListeners();
  }

  void clearLecture1() {
    _lecturesRole1.clear();
    notifyListeners();
  }

  void clearLecture2() {
    _lecturesRole2.clear();
    notifyListeners();
  }

  List get lecture => _lecture;
  List get lectureVideos => _lectureVideos;
  List get lectureRole1 => _lecturesRole1;
  List get lectureRole2 => _lecturesRole2;
  List<String> get roles => _roles;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isSidebarOpened = false;
  bool get isSidebarOpened => _isSidebarOpened;
  void changeSidebar(bool a) {
    _isSidebarOpened = a;
    notifyListeners();
  }

  bool _isPlayingInFullscr = false;
  bool get isPlayingInFullscr => _isPlayingInFullscr;

  void changePlaying(bool a) {
    _isPlayingInFullscr = a;
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

  String getVideoId(String s) {
    return YoutubePlayer.convertUrlToId(s) as String;
  }

  Future<String?> getDefaultThumbnail(String s) async {
    const apiKey = 'AIzaSyCzk5aj9W2ZNDVQDo-PY34NuKIrLLVMjWA';

    final client = clientViaApiKey(apiKey);
    final youtube = YouTubeApi(client);
    List<String> videoId = [getVideoId(s)];

    final videoListResponse = await youtube.videos.list(
      ['snippet'],
      id: videoId,
    );

    final video = videoListResponse.items![0];
    final thumbnailUrl = video.snippet!.thumbnails!.medium!.url;

    return thumbnailUrl;
  }

  Future<void> getUserLectures() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString('aws_data');
      if (cachedData != null) {
        print('nije prazan');
        Map<String, dynamic> responseMap = jsonDecode(cachedData);
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
          //'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg' ovo probat
          int i;
          for (i = 0; i < _lecturesRole1.length; i++) {
            _lecturesRole1[i]['imageSrc'] =
                await getDefaultThumbnail(_lecturesRole1[i]['contentLink']);
          }
        } else {
          _lecturesRole1 = _lecture
              .where((lecture) => lecture['roles'].contains(_roles[0]))
              .toList();
          int i;
          for (i = 0; i < _lecturesRole1.length; i++) {
            _lecturesRole1[i]['imageSrc'] =
                await getDefaultThumbnail(_lecturesRole1[i]['contentLink']);
          }

          _lecturesRole2 = _lecture
              .where((lecture) => lecture['roles'].contains(_roles[1]))
              .toList();
          for (i = 0; i < _lecturesRole2.length; i++) {
            _lecturesRole2[i]['imageSrc'] =
                await getDefaultThumbnail(_lecturesRole2[i]['contentLink']);
          }
        }
      } else {
        print('prazan');
        final restOperation = Amplify.API.get('/api/user/lectures',
            apiName: 'getLecturesAlfa', queryParameters: {'paDate': 'Feb2023'});
        final response = await restOperation.response;
        Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());

        await prefs.setString('aws_data', jsonEncode(responseMap));

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
          //'https://img.youtube.com/vi/${uri.queryParameters['v']}/0.jpg' ovo probat
          int i;
          for (i = 0; i < _lecturesRole1.length; i++) {
            _lecturesRole1[i]['imageSrc'] =
                await getDefaultThumbnail(_lecturesRole1[i]['contentLink']);
          }
        } else {
          _lecturesRole1 = _lecture
              .where((lecture) => lecture['roles'].contains(_roles[0]))
              .toList();
          int i;
          for (i = 0; i < _lecturesRole1.length; i++) {
            _lecturesRole1[i]['imageSrc'] =
                await getDefaultThumbnail(_lecturesRole1[i]['contentLink']);
          }

          _lecturesRole2 = _lecture
              .where((lecture) => lecture['roles'].contains(_roles[1]))
              .toList();
          for (i = 0; i < _lecturesRole2.length; i++) {
            _lecturesRole2[i]['imageSrc'] =
                await getDefaultThumbnail(_lecturesRole2[i]['contentLink']);
          }
        }
      }
    } on ApiException catch (e) {
      safePrint('GET call failed: $e');
    }
  }
}
