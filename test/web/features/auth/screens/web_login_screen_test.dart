import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_login_screen.dart';

void main() {
  group('Web login screen tests', () {
    testWidgets(
        'GIVEN web login screen, WHEN widget is built, THEN all input fields and buttons should be visible',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: WebLoginScreen()));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('emailField')), findsOneWidget);
      expect(find.byKey(const Key('passwordField')), findsOneWidget);
      expect(find.byKey(const Key('loginButton')), findsOneWidget);
      expect(find.byKey(const Key('togglePasswordView')), findsOneWidget);
    });
    testWidgets(
        'GIVEN web login screen, WHEN widget is built, THEN all required text is visible on screen',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: WebLoginScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Welcome to'), findsOneWidget);
      expect(find.text('Product Arena'), findsOneWidget);
      expect(find.text('All great things take time to accomplish'),
          findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);
    });
    testWidgets(
        'GIVEN web login screen, WHEN screen is loaded, THEN toggle visibility icon should be present and isHiddenPassword should be true',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: WebLoginScreen()));
      await tester.pumpAndSettle();

      final passwordTextField = find.descendant(
        of: find.byKey(const Key('passwordField')),
        matching: find.byType(EditableText),
      );
      final input = tester.widget<EditableText>(passwordTextField);
      expect(input.obscureText, isTrue);
    });
    testWidgets(
        'GIVEN web login screen, WHEN user tap on toggle password icon, THEN password should be visible',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: WebLoginScreen()));
      await tester.pumpAndSettle();
      final togglePasswordViewIcon =
          find.byKey(const Key('togglePasswordView'));
      await tester.ensureVisible(togglePasswordViewIcon);
      await tester.tap(togglePasswordViewIcon);
      await tester.pump();
      final passwordTextField = find.descendant(
        of: find.byKey(const Key('passwordField')),
        matching: find.byType(EditableText),
      );
      await tester.pump();
      final input = tester.widget<EditableText>(passwordTextField);
      expect(input.obscureText, isFalse);
    });
    testWidgets(
        'GIVEN web login screen, WHEN widget is built, THEN Tech387 logo should be visible on screen',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: WebLoginScreen()));
      await tester.pumpAndSettle();

      final imageWidget = find.byType(Image).evaluate().first.widget as Image;
      expect(imageWidget.image, isA<AssetImage>());
      final assetImage = imageWidget.image as AssetImage;
      expect(assetImage.assetName, equals('assets/images/PAlogowhite.png'));
    });
    testWidgets(
        'GIVEN web login screen, WHEN user leave empty input fields and press on login button, THEN he should he alert messages',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: WebLoginScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pumpAndSettle();
      expect(find.text('Please fill the required field.'), findsNWidgets(2));
    });
    testWidgets(
        'GIVEN web login screen, WHEN user enter email without @ and dot, THEN he should see alert message',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: WebLoginScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('emailField')));
      await tester.enterText(find.byKey(const Key('emailField')), 'mail');

      await tester.pump();

      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pumpAndSettle();

      expect(find.text('Invalid email format.'), findsOneWidget);
    });
    testWidgets(
        'GIVEN web login screen, WHEN user enter email without dot, THEN he should see alert message',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: WebLoginScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('emailField')));
      await tester.enterText(find.byKey(const Key('emailField')), 'mail@');

      await tester.pump();

      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pumpAndSettle();

      expect(find.text('Invalid email format.'), findsOneWidget);
    });
    testWidgets(
        'GIVEN web login screen, WHEN user enter email without string before @, THEN he should see alert message',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: WebLoginScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('emailField')));
      await tester.enterText(find.byKey(const Key('emailField')), '@.com');

      await tester.pump();

      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pumpAndSettle();

      expect(find.text('Invalid email format.'), findsOneWidget);
    });
    testWidgets(
        'GIVEN web login screen, WHEN user enter valid email, THEN he shouldn\'t see alert message',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: WebLoginScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('emailField')));
      await tester.enterText(
          find.byKey(const Key('emailField')), 'test@test.com');

      await tester.pump();

      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pumpAndSettle();

      expect(find.text('Invalid email format.'), findsNothing);
    });
    testWidgets(
        'GIVEN web login screen, WHEN user enter password shorter than 8 characters, THEN he should see alert message',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: WebLoginScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('passwordField')));
      await tester.enterText(find.byKey(const Key('passwordField')), 'Test');

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pumpAndSettle();

      expect(find.text('Invalid password format'), findsOneWidget);
    });
    testWidgets(
        'GIVEN web login screen, WHEN user enter password longer than 8 characters, THEN he shouldn\'t see alert message',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: WebLoginScreen()));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('passwordField')));
      await tester.enterText(
          find.byKey(const Key('passwordField')), 'Testing1!');

      await tester.pump();

      await tester.tap(find.byKey(const Key('loginButton')));
      await tester.pumpAndSettle();

      expect(find.text('Invalid password format'), findsNothing);
    });
  });
}
