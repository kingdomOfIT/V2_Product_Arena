import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_email_verifed.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_login_screen.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_signup_screen.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_verification_screen.dart';
import 'package:v2_product_arena/web/features/home/screens/web_contact_screen.dart';
import 'package:v2_product_arena/web/features/home/screens/web_home_screen.dart';
import 'package:v2_product_arena/web/features/home/screens/web_lectures_screen.dart';
import 'package:v2_product_arena/web/features/home/screens/web_lecturevideo_screen.dart';
import 'package:v2_product_arena/web/features/home/screens/web_recent_lectures.dart';
import 'package:v2_product_arena/web/features/onboarding/screens/web_congratulations_screen.dart';
import 'package:v2_product_arena/web/features/onboarding/screens/web_onboarding_screen.dart';
import 'package:v2_product_arena/web/features/onboarding/web_constansts_ob.dart';
import 'package:v2_product_arena/web/features/onboarding/widgets/web_qa_tile.dart';
import 'package:v2_product_arena/web/features/onboarding/widgets/web_vector_tile.dart';
import 'package:v2_product_arena/web/providers/web_auth_provider.dart';
import 'package:v2_product_arena/web/providers/web_ob_answers.dart';
import 'package:v2_product_arena/web/providers/web_ob_error.dart';
import 'package:v2_product_arena/web/providers/web_ob_role.dart';
import 'mobile_auth_provider_test.mocks.dart';
import 'web_mocked_repository.dart';

class MockWebAuth extends WebAuth {}

class MockAuth extends Mock implements AuthCategory {
  @override
  Future<SignUpResult> signUp(
      {required String username,
      required String password,
      SignUpOptions? options}) async {
    var result = MockSignUpResult();
    when(result.isSignUpComplete).thenReturn(true);
    return result;
  }

  @override
  Future<SignUpResult> confirmSignUp(
      {required String username,
      required String confirmationCode,
      ConfirmSignUpOptions? options}) async {
    var result = MockSignUpResult();
    when(result.isSignUpComplete).thenReturn(true);
    return result;
  }

  @override
  Future<SignInResult<AuthUserAttributeKey>> signIn(
      {required String username,
      String? password,
      SignInOptions? options}) async {
    var result = MockSignInResult();
    when(result.isSignedIn).thenReturn(true);
    return result;
  }

  @override
  Future<SignOutResult> signOut({SignOutOptions? options}) async {
    var result = MockSignOutResult();
    when(result.runtimeTypeName).thenReturn('');
    return result;
  }
}

class MockAPI extends Mock implements APICategory {
  @override
  RestOperation post(String path,
      {Map<String, String>? headers,
      HttpPayload? body,
      Map<String, String>? queryParameters,
      String? apiName}) {
    var result = MockRestOperation();
    when(result.response).thenAnswer((_) async {
      return AWSHttpResponse(
        statusCode: 201,
        headers: const {},
        body: Uint8List.fromList([]),
      );
    });
    return result;
  }

  @override
  RestOperation get(String path,
      {Map<String, String>? headers,
      Map<String, String>? queryParameters,
      String? apiName}) {
    var result = MockRestOperation();
    when(result.response).thenAnswer((_) async {
      if (path == '/api/user/lectures') {
        Map<String, dynamic> mockedResponseData = mockedLecturesResponseData;
        return AWSHttpResponse(
          statusCode: 200,
          headers: const {},
          body: Uint8List.fromList(utf8.encode(jsonEncode(mockedResponseData))),
        );
      } else {
        return AWSHttpResponse(
          statusCode: 200,
          headers: const {},
          body: Uint8List.fromList([]),
        );
      }
    });
    return result;
  }
}

late WebAuth webAuthent;
late WebErrorMessage errorAuth;
late WebAnswerProvider answerAuth;
late WebRole roleAuth;

