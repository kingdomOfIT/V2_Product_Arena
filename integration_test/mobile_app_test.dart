import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:v2_product_arena/amplifyconfiguration.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/email_verification_screen.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/email_verified_screen.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/mobile_signup_screen.dart';
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
}

late MobileAuth mobileAuthent;

Widget createMobileSignupScreen() => ChangeNotifierProvider<MobileAuth>(
      create: (context) {
        mobileAuthent = MobileAuth();
        return mobileAuthent;
      },
      child: MaterialApp(
        routes: {
          '/email-verification': (context) => const EmailVerificationScreen(),
          '/email-verified': (context) => const EmailVerified(),
          '/mobile-onboarding': (context) => const MobileOnboardingScreen(),
        },
        home: const MobileSignupScreen(),
      ),
    );

@GenerateMocks([SignUpResult, AmplifyClass])
void main() {
  MockBuildContext mockContext = MockBuildContext();
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
      MobileAuth mobileAuth = MockMobileAuth();
      MockAmplifyClass test = MockAmplifyClass();
      when(test.Auth).thenReturn(MockAuth());
      AmplifyClass.instance = test;
      await tester.pumpWidget(createMobileSignupScreen());
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

      await tester.tap(find.byKey(const Key('dropdownButton')));
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

      await tester.ensureVisible(find.byKey(const Key('passwordTextField')));
      await tester.tap(find.byKey(const Key('passwordTextField')));
      await tester.enterText(
          find.byKey(const Key('passwordTextField')), 'Testing1!');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('signupButton')));
      await tester.pumpAndSettle();

      await mobileAuth.signUpUser(
          "Test",
          "Test",
          "01-01-1997",
          "Sarajevo",
          "Student",
          "123456789",
          "testing@gmail.com",
          "Testing1!",
          mockContext,
          "/email-verification");

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

      await tester.tap(find.byKey(const Key('emailverifyButton')));
      await tester.pumpAndSettle();

      await mobileAuth.confirmUser(
          'testing@gmail.com', '111111', mockContext, '/email-verified');
      await tester.pumpAndSettle();
    });
  });
}
