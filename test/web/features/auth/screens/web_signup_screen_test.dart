import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_login_screen.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_signup_screen.dart';
import 'package:v2_product_arena/web/providers/web_auth_provider.dart';

late WebAuth auth;

Widget createWebSignupScreen() => ChangeNotifierProvider<WebAuth>(
      create: (context) {
        auth = WebAuth();
        return auth;
      },
      child: MaterialApp(
        routes: {
          '/web-login': (context) => const WebLoginScreen(),
        },
        home: WebSignUpScreen(),
      ),
    );

void main() {
  testWidgets(
      'GIVEN signup screen, WHEN widget is built, THEN all input fields and buttons should be visible',
      (tester) async {
    await tester.pumpWidget(createWebSignupScreen());
    await tester.pumpAndSettle();

    expect(find.byKey(const Key('nameSignup')), findsOneWidget);
    expect(find.byKey(const Key('surnameSignup')), findsOneWidget);
    expect(find.byKey(const Key('birthdateSignup')), findsOneWidget);
    expect(find.byKey(const Key('citySignup')), findsOneWidget);
    expect(find.byKey(const Key('dropdownButtonSignup')), findsOneWidget);
    expect(find.byKey(const Key('phoneSignup')), findsOneWidget);
    expect(find.byKey(const Key('emailSignup')), findsOneWidget);
    expect(find.byKey(const Key('passwordSignup')), findsOneWidget);
    expect(find.byKey(const Key('togglePasswordView')), findsOneWidget);
  });
  testWidgets(
      'GIVEN signup screen, WHEN screen is loaded, THEN toggle visibility icon should be present and isHiddenPassword should be true',
      (tester) async {
    await tester.pumpWidget(createWebSignupScreen());
    await tester.pumpAndSettle();

    final passwordTextField = find.descendant(
      of: find.byKey(const Key('passwordSignup')),
      matching: find.byType(EditableText),
    );
    await tester.ensureVisible(passwordTextField);
    final input = tester.widget<EditableText>(passwordTextField);
    expect(input.obscureText, isTrue);
  });
  testWidgets(
      'GIVEN signup screen, WHEN user tap on toggle password icon, THEN password should be visible',
      (tester) async {
    await tester.pumpWidget(createWebSignupScreen());
    await tester.pumpAndSettle();
    final togglePasswordViewIcon = find.byKey(const Key('togglePasswordView'));
    await tester.ensureVisible(togglePasswordViewIcon);
    await tester.tap(togglePasswordViewIcon);
    await tester.pump();
    final passwordTextField = find.descendant(
      of: find.byKey(const Key('passwordSignup')),
      matching: find.byType(EditableText),
    );
    await tester.pump();
    final input = tester.widget<EditableText>(passwordTextField);
    expect(input.obscureText, isFalse);
  });
  testWidgets(
      'GIVEN signup screen, WHEN user leaves empty text input fields, THEN he should see alert message',
      (tester) async {
    await tester.pumpWidget(createWebSignupScreen());
    await tester.pumpAndSettle();
    final signupButtonFinder = find.byKey(const Key('signupButton'));
    await tester.ensureVisible(signupButtonFinder);
    await tester.tap(signupButtonFinder);
    await tester.pumpAndSettle();
    expect(find.text('Please fill the required field.'), findsNWidgets(7));
  });
  testWidgets(
      'GIVEN signup screen, WHEN user enter name shorter than 4 characters, THEN he should see alert message',
      (tester) async {
    await tester.pumpWidget(createWebSignupScreen());
    await tester.pumpAndSettle();
    final nameFieldFinder = find.byKey(const Key('nameSignup'));
    await tester.enterText(nameFieldFinder, 'Ime');
    await tester.pumpAndSettle();
    final signupButtonFinder = find.byKey(const Key('signupButton'));
    await tester.ensureVisible(signupButtonFinder);
    await tester.tap(signupButtonFinder);
    await tester.pump();
    expect(find.text('Name must contain a minimum of 4 characters.'),
        findsOneWidget);
  });
  testWidgets(
      'GIVEN signup screen, WHEN user enter surname shorter than 4 characters, THEN he should see alert message',
      (tester) async {
    await tester.pumpWidget(createWebSignupScreen());
    await tester.pumpAndSettle();
    final nameFieldFinder = find.byKey(const Key('surnameSignup'));
    await tester.enterText(nameFieldFinder, 'Abc');
    await tester.pumpAndSettle();
    final signupButtonFinder = find.byKey(const Key('signupButton'));
    await tester.ensureVisible(signupButtonFinder);
    await tester.tap(signupButtonFinder);
    await tester.pump();
    expect(find.text('Surname must contain a minimum of 4 characters.'),
        findsOneWidget);
  });
  testWidgets(
      'GIVEN signup screen, WHEN user tap on dropdown list, THEN he should see list items',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWebSignupScreen());
    await tester.pumpAndSettle();

    final dropdown = find.byKey(const Key('dropdownButtonSignup'));

    await tester.tap(dropdown);
    await tester.pumpAndSettle();

    final dropdownItem = find.text('Student').last;

    await tester.tap(dropdownItem);
    await tester.pumpAndSettle();
  });
  testWidgets(
      'GIVEN signup screen, WHEN user enter phone number shorter than 9 characters, THEN he should see alert message',
      (tester) async {
    await tester.pumpWidget(createWebSignupScreen());
    await tester.pumpAndSettle();
    final nameFieldFinder = find.byKey(const Key('phoneSignup'));
    await tester.enterText(nameFieldFinder, '1123');
    await tester.pumpAndSettle();
    final signupButtonFinder = find.byKey(const Key('signupButton'));
    await tester.ensureVisible(signupButtonFinder);
    await tester.tap(signupButtonFinder);
    await tester.pump();
    expect(find.text('Phone number must contain a minimum of 9 numbers.'),
        findsOneWidget);
  });
  testWidgets(
      'GIVEN signup screen, WHEN user enter email in invalid format, THEN he should see alert message',
      (tester) async {
    await tester.pumpWidget(createWebSignupScreen());
    await tester.pumpAndSettle();
    final emailFieldFinder = find.byKey(const Key('emailSignup'));
    await tester.enterText(emailFieldFinder, 'testgmail.com');
    await tester.pumpAndSettle();
    final signupButtonFinder = find.byKey(const Key('signupButton'));
    await tester.ensureVisible(signupButtonFinder);
    await tester.tap(signupButtonFinder);
    await tester.pump();
    expect(find.text('Invalid email format'), findsOneWidget);

    await tester.enterText(emailFieldFinder, 'test@gmailcom');
    await tester.pumpAndSettle();
    await tester.tap(signupButtonFinder);
    await tester.pump();
    expect(find.text('Invalid email format'), findsOneWidget);

    await tester.enterText(emailFieldFinder, '@gmail.com');
    await tester.pumpAndSettle();
    await tester.tap(signupButtonFinder);
    await tester.pump();
    expect(find.text('Invalid email format'), findsOneWidget);
  });
  testWidgets(
      'GIVEN signup screen, WHEN user enter password in invalid format, THEN he should see alert message',
      (tester) async {
    await tester.pumpWidget(createWebSignupScreen());
    await tester.pumpAndSettle();
    final passwordFieldFinder = find.byKey(const Key('passwordSignup'));
    await tester.enterText(passwordFieldFinder, 'Hello');
    await tester.pumpAndSettle();
    final signupButtonFinder = find.byKey(const Key('signupButton'));
    await tester.ensureVisible(signupButtonFinder);
    await tester.tap(signupButtonFinder);
    await tester.pump();
    expect(
        find.text(
            'Password must contain a minimum of 8 characters, uppercase, lower case, number and special character.'),
        findsOneWidget);

    await tester.enterText(passwordFieldFinder, 'Helloworldinanawesomeway');
    await tester.pumpAndSettle();
    await tester.tap(signupButtonFinder);
    await tester.pump();
    expect(
        find.text(
            'Password must contain a minimum of 8 characters, uppercase, lower case, number and special character.'),
        findsOneWidget);

    await tester.enterText(passwordFieldFinder, 'HelloWorld');
    await tester.pumpAndSettle();
    await tester.tap(signupButtonFinder);
    await tester.pump();
    expect(
        find.text(
            'Password must contain a minimum of 8 characters, uppercase, lower case, number and special character.'),
        findsOneWidget);

    await tester.enterText(passwordFieldFinder, 'HelloWorld123');
    await tester.pumpAndSettle();
    await tester.tap(signupButtonFinder);
    await tester.pump();
    expect(
        find.text(
            'Password must contain a minimum of 8 characters, uppercase, lower case, number and special character.'),
        findsOneWidget);

    await tester.enterText(passwordFieldFinder, 'HelloWorld1!');
    await tester.pumpAndSettle();
    await tester.tap(signupButtonFinder);
    await tester.pump();
    expect(
        find.text(
            'Password must contain a minimum of 8 characters, uppercase, lower case, number and special character.'),
        findsNothing);
  });
}