Widget createWebSignupScreen() => MultiProvider(
      providers: [
        ChangeNotifierProvider<WebAuth>(
          create: (context) {
            webAuthent = WebAuth();
            return webAuthent;
          },
        ),
        ChangeNotifierProvider<WebErrorMessage>(
          create: (context) {
            errorAuth = WebErrorMessage();
            return errorAuth;
          },
        ),
        ChangeNotifierProvider<WebAnswerProvider>(
          create: (context) {
            answerAuth = WebAnswerProvider();
            return answerAuth;
          },
        ),
        ChangeNotifierProvider<WebRole>(
          create: (context) {
            roleAuth = WebRole({}, '');
            return roleAuth;
          },
        ),
      ],
      child: MaterialApp(
        routes: {
          '/web-login': (context) => const WebLoginScreen(),
          '/web-signup': (context) => WebSignUpScreen(),
          '/web-home': (context) => const WebHomeScreen(),
          '/confirmation': (context) => SignupConfirmation(),
          '/web-email-verified': (context) => const WebEmailVerified(),
          '/verified': (context) => const Verifed(),
          '/web-onboarding-view': (context) => const WebOnboardingView(),
          '/web-congratulations': (context) => const WebCongratulationsScreen(),
          '/web-contact': (context) => const WebContactScreen(),
          '/web-lectures': (context) => const WebLecturesPage(),
          '/web-recent': (context) => const WebRecentLecturesPage(),
          '/web-video': (context) => const WebLectureVideoScreen(),
        },
        home: WebSignUpScreen(),
      ),
    );

final emailLoginField = find.byKey(const Key('emailField'));
final passwordLoginField = find.byKey(const Key('passwordField'));
final togglePasswordViewLogin = find.byKey(const Key('togglePasswordView'));
final loginButton = find.byKey(const Key('loginButton'));
final logOutButton = find.byKey(const Key('logOutButton'));
final signupRedirectionButton = find.byKey(const Key('signUpRedirection'));
final nameSignupTextField = find.byKey(const Key('nameSignup'));
final surnnameSignupTextField = find.byKey(const Key('surnameSignup'));
final birthdateSignupTextField = find.byKey(const Key('birthdateSignup'));
final citySignupTextField = find.byKey(const Key('citySignup'));
final dropdownButtonSignup = find.byKey(const Key('dropdownButtonSignup'));
final dropdownItem = find.text('Student').last;
final phoneSignupTextField = find.byKey(const Key('phoneSignup'));
final emailSignupTextField = find.byKey(const Key('emailSignup'));
final passwordSignupTextField = find.byKey(const Key('passwordSignup'));
final signupButton = find.byKey(const Key('signupButton'));
final emailVerificationTextField1 = find.byKey(const Key('verificationField1'));
final emailVerificationTextField2 = find.byKey(const Key('verificationField2'));
final emailVerificationTextField3 = find.byKey(const Key('verificationField3'));
final emailVerificationTextField4 = find.byKey(const Key('verificationField4'));
final emailVerificationTextField5 = find.byKey(const Key('verificationField5'));
final emailVerificationTextField6 = find.byKey(const Key('verificationField6'));
final emailVerifyButton = find.byKey(const Key('verifyButton'));
final onboardingAnswerYes = find.byKey(const Key('onboardingWebQYes'));
final onboardingAnswerQ1 = find.byKey(const Key('prvi'));
final onboardingAnswerQ2 = find.byKey(const Key('drugi'));
final onboardingAnswerQ3 = find.byKey(const Key('treci'));
final onboardingAnswerQ4 = find.byKey(const Key('cetvrti'));
final onboardingAnswerQ5 = find.byKey(const Key('peti'));
final onboardingAnswerQ6 = find.byKey(const Key('sesti'));
final onboardingVideoTextField =
    find.byKey(const Key('onboardingVideoTextField'));
final onboardingSubmitButton = find.byKey(const Key('onboardingSubmitWeb'));
final onboardingScrollableScreen = find.byKey(const Key('scrollWebOnboarding'));
final firstRoleTextButton = find.byType(TextButton).at(1);
final secondRoleTextButton = find.byType(TextButton).at(2);
final listViewFinder = find.byKey(const Key('scrollableListView'));
final showMoreButton = find.byKey(const Key('showMoreButton'));
final recentLecturesButton = find.byKey(const Key('recentLecturesButton'));
final homescreenButton = find.byKey(const Key('homescreenButton'));
final contactFormButton = find.byKey(const Key('contactFormButton'));
final contactField = find.byKey(const Key('contactField'));
final submitContactFormButton =
    find.byKey(const Key('submitContactFormButton'));
