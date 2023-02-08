import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
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
  testWidgets(
      'GIVEN signup screen, WHEN widget is built, THEN all input fields should be visible',
      (tester) async {
    await tester.pumpWidget(createMobileSignupScreen());

    expect(find.byKey(const Key('nameTextField')), findsOneWidget);
    expect(find.byKey(const Key('surnameTextField')), findsOneWidget);
    expect(find.byKey(const Key('birthDateTextField')), findsOneWidget);
    expect(find.byKey(const Key('cityTextField')), findsOneWidget);
    expect(find.byKey(const Key('phoneTextField')), findsOneWidget);
    expect(find.byKey(const Key('emailTextField')), findsOneWidget);
    expect(find.byKey(const Key('passwordTextField')), findsOneWidget);
  });
  testWidgets(
      'GIVEN signup screen, WHEN screen is loaded, THEN toggle visibility icon should be present and isHiddenPassword should be true',
      (tester) async {
    // Add the `LoginForm` widget to the widget tree
    await tester.pumpWidget(createMobileSignupScreen());

    final passwordTextField = find.descendant(
      of: find.byKey(const Key('passwordTextField')),
      matching: find.byType(EditableText),
    );
    final input = tester.widget<EditableText>(passwordTextField);
    expect(input.obscureText, isTrue);
  });
  testWidgets(
      'GIVEN signup screen, WHEN user tap on toggle password icon, THEN password should be visible',
      (tester) async {
    await tester.pumpWidget(createMobileSignupScreen());
    await tester.pumpAndSettle();
    final togglePasswordViewIcon = find.byKey(const Key('togglePasswordView'));
    await tester.ensureVisible(togglePasswordViewIcon);
    await tester.tap(togglePasswordViewIcon);
    await tester.pump();
    final passwordTextField = find.descendant(
      of: find.byKey(const Key('passwordTextField')),
      matching: find.byType(EditableText),
    );
    await tester.pump();
    final input = tester.widget<EditableText>(passwordTextField);
    expect(input.obscureText, isFalse);
  });
  testWidgets(
      'GIVEN signup screen, WHEN user leaves empty text input fields, THEN he should see alert message',
      (tester) async {
    await tester.pumpWidget(createMobileSignupScreen());
    await tester.pumpAndSettle();
    final signupButtonFinder = find.byKey(const Key('signupButton'));
    await tester.ensureVisible(signupButtonFinder);
    await tester.tap(signupButtonFinder);
    await tester.pump();
    expect(find.text('Please fill the required field.'), findsNWidgets(7));
  });
  testWidgets(
      'GIVEN signup screen, WHEN user enter name shorter than 4 characters, THEN he should see alert message',
      (tester) async {
    await tester.pumpWidget(createMobileSignupScreen());
    await tester.pumpAndSettle();
    final nameFieldFinder = find.byKey(const Key('nameTextField'));
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
    await tester.pumpWidget(createMobileSignupScreen());
    await tester.pumpAndSettle();
    final nameFieldFinder = find.byKey(const Key('surnameTextField'));
    await tester.enterText(nameFieldFinder, 'Abc');
    await tester.pumpAndSettle();
    final signupButtonFinder = find.byKey(const Key('signupButton'));
    await tester.ensureVisible(signupButtonFinder);
    await tester.tap(signupButtonFinder);
    await tester.pump();
    expect(find.text('Surname must contain a minimum of 4 characters.'),
        findsOneWidget);
  });
  // TODO: validacija za birthdate
  testWidgets(
      'GIVEN signup screen, WHEN user tap on dropdown list, THEN he should see list items',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(createMobileSignupScreen());

    final dropdown = find.byKey(const ValueKey('dropdownButton'));

    await tester.tap(dropdown);
    await tester.pumpAndSettle();

    final dropdownItem = find.text('Student').last;

    await tester.tap(dropdownItem);
    await tester.pumpAndSettle();
  });
  // TODO: validacija za broj telefona - da Mirza napravi validaciju u Flutteru, kao sto ima i na backendu
  testWidgets(
      'GIVEN signup screen, WHEN user enter email in invalid format, THEN he should see alert message',
      (tester) async {
    await tester.pumpWidget(createMobileSignupScreen());
    await tester.pumpAndSettle();
    final emailFieldFinder = find.byKey(const Key('emailTextField'));
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
    await tester.pumpWidget(createMobileSignupScreen());
    await tester.pumpAndSettle();
    final passwordFieldFinder = find.byKey(const Key('passwordTextField'));
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
  testWidgets(
      'GIVEN signup screen, WHEN widget is built, THEN all input fields should be visible',
      (tester) async {
    await tester.pumpWidget(createMobileSignupScreen());
    expect(find.byKey(const Key('loginRedirection')), findsOneWidget);
    final loginButtonFinder = find.byKey(const Key('loginRedirection'));
    await tester.ensureVisible(loginButtonFinder);
    await tester.tap(find.byKey(const Key('loginRedirection')));
    await tester.pumpAndSettle();
    expect(find.byType(MobileLoginScreen), findsOneWidget);
  });
}
