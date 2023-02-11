import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:v2_product_arena/amplifyconfiguration.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_login_screen.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_signup_screen.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_verification_screen.dart';
import 'package:v2_product_arena/web/providers/web_auth_provider.dart';

late WebAuth webAuth;

Widget createWebSignUpScreen() => ChangeNotifierProvider<WebAuth>(
      create: (context) {
        webAuth = WebAuth();
        return webAuth;
      },
      child: MaterialApp(
        routes: {
          '/web-login': (context) => const WebLoginScreen(),
        },
        home: WebSignUpScreen(),
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
    testWidgets('Web signup', (tester) async {
      await tester.pumpWidget(createWebSignUpScreen());
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('nameSignup')));
      await tester.enterText(find.byKey(const Key('nameSignup')), 'Test');

      await tester.tap(find.byKey(const Key('surnameSignup')));
      await tester.enterText(find.byKey(const Key('surnameSignup')), 'Test');

      await tester.tap(find.byKey(const Key('birthdateSignup')));
      await tester.enterText(
          find.byKey(const Key('birthdateSignup')), '01-01-1997');

      await tester.tap(find.byKey(const Key('citySignup')));
      await tester.enterText(find.byKey(const Key('citySignup')), 'Sarajevo');

      await tester.tap(find.byKey(const Key('dropdownButtonSignup')));
      await tester.pumpAndSettle();

      final dropdownItem = find.text('Student').last;

      await tester.tap(dropdownItem);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('phoneSignup')));
      await tester.enterText(
          find.byKey(const Key('phoneSignup')), '+387123456789');

      await tester.tap(find.byKey(const Key('emailSignup')));
      await tester.enterText(
          find.byKey(const Key('emailSignup')), 'testing@gmail.com');

      await tester.ensureVisible(find.byKey(const Key('passwordSignup')));

      await tester.tap(find.byKey(const Key('passwordSignup')));
      await tester.enterText(
          find.byKey(const Key('passwordSignup')), 'Testing1!');

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('signupButton')));
      await tester.pumpAndSettle();

      expect(find.byType(SignupConfirmation), findsOneWidget);
    });
  });
}