final profilePopupButton = find.byType(PopupMenuButton<int>);
final popupLogoutButton = find.byType(PopupMenuItem<int>);

@GenerateMocks([SignUpResult, AmplifyClass])
void main() {
  group('Web application flow test', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('Web application flow test', (tester) async {
      MockAmplifyClass test = MockAmplifyClass();
      when(test.Auth).thenReturn(MockAuth());
      when(test.API).thenReturn(MockAPI());
      AmplifyClass.instance = test;

      await tester.pumpWidget(createWebSignupScreen());
      await tester.pumpAndSettle();

      await tester.ensureVisible(nameSignupTextField);
      await tester.tap(nameSignupTextField);
      await tester.enterText(nameSignupTextField, 'Test');

      await tester.pumpAndSettle();

      await tester.tap(surnnameSignupTextField);
      await tester.enterText(surnnameSignupTextField, 'Test');

      await tester.pumpAndSettle();

      await tester.tap(birthdateSignupTextField);
      await tester.enterText(birthdateSignupTextField, '01-01-1997');

      await tester.pumpAndSettle();

      await tester.ensureVisible(citySignupTextField);
      await tester.tap(citySignupTextField);
      await tester.enterText(citySignupTextField, 'Sarajevo');

      await tester.pumpAndSettle();
      await tester.ensureVisible(dropdownButtonSignup);
      await tester.tap(dropdownButtonSignup);
      await tester.pumpAndSettle();

      await tester.ensureVisible(dropdownItem);
      await tester.tap(dropdownItem);
      await tester.pumpAndSettle();

      await tester.ensureVisible(phoneSignupTextField);
      await tester.tap(phoneSignupTextField);
      await tester.enterText(phoneSignupTextField, '+387123456789');

      await tester.pumpAndSettle();

      await tester.ensureVisible(emailSignupTextField);
      await tester.tap(emailSignupTextField);
      await tester.enterText(emailSignupTextField, 'testing@gmail.com');

      await tester.pumpAndSettle();

      await tester.ensureVisible(passwordSignupTextField);

      await tester.tap(passwordSignupTextField);
      await tester.enterText(passwordSignupTextField, 'Testing1!');

      await tester.pumpAndSettle();

      await tester.ensureVisible(signupButton);
      await tester.tap(signupButton);
      await tester.pumpAndSettle();

      expect(find.text('Just to be sure...'), findsOneWidget);

      await tester.tap(emailVerificationTextField1);
      await tester.enterText(emailVerificationTextField1, '1');

      await tester.pumpAndSettle();

      await tester.tap(emailVerificationTextField2);
      await tester.enterText(emailVerificationTextField2, '1');

      await tester.pumpAndSettle();

      await tester.tap(emailVerificationTextField3);
      await tester.enterText(emailVerificationTextField3, '1');

      await tester.pumpAndSettle();

      await tester.tap(emailVerificationTextField4);
      await tester.enterText(emailVerificationTextField4, '1');

      await tester.pumpAndSettle();

      await tester.tap(emailVerificationTextField5);
      await tester.enterText(emailVerificationTextField5, '1');

      await tester.pumpAndSettle();

      await tester.tap(emailVerificationTextField6);
      await tester.enterText(emailVerificationTextField6, '1');

      await tester.pumpAndSettle();

      await tester.tap(emailVerifyButton);
      await tester.pumpAndSettle();

      expect(find.text('Email verified'), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 5));

      await tester.tap(onboardingAnswerYes);
      await tester.pumpAndSettle();

      final List<Widget> qatiles =
          tester.widgetList(find.byType(QATile)).toList();
      for (int i = 0; i < qatiles.length; i++) {
        final textFormField = find.descendant(
            of: find.byWidget(qatiles[i]),
            matching: find.byType(TextFormField));
        await tester.enterText(textFormField, 'Some text for QATile $i');
        await tester.pumpAndSettle();
      }

      await tester.tap(onboardingVideoTextField);
      await tester.enterText(onboardingVideoTextField,
          'https://www.youtube.com/watch?v=75i5VmTI6A0');
      await tester.pumpAndSettle();
      // await tester.fling(
      //     onboardingScrollableScreen, const Offset(0, -200), 1000);
      // await tester.pumpAndSettle();

      final rolePMFinder = find.byWidgetPredicate(
          (widget) => widget is RoleTile && widget.role == listRole[1]);
      await tester.ensureVisible(rolePMFinder);
      await tester.tap(rolePMFinder);
      await tester.pumpAndSettle();

      final roleUIUXFinder = find.byWidgetPredicate(
          (widget) => widget is RoleTile && widget.role == listRole[3]);
      await tester.ensureVisible(roleUIUXFinder);
      await tester.tap(roleUIUXFinder);
      await tester.pumpAndSettle();

      await tester.ensureVisible(onboardingSubmitButton);
      await tester.tap(onboardingSubmitButton);
      await tester.pumpAndSettle(const Duration(seconds: 4));

      await tester.ensureVisible(emailLoginField);
      await tester.tap(emailLoginField);
      await tester.enterText(emailLoginField, 'bkaric@pa.tech387.com');
      await tester.pumpAndSettle();

      await tester.tap(passwordLoginField);
      await tester.enterText(passwordLoginField, 'Testing1!');
      await tester.pumpAndSettle();

      await tester.tap(togglePasswordViewLogin);
      await tester.pumpAndSettle();

      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      await tester.ensureVisible(secondRoleTextButton);
      await tester.tap(secondRoleTextButton);
      await tester.pumpAndSettle();
      await tester.drag(listViewFinder, const Offset(0, -1400));
      await tester
          .pump(const Duration(milliseconds: 500)); // add delay/ add delay
      await tester.pumpAndSettle();

      await tester.ensureVisible(firstRoleTextButton);
      await tester.tap(firstRoleTextButton);
      await tester.pumpAndSettle();

      final fifthCardFinder = find.text('6. Design System: Material Design');
      await tester.drag(listViewFinder, const Offset(0, -800));
      await tester
          .pump(const Duration(milliseconds: 500)); // add delay/ add delay
      await tester.tap(fifthCardFinder);
      await tester.pumpAndSettle();

      await tester.ensureVisible(showMoreButton);
      await tester.tap(showMoreButton);
      await tester.pumpAndSettle();

      expect(
          find.text(
              '"Material Design" je dizajn sistem razvijen od Google-a i jedan je od najbolje dokumentovanih. Ovdje možeš pronaći svu dokumentaciju. Detaljno je proučite i pokušajte da je iskoristite.'),
          findsOneWidget);

      await tester.ensureVisible(contactFormButton);
      await tester.tap(contactFormButton);
      await tester.pumpAndSettle();

      await tester.ensureVisible(contactField);
      await tester.tap(contactField);
      await tester.pumpAndSettle();
      await tester.enterText(contactField, 'Test');
      await tester.tap(submitContactFormButton);
      await tester.pumpAndSettle();

      expect(find.text('Your message has to contain at least 10 characters'),
          findsOneWidget);

      await tester.tap(contactField);
      await tester.enterText(contactField, 'Testiranje submita');
      await tester.pumpAndSettle();
      await tester.tap(submitContactFormButton);
      await tester.pumpAndSettle();

      await tester.ensureVisible(recentLecturesButton);
      await tester.tap(recentLecturesButton);
      await tester.pumpAndSettle();

      expect(
          find.text('Agile Product Ownership in a Nutshell'), findsNWidgets(2));

      await tester.ensureVisible(homescreenButton);
      await tester.tap(homescreenButton);
      await tester.pumpAndSettle();

      await tester.ensureVisible(profilePopupButton);
      await tester.tap(profilePopupButton);
      await tester.pumpAndSettle();

      await tester.ensureVisible(popupLogoutButton);
      await tester.tap(popupLogoutButton);
      await tester.pumpAndSettle();

      expect(find.text('All great things take time to accomplish'),
          findsOneWidget);

      await tester.ensureVisible(signupRedirectionButton);
      await tester.tap(signupRedirectionButton);
      await tester.pumpAndSettle();

      expect(find.text('Welcome to'), findsOneWidget);
    });
  });
}
