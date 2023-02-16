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
import 'package:v2_product_arena/web/features/home/screens/web_home_screen.dart';
import 'package:v2_product_arena/web/features/onboarding/screens/web_onboarding_screen.dart';
import 'package:v2_product_arena/web/providers/web_auth_provider.dart';
import 'package:v2_product_arena/web/providers/web_ob_answers.dart';
import 'package:v2_product_arena/web/providers/web_ob_error.dart';
import 'package:v2_product_arena/web/providers/web_ob_role.dart';
import 'mobile_auth_provider_test.mocks.dart';

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
        statusCode: 200,
        headers: const {},
        body: Uint8List.fromList([]),
      );
    });
    return result;
  }
}

late WebAuth webAuthent;
late WebErrorMessage errorAuth;
late WebAnswerProvider answerAuth;
late WebRole roleAuth;

Widget createWebLoginScreen() => MultiProvider(
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
        },
        home: const WebLoginScreen(),
      ),
    );

@GenerateMocks([SignUpResult, AmplifyClass])
void main() {
  group('Web flow test (login, signup, onboarding)', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('Web signup', (tester) async {
      MockAmplifyClass test = MockAmplifyClass();
      when(test.Auth).thenReturn(MockAuth());
      when(test.API).thenReturn(MockAPI());
      AmplifyClass.instance = test;
      await tester.pumpWidget(createWebLoginScreen());
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('emailField')));
      await tester.enterText(
          find.byKey(const Key('emailField')), 'bkaric@pa.tech387.com');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('passwordField')));
      await tester.enterText(
          find.byKey(const Key('passwordField')), 'Testing1!');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('togglePasswordView')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('logOutButton')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('signUpRedirection')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('nameSignup')));
      await tester.enterText(find.byKey(const Key('nameSignup')), 'Test');

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('surnameSignup')));
      await tester.enterText(find.byKey(const Key('surnameSignup')), 'Test');

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('birthdateSignup')));
      await tester.enterText(
          find.byKey(const Key('birthdateSignup')), '01-01-1997');

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('citySignup')));
      await tester.enterText(find.byKey(const Key('citySignup')), 'Sarajevo');

      await tester.pumpAndSettle();
      await tester.ensureVisible(find.byKey(const Key('dropdownButtonSignup')));
      await tester.tap(find.byKey(const Key('dropdownButtonSignup')));
      await tester.pumpAndSettle();

      final dropdownItem = find.text('Student').last;
      await tester.ensureVisible(dropdownItem);
      await tester.tap(dropdownItem);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('phoneSignup')));
      await tester.enterText(
          find.byKey(const Key('phoneSignup')), '+387123456789');

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('emailSignup')));
      await tester.enterText(
          find.byKey(const Key('emailSignup')), 'testing@gmail.com');

      await tester.pumpAndSettle();

      await tester.ensureVisible(find.byKey(const Key('passwordSignup')));

      await tester.tap(find.byKey(const Key('passwordSignup')));
      await tester.enterText(
          find.byKey(const Key('passwordSignup')), 'Testing1!');

      await tester.pumpAndSettle();

      await tester.ensureVisible(find.byKey(const Key('signupButton')));
      await tester.tap(find.byKey(const Key('signupButton')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('verificationField1')));
      await tester.enterText(find.byKey(const Key('verificationField1')), '1');

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('verificationField2')));
      await tester.enterText(find.byKey(const Key('verificationField2')), '1');

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('verificationField3')));
      await tester.enterText(find.byKey(const Key('verificationField3')), '1');

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('verificationField4')));
      await tester.enterText(find.byKey(const Key('verificationField4')), '1');

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('verificationField5')));
      await tester.enterText(find.byKey(const Key('verificationField5')), '1');

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('verificationField6')));
      await tester.enterText(find.byKey(const Key('verificationField6')), '1');

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('verifyButton')));
      await tester.pumpAndSettle();

      await tester.pumpAndSettle(const Duration(seconds: 5));

      await tester.tap(find.byKey(const Key('onboardingWebQYes')));

      await tester.tap(find.byKey(const Key('prvi')));
      await tester.enterText(find.byKey(const Key('prvi')), 'anything');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('drugi')));
      await tester.enterText(find.byKey(const Key('drugi')), 'anything');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('treci')));
      await tester.enterText(find.byKey(const Key('treci')), 'anything');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('cetvrti')));
      await tester.enterText(find.byKey(const Key('cetvrti')), 'anything');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('peti')));
      await tester.enterText(find.byKey(const Key('peti')), 'anything');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('sesti')));
      await tester.enterText(find.byKey(const Key('sesti')), 'anything');
      await tester.pumpAndSettle();
    });
  });
}
