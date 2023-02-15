import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:v2_product_arena/amplifyconfiguration.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/email_verification_screen.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/email_verified_screen.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/mobile_login_screen.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/mobile_signup_screen.dart';
import 'package:v2_product_arena/mobile/features/home/screens/mobile_home_screen.dart';
import 'package:v2_product_arena/mobile/features/onboarding/screens/mobile_onboarding_screen.dart';
import 'package:v2_product_arena/mobile/providers/mobile_auth_provider.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
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

late MobileAuth mobileAuthent;

Widget createMobileLoginScreen() => ChangeNotifierProvider<MobileAuth>(
      create: (context) {
        mobileAuthent = MobileAuth();
        return mobileAuthent;
      },
      child: MaterialApp(
        routes: {
          '/mobile-login': (context) => const MobileLoginScreen(),
          '/mobile-signup': (context) => const MobileSignupScreen(),
          '/mobile-home': (context) => const MobileHomeScreen(),
          '/email-verification': (context) => const EmailVerificationScreen(),
          '/email-verified': (context) => const EmailVerified(),
          '/mobile-onboarding': (context) => const MobileOnboardingScreen(),
        },
        home: const MobileLoginScreen(),
      ),
    );

@GenerateMocks([SignInResult, SignUpResult, AmplifyClass])
void main() {
  group('Testing App Performance Tests', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();

    test('can configure Amplify', () async {
      AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
      await Amplify.addPlugin(authPlugin);

      try {
        await Amplify.configure(amplifyconfig);
      } on AmplifyAlreadyConfiguredException {
        safePrint(
            "Tried to reconfigure Amplify: This can occur when your app restarts on Android.");
      }
    });
    testWidgets('Mobile signup', (tester) async {
      MockAmplifyClass test = MockAmplifyClass();
      when(test.Auth).thenReturn(MockAuth());
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

      await tester.tap(find.byKey(const Key('togglePasswordViewSignUp')));
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

      await tester.pumpAndSettle();
    });
  });
}
