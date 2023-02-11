import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:v2_product_arena/amplifyconfiguration.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/email_verification_screen.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/mobile_login_screen.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/mobile_signup_screen.dart';
import 'package:v2_product_arena/mobile/providers/mobile_auth_provider.dart';

late MobileAuth auth;

Widget createMobileSignupScreen() => ChangeNotifierProvider<MobileAuth>(
      create: (context) {
        auth = MobileAuth();
        return auth;
      },
      child: MaterialApp(
        routes: {
          '/mobile-login': (context) => const MobileLoginScreen(),
        },
        home: const MobileSignupScreen(),
      ),
    );
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
      await tester.pumpWidget(createMobileSignupScreen());
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('nameTextField')));
      await tester.enterText(find.byKey(const Key('nameTextField')), 'Test');

      await tester.tap(find.byKey(const Key('surnameTextField')));
      await tester.enterText(find.byKey(const Key('surnameTextField')), 'Test');

      await tester.tap(find.byKey(const Key('birthDateTextField')));
      await tester.enterText(
          find.byKey(const Key('birthDateTextField')), '01-01-1997');

      await tester.tap(find.byKey(const Key('cityTextField')));
      await tester.enterText(
          find.byKey(const Key('cityTextField')), 'Sarajevo');

      await tester.tap(find.byKey(const Key('dropdownButton')));
      await tester.pumpAndSettle();

      final dropdownItem = find.text('Student').last;

      await tester.tap(dropdownItem);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('phoneTextField')));
      await tester.enterText(
          find.byKey(const Key('phoneTextField')), '+387123456789');

      await tester.tap(find.byKey(const Key('emailTextField')));
      await tester.enterText(
          find.byKey(const Key('emailTextField')), 'testing@gmail.com');

      await tester.ensureVisible(find.byKey(const Key('passwordTextField')));

      await tester.tap(find.byKey(const Key('passwordTextField')));
      await tester.enterText(
          find.byKey(const Key('passwordTextField')), 'Testing1!');

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('signupButton')));
      await tester.pumpAndSettle();

      expect(find.byType(EmailVerificationScreen), findsOneWidget);
    });
  });
}
