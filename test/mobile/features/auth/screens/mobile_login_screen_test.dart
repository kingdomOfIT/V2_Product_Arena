import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/mobile_login_screen.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/mobile_signup_screen.dart';
import 'package:v2_product_arena/mobile/providers/mobile_auth_provider.dart';

late MobileAuth auth;

Widget createMobileLoginScreen() => ChangeNotifierProvider<MobileAuth>(
      create: (context) {
        auth = MobileAuth();
        return auth;
      },
      child: MaterialApp(
        routes: {
          '/mobile-signup': (context) => const MobileSignupScreen(),
        },
        home: const MobileLoginScreen(),
      ),
    );
void main() {
  group('Mobile login screen tests', () {
    testWidgets(
        'GIVEN mobile login screen, WHEN widget is built, THEN all input fields and buttons should be visible',
        (tester) async {
      await tester.pumpWidget(createMobileLoginScreen());
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('emailLoginTextField')), findsOneWidget);
      expect(find.byKey(const Key('passwordLoginTextField')), findsOneWidget);
      expect(find.byKey(const Key('togglePasswordViewLogin')), findsOneWidget);
      expect(find.byKey(const Key('loginButton')), findsOneWidget);
      expect(find.byKey(const Key('signUpRedirection')), findsOneWidget);
    });
    testWidgets(
        'GIVEN mobile login screen, WHEN widget is built, THEN all required text is visible on screen',
        (tester) async {
      await tester.pumpWidget(createMobileLoginScreen());
      await tester.pumpAndSettle();

      expect(find.text('Welcome to'), findsOneWidget);
      expect(find.text('Product Arena'), findsOneWidget);
      expect(find.text('Don’t you have an account?'), findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);
    });
    testWidgets(
        'GIVEN mobile login screen, WHEN screen is loaded, THEN toggle visibility icon should be present and isHiddenPassword should be true',
        (tester) async {
      await tester.pumpWidget(createMobileLoginScreen());
      await tester.pumpAndSettle();

      final passwordTextField = find.descendant(
        of: find.byKey(const Key('passwordLoginTextField')),
        matching: find.byType(EditableText),
      );
      final input = tester.widget<EditableText>(passwordTextField);
      expect(input.obscureText, isTrue);
    });
    testWidgets(
        'GIVEN mobile login screen, WHEN user tap on toggle password icon, THEN password should be visible',
        (tester) async {
      await tester.pumpWidget(createMobileLoginScreen());
      await tester.pumpAndSettle();
      final togglePasswordViewIcon =
          find.byKey(const Key('togglePasswordViewLogin'));
      await tester.ensureVisible(togglePasswordViewIcon);
      await tester.tap(togglePasswordViewIcon);
      await tester.pump();
      final passwordTextField = find.descendant(
        of: find.byKey(const Key('passwordLoginTextField')),
        matching: find.byType(EditableText),
      );
      await tester.pump();
      final input = tester.widget<EditableText>(passwordTextField);
      expect(input.obscureText, isFalse);
    });
    testWidgets(
        'GIVEN mobile login screen, WHEN widget is built, THEN Tech387 logo should be visible on screen',
        (tester) async {
      await tester.pumpWidget(createMobileLoginScreen());
      await tester.pumpAndSettle();

      final imageWidget = find.byType(Image).evaluate().first.widget as Image;
      expect(imageWidget.image, isA<AssetImage>());
      final assetImage = imageWidget.image as AssetImage;
      expect(assetImage.assetName, equals('assets/images/tech.png'));
    });
    testWidgets(
        'GIVEN mobile login screen, WHEN user leave empty input fields and press on login button, THEN he should he alert messages',
        (tester) async {
      await tester.pumpWidget(createMobileLoginScreen());
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pumpAndSettle();
      expect(find.text('Please fill the required field.'), findsOneWidget);
      expect(find.text('Please enter password'), findsOneWidget);
    });
    testWidgets(
        'GIVEN mobile login screen, WHEN user enter email without @ and dot, THEN he should see alert message',
        (tester) async {
      await tester.pumpWidget(createMobileLoginScreen());
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('emailLoginTextField')));
      await tester.enterText(
          find.byKey(const Key('emailLoginTextField')), 'mail');

      await tester.pump();

      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pumpAndSettle();

      expect(find.text('Enter valid email'), findsOneWidget);
    });
    testWidgets(
        'GIVEN mobile login screen, WHEN user enter email without dot, THEN he should see alert message',
        (tester) async {
      await tester.pumpWidget(createMobileLoginScreen());
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('emailLoginTextField')));
      await tester.enterText(
          find.byKey(const Key('emailLoginTextField')), 'mail@');

      await tester.pump();

      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pumpAndSettle();

      expect(find.text('Enter valid email'), findsOneWidget);
    });
    testWidgets(
        'GIVEN mobile login screen, WHEN user enter email without string before @, THEN he should see alert message',
        (tester) async {
      await tester.pumpWidget(createMobileLoginScreen());
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('emailLoginTextField')));
      await tester.enterText(
          find.byKey(const Key('emailLoginTextField')), '@.com');

      await tester.pump();

      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pumpAndSettle();

      expect(find.text('Enter valid email'), findsOneWidget);
    });
    testWidgets(
        'GIVEN mobile login screen, WHEN user enter valid email, THEN he shouldn\'t see alert message',
        (tester) async {
      await tester.pumpWidget(createMobileLoginScreen());
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('emailLoginTextField')));
      await tester.enterText(
          find.byKey(const Key('emailLoginTextField')), 'test@test.com');

      await tester.pump();

      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pumpAndSettle();

      expect(find.text('Enter valid email'), findsNothing);
    });
    testWidgets(
        'GIVEN mobile login screen, WHEN user enter password shorter than 8 characters, THEN he should see alert message',
        (tester) async {
      await tester.pumpWidget(createMobileLoginScreen());
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('passwordLoginTextField')));
      await tester.enterText(
          find.byKey(const Key('passwordLoginTextField')), 'Tes');

      await tester.pump();

      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pumpAndSettle();

      expect(find.text('Password is too short'), findsOneWidget);
    });
    testWidgets(
        'GIVEN mobile login screen, WHEN user enter password longer than 8 characters, THEN he shouldn\'t see alert message',
        (tester) async {
      await tester.pumpWidget(createMobileLoginScreen());
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('passwordLoginTextField')));
      await tester.enterText(
          find.byKey(const Key('passwordLoginTextField')), 'Testing1!');

      await tester.pump();

      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pumpAndSettle();

      expect(find.text('Password is too short'), findsNothing);
    });
  });
}
