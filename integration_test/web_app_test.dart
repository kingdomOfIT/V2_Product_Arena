import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_email_verifed.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_signup_screen.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_verification_screen.dart';
import 'package:v2_product_arena/web/features/onboarding/screens/web_onboarding_screen.dart';
import 'package:v2_product_arena/web/providers/web_auth_provider.dart';
import 'mobile_auth_provider_test.mocks.dart';

class MockWebAuth extends WebAuth {}

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

late WebAuth webAuthent;

Widget createWebSignUpScreen() => ChangeNotifierProvider<WebAuth>(
      create: (context) {
        webAuthent = WebAuth();
        return webAuthent;
      },
      child: MaterialApp(
        routes: {
          '/confirmation': (context) => SignupConfirmation(),
          '/verified': (context) => Verifed(),
          '/web-onboarding': (context) => const WebOnboardingView(),
        },
        home: WebSignUpScreen(),
      ),
    );

@GenerateMocks([SignUpResult, AmplifyClass])
void main() {
  group('Testing App Performance Tests', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('Web signup', (tester) async {
      MockAmplifyClass test = MockAmplifyClass();
      when(test.Auth).thenReturn(MockAuth());
      AmplifyClass.instance = test;
      await tester.pumpWidget(createWebSignUpScreen());
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

      await tester.tap(find.byKey(const Key('dropdownButtonSignup')));
      await tester.pumpAndSettle();

      final dropdownItem = find.text('Student').last;

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
    });
  });
}
