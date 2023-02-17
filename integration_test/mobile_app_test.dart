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

final emailLoginField = find.byKey(const Key('emailLoginTextField'));
final passwordLoginField = find.byKey(const Key('passwordLoginTextField'));
final togglePasswordLogin = find.byKey(const Key('togglePasswordViewLogin'));
final loginButton = find.byKey(const Key('loginButton'));
final logOutButton = find.byKey(const Key('logOutButton'));
final signupRedirectionButton = find.byKey(const Key('signUpRedirection'));
final nameTextField = find.byKey(const Key('nameTextField'));
final surnnameTextField = find.byKey(const Key('surnameTextField'));
final birthDateTextField = find.byKey(const Key('birthDateTextField'));
final cityTextField = find.byKey(const Key('cityTextField'));
final dropDownButton = find.byKey(const Key('dropDownButton'));
final dropdownItem = find.text('Student').last;
final phoneTextField = find.byKey(const Key('phoneTextField'));
final emailSignupTextField = find.byKey(const Key('emailTextField'));
final passwordSignupTextField =
    find.byKey(const Key('passwordSignUpTextField'));
final togglePasswordSignup = find.byKey(const Key('togglePasswordViewSignup'));
final signupButton = find.byKey(const Key('createYourAccount'));
final verifyField1 = find.byKey(const Key('emailverificationField1'));
final verifyField2 = find.byKey(const Key('emailverificationField2'));
final verifyField3 = find.byKey(const Key('emailverificationField3'));
final verifyField4 = find.byKey(const Key('emailverificationField4'));
final verifyField5 = find.byKey(const Key('emailverificationField5'));
final verifyField6 = find.byKey(const Key('emailverificationField6'));
final emailVerifyButton = find.byKey(const Key('emailVerifyButton'));
final onboardingWelcomeRedButton = find.byKey(const Key('onboardingFormRed'));
final onboardingAnswerYes = find.byKey(const Key('onboardingQYes'));
final onboardingFirstQuestionNextButton = find.byKey(const Key('nextButtonFQ'));
final onboardingAnswerTextField = find.byKey(const Key('onboardingQAnsw'));
final onboardingNextButton = find.byKey(const Key('nextButtonForm'));
final onboardingScrollableLastQScreen = find.byKey(const Key('scroll'));
final onboardingVideoTextField = find.byKey(const Key('vasOdgovorTextField'));
final onboardingVideoNextButton = find.byKey(const Key('nextButtonVideo'));
final onboardingSubmitButton = find.byKey(const Key('submitOnboarding'));

