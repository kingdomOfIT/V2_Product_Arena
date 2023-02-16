import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:v2_product_arena/constants/global_variables.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/email_verification_screen.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/email_verified_screen.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/mobile_login_screen.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/mobile_signup_screen.dart';
import 'package:v2_product_arena/mobile/features/home/screens/mobile_home_screen.dart';
import 'package:v2_product_arena/mobile/features/onboarding/screens/mobile_onboarding_screen.dart';
import 'package:v2_product_arena/mobile/features/onboarding/screens/mobile_verified_onboarding_screen.dart';
import 'package:v2_product_arena/mobile/features/onboarding/widgets/role_tile.dart';
import 'package:v2_product_arena/mobile/providers/answer_provider.dart';
import 'package:v2_product_arena/mobile/providers/error_message_provider.dart';
import 'package:v2_product_arena/mobile/providers/mobile_auth_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:v2_product_arena/mobile/providers/role_provider.dart';
import 'mobile_auth_provider_test.mocks.dart';

class MockMobileAuth extends MobileAuth {}

class MockBuildContext extends Mock implements BuildContext {}

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

late MobileAuth mobileAuthent;
late ErrorMessage errorAuth;
late AnswerProvider answerAuth;
late Role roleAuth;

Widget createMobileLoginScreen() => MultiProvider(
      providers: [
        ChangeNotifierProvider<MobileAuth>(
          create: (context) {
            mobileAuthent = MobileAuth();
            return mobileAuthent;
          },
        ),
        ChangeNotifierProvider<ErrorMessage>(
          create: (context) {
            errorAuth = ErrorMessage();
            return errorAuth;
          },
        ),
        ChangeNotifierProvider<AnswerProvider>(
          create: (context) {
            answerAuth = AnswerProvider();
            return answerAuth;
          },
        ),
        ChangeNotifierProvider<Role>(create: (context) {
          roleAuth = Role({}, '');
          return roleAuth;
        }),
      ],
      child: MaterialApp(
        routes: {
          '/mobile-login': (context) => const MobileLoginScreen(),
          '/mobile-signup': (context) => const MobileSignupScreen(),
          '/mobile-home': (context) => const MobileHomeScreen(),
          '/email-verification': (context) => const EmailVerificationScreen(),
          '/email-verified': (context) => const EmailVerified(),
          '/mobile-onboarding': (context) => const MobileOnboardingScreen(),
          '/mobile-verified-onboarding': (context) =>
              const MobileVerifiedOnboardingScreen(),
        },
        home: const MobileLoginScreen(),
      ),
    );

@GenerateMocks([SignInResult, SignUpResult, AmplifyClass])
void main() {
  // _currentPage = 0;
  group('Testing App Performance Tests', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('Mobile signup', (tester) async {
      MockAmplifyClass test = MockAmplifyClass();
      when(test.Auth).thenReturn(MockAuth());
      when(test.API).thenReturn(MockAPI());
      AmplifyClass.instance = test;
      await tester.pumpWidget(createMobileLoginScreen());
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('emailLoginTextField')));
      await tester.enterText(find.byKey(const Key('emailLoginTextField')),
          'bkaric@pa.tech387.com');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('passwordLoginTextField')));
      await tester.enterText(
          find.byKey(const Key('passwordLoginTextField')), 'Testing1!');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('togglePasswordViewLogin')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('logOutButton')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('signUpRedirection')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('nameTextField')));
      await tester.enterText(find.byKey(const Key('nameTextField')), 'Test');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('surnameTextField')));
      await tester.enterText(find.byKey(const Key('surnameTextField')), 'Test');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('birthDateTextField')));
      await tester.enterText(
          find.byKey(const Key('birthDateTextField')), '01-01-1997');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('cityTextField')));
      await tester.enterText(
          find.byKey(const Key('cityTextField')), 'Sarajevo');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('dropDownButton')));
      await tester.pump(const Duration(seconds: 1));
      final dropdownItem = find.text('Student').last;
      await tester.tap(dropdownItem);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('phoneTextField')));
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(const Key('phoneTextField')), '123456789');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('emailTextField')));
      await tester.enterText(
          find.byKey(const Key('emailTextField')), 'testing@gmail.com');
      await tester.pumpAndSettle();

      await tester
          .ensureVisible(find.byKey(const Key('passwordSignUpTextField')));
      await tester.tap(find.byKey(const Key('passwordSignUpTextField')));
      await tester.enterText(
          find.byKey(const Key('passwordSignUpTextField')), 'Testing1!');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('togglePasswordViewSignup')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('createYourAccount')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('emailverificationField1')));
      await tester.enterText(
          find.byKey(const Key('emailverificationField1')), '1');

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('emailverificationField2')));
      await tester.enterText(
          find.byKey(const Key('emailverificationField2')), '1');

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('emailverificationField3')));
      await tester.enterText(
          find.byKey(const Key('emailverificationField3')), '1');

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('emailverificationField4')));
      await tester.enterText(
          find.byKey(const Key('emailverificationField4')), '1');

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('emailverificationField5')));
      await tester.enterText(
          find.byKey(const Key('emailverificationField5')), '1');

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('emailverificationField6')));
      await tester.enterText(
          find.byKey(const Key('emailverificationField6')), '1');

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('emailVerifyButton')));
      await tester.pumpAndSettle();

      await tester.pumpAndSettle(const Duration(seconds: 5));

      await tester.tap(find.byKey(const Key('onboardingFormRed')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('onboardingQYes')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('nextButtonFQ')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('onboardingQAnsw')));
      await tester.enterText(
          find.byKey(const Key('onboardingQAnsw')), 'anything');
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('nextButtonForm')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('onboardingQAnsw')));
      await tester.enterText(
          find.byKey(const Key('onboardingQAnsw')), 'anything');
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('nextButtonForm')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('onboardingQAnsw')));
      await tester.enterText(
          find.byKey(const Key('onboardingQAnsw')), 'anything');
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('nextButtonForm')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('onboardingQAnsw')));
      await tester.enterText(
          find.byKey(const Key('onboardingQAnsw')), 'anything');
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('nextButtonForm')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('onboardingQAnsw')));
      await tester.enterText(
          find.byKey(const Key('onboardingQAnsw')), 'anything');
      await tester.pumpAndSettle();

      await tester.fling(
          find.byKey(const Key('scroll')), const Offset(0, -200), 1000);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('nextButtonForm')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('vasOdgovorTextField')));
      await tester.enterText(find.byKey(const Key('vasOdgovorTextField')),
          'https://www.youtube.com/watch?v=75i5VmTI6A0');
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('nextButtonVideo')));
      await tester.pumpAndSettle();

      final roleTileFinder = find.byWidgetPredicate(
          (widget) => widget is RoleTile && widget.role == listRole[0]);

      await tester.tap(roleTileFinder);

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('submitOnboarding')));
      await tester.pumpAndSettle();
    });
  });
}