@GenerateMocks([SignInResult, SignUpResult, AmplifyClass])
void main() {
  // _currentPage = 0;
  group('Testing App Performance Tests', () {
    setUpAll(() async {
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    });
    testWidgets('Mobile signup', (tester) async {
      MockAmplifyClass test = MockAmplifyClass();
      when(test.Auth).thenReturn(MockAuth());
      when(test.API).thenReturn(MockAPI());
      AmplifyClass.instance = test;
      await tester.pumpWidget(createMobileLoginScreen());
      await tester.pumpAndSettle();

      await tester.tap(emailLoginField);
      await tester.enterText(emailLoginField, 'bkaric@pa.tech387.com');
      await tester.pumpAndSettle();

      await tester.tap(passwordLoginField);
      await tester.enterText(passwordLoginField, 'Testing1!');
      await tester.pumpAndSettle();

      await tester.tap(togglePasswordLogin);
      await tester.pumpAndSettle();

      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      await tester.tap(logOutButton);
      await tester.pumpAndSettle();

      await tester.tap(signupRedirectionButton);
      await tester.pumpAndSettle();

      await tester.tap(nameTextField);
      await tester.enterText(nameTextField, 'Test');
      await tester.pumpAndSettle();

      await tester.tap(surnnameTextField);
      await tester.enterText(surnnameTextField, 'Test');
      await tester.pumpAndSettle();

      await tester.tap(birthDateTextField);
      await tester.enterText(birthDateTextField, '01-01-1997');
      await tester.pumpAndSettle();

      await tester.tap(cityTextField);
      await tester.enterText(cityTextField, 'Sarajevo');
      await tester.pumpAndSettle();

      await tester.tap(dropDownButton);
      await tester.ensureVisible(dropDownButton);
      await tester.pump(const Duration(seconds: 1));
      await tester.ensureVisible(dropdownItem);
      await tester.tap(dropdownItem);
      await tester.pumpAndSettle();

      await tester.tap(phoneTextField);
      await tester.pumpAndSettle();
      await tester.enterText(phoneTextField, '+123456789');
      await tester.pumpAndSettle();

      await tester.tap(emailSignupTextField);
      await tester.enterText(emailSignupTextField, 'testing@gmail.com');
      await tester.pumpAndSettle();

      await tester.ensureVisible(passwordSignupTextField);
      await tester.tap(passwordSignupTextField);
      await tester.enterText(passwordSignupTextField, 'Testing1!');
      await tester.pumpAndSettle();

      await tester.tap(togglePasswordSignup);
      await tester.pumpAndSettle();

      await tester.tap(signupButton);
      await tester.pumpAndSettle();

      await tester.tap(verifyField1);
      await tester.enterText(verifyField1, '1');

      await tester.pumpAndSettle();

      await tester.tap(verifyField2);
      await tester.enterText(verifyField2, '1');

      await tester.pumpAndSettle();

      await tester.tap(verifyField3);
      await tester.enterText(verifyField3, '1');

      await tester.pumpAndSettle();

      await tester.tap(verifyField4);
      await tester.enterText(verifyField4, '1');

      await tester.pumpAndSettle();

      await tester.tap(verifyField5);
      await tester.enterText(verifyField5, '1');

      await tester.pumpAndSettle();

      await tester.tap(verifyField6);
      await tester.enterText(verifyField6, '1');

      await tester.pumpAndSettle();

      await tester.tap(emailVerifyButton);
      await tester.pumpAndSettle();

      await tester.pumpAndSettle(const Duration(seconds: 5));

      await tester.tap(onboardingWelcomeRedButton);
      await tester.pumpAndSettle();

      await tester.tap(onboardingAnswerYes);
      await tester.pumpAndSettle();

      await tester.tap(onboardingFirstQuestionNextButton);
      await tester.pumpAndSettle();

      await tester.tap(onboardingAnswerTextField);
      await tester.enterText(onboardingAnswerTextField, 'anything');
      await tester.pumpAndSettle();
      await tester.tap(onboardingNextButton);
      await tester.pumpAndSettle();

      await tester.tap(onboardingAnswerTextField);
      await tester.enterText(onboardingAnswerTextField, 'anything');
      await tester.pumpAndSettle();
      await tester.tap(onboardingNextButton);
      await tester.pumpAndSettle();

      await tester.tap(onboardingAnswerTextField);
      await tester.enterText(onboardingAnswerTextField, 'anything');
      await tester.pumpAndSettle();
      await tester.tap(onboardingNextButton);
      await tester.pumpAndSettle();

      await tester.tap(onboardingAnswerTextField);
      await tester.enterText(onboardingAnswerTextField, 'anything');
      await tester.pumpAndSettle();
      await tester.tap(onboardingNextButton);
      await tester.pumpAndSettle();

      await tester.tap(onboardingAnswerTextField);
      await tester.enterText(onboardingAnswerTextField, 'anything');
      await tester.pumpAndSettle();

      await tester.fling(
          onboardingScrollableLastQScreen, const Offset(0, -200), 1000);
      await tester.pumpAndSettle();

      await tester.tap(onboardingNextButton);
      await tester.pumpAndSettle();

      await tester.tap(onboardingVideoTextField);
      await tester.enterText(onboardingVideoTextField,
          'https://www.youtube.com/watch?v=75i5VmTI6A0');
      await tester.pumpAndSettle();
      await tester.tap(onboardingVideoNextButton);
      await tester.pumpAndSettle();

      final roleTileFinder = find.byWidgetPredicate(
          (widget) => widget is RoleTile && widget.role == listRole[0]);

      await tester.tap(roleTileFinder);

      await tester.pumpAndSettle();

      await tester.tap(onboardingSubmitButton);

      await tester.pumpAndSettle(const Duration(seconds: 5));

      await tester.tap(logOutButton);
      await tester.pumpAndSettle();
    });
  });
}
