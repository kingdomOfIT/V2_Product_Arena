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
  group('Mobile signup screen tests', () {
    testWidgets(
        'GIVEN mobile signup screen, WHEN widget is built, THEN all input fields should be visible',
        (tester) async {
      await tester.pumpWidget(createMobileSignupScreen());

      expect(find.byKey(const Key('nameTextField')), findsOneWidget);
      expect(find.byKey(const Key('surnameTextField')), findsOneWidget);
      expect(find.byKey(const Key('birthDateTextField')), findsOneWidget);
      expect(find.byKey(const Key('cityTextField')), findsOneWidget);
      expect(find.byKey(const Key('phoneTextField')), findsOneWidget);
      expect(find.byKey(const Key('emailTextField')), findsOneWidget);
      expect(find.byKey(const Key('passwordSignUpTextField')), findsOneWidget);
    });
    testWidgets(
        'GIVEN mobile signup screen, WHEN screen is loaded, THEN toggle visibility icon should be present and isHiddenPassword should be true',
        (tester) async {
      await tester.pumpWidget(createMobileSignupScreen());

      final passwordTextField = find.descendant(
        of: find.byKey(const Key('passwordSignUpTextField')),
        matching: find.byType(EditableText),
      );
      final input = tester.widget<EditableText>(passwordTextField);
      expect(input.obscureText, isTrue);
    });
    testWidgets(
        'GIVEN mobile signup screen, WHEN user tap on toggle password icon, THEN password should be visible',
        (tester) async {
      await tester.pumpWidget(createMobileSignupScreen());
      await tester.pumpAndSettle();
      final togglePasswordViewIcon =
          find.byKey(const Key('togglePasswordViewSignup'));
      await tester.ensureVisible(togglePasswordViewIcon);
      await tester.tap(togglePasswordViewIcon);
      await tester.pump();
      final passwordTextField = find.descendant(
        of: find.byKey(const Key('passwordSignUpTextField')),
        matching: find.byType(EditableText),
      );
      await tester.pump();
      final input = tester.widget<EditableText>(passwordTextField);
      expect(input.obscureText, isFalse);
    });
    testWidgets(
        'GIVEN mobile signup screen, WHEN user leaves empty text input fields, THEN he should see alert message',
        (tester) async {
      await tester.pumpWidget(createMobileSignupScreen());
      await tester.pumpAndSettle();
      final signupButtonFinder = find.byKey(const Key('createYourAccount'));
      await tester.ensureVisible(signupButtonFinder);
      await tester.tap(signupButtonFinder);
      await tester.pump();
      expect(find.text('Please fill the required field.'), findsNWidgets(7));
    });
    testWidgets(
        'GIVEN mobile signup screen, WHEN user enter name shorter than 4 characters, THEN he should see alert message',
        (tester) async {
      await tester.pumpWidget(createMobileSignupScreen());
      await tester.pumpAndSettle();
      final nameFieldFinder = find.byKey(const Key('nameTextField'));
      await tester.enterText(nameFieldFinder, 'Ime');
      await tester.pumpAndSettle();
      final signupButtonFinder = find.byKey(const Key('createYourAccount'));
      await tester.ensureVisible(signupButtonFinder);
      await tester.tap(signupButtonFinder);
      await tester.pump();
      expect(find.text('Name must contain a minimum of 4 characters.'),
          findsOneWidget);
    });
    testWidgets(
        'GIVEN mobile signup screen, WHEN user enter surname shorter than 4 characters, THEN he should see alert message',
        (tester) async {
      await tester.pumpWidget(createMobileSignupScreen());
      await tester.pumpAndSettle();
      final nameFieldFinder = find.byKey(const Key('surnameTextField'));
      await tester.enterText(nameFieldFinder, 'Abc');
      await tester.pumpAndSettle();
      final signupButtonFinder = find.byKey(const Key('createYourAccount'));
      await tester.ensureVisible(signupButtonFinder);
      await tester.tap(signupButtonFinder);
      await tester.pump();
      expect(find.text('Surname must contain a minimum of 4 characters.'),
          findsOneWidget);
    });
    testWidgets(
        'GIVEN mobile signup screen, WHEN user enter invalid birthdate format, THEN he should see alert message',
        (tester) async {
      await tester.pumpWidget(createMobileSignupScreen());
      await tester.pumpAndSettle();
      final nameFieldFinder = find.byKey(const Key('birthDateTextField'));
      await tester.enterText(nameFieldFinder, '01.01.2023');
      await tester.pumpAndSettle();
      final signupButtonFinder = find.byKey(const Key('createYourAccount'));
      await tester.ensureVisible(signupButtonFinder);
      await tester.tap(signupButtonFinder);
      await tester.pump();
      expect(find.text('Invalid birth date format. Valid format: dd-mm-yyyy'),
          findsOneWidget);
    });
    testWidgets(
        'GIVEN mobile signup screen, WHEN user tap on dropdown list, THEN he should see list items',
        (WidgetTester tester) async {
      await tester.pumpWidget(createMobileSignupScreen());

      final dropdown = find.byKey(const ValueKey('dropDownButton'));

      await tester.tap(dropdown);
      await tester.pumpAndSettle();

      final dropdownItem = find.text('Student').last;

      await tester.tap(dropdownItem);
      await tester.pumpAndSettle();
    });
    testWidgets(
        'GIVEN mobile signup screen, WHEN user enter phone number shorter than 9 characters, THEN he should see alert message',
        (tester) async {
      await tester.pumpWidget(createMobileSignupScreen());
      await tester.pumpAndSettle();
      final nameFieldFinder = find.byKey(const Key('phoneTextField'));
      await tester.enterText(nameFieldFinder, '1123');
      await tester.pumpAndSettle();
      final signupButtonFinder = find.byKey(const Key('createYourAccount'));
      await tester.ensureVisible(signupButtonFinder);
      await tester.tap(signupButtonFinder);
      await tester.pump();
      expect(find.text('Phone number must contain a minimum of 9 numbers.'),
          findsOneWidget);
    });
    testWidgets(
        'GIVEN mobile signup screen, WHEN user enter email without @, THEN he should see alert message',
        (tester) async {
      await tester.pumpWidget(createMobileSignupScreen());
      await tester.pumpAndSettle();
      final emailFieldFinder = find.byKey(const Key('emailTextField'));
      await tester.enterText(emailFieldFinder, 'testgmail.com');
      await tester.pumpAndSettle();
      final signupButtonFinder = find.byKey(const Key('createYourAccount'));
      await tester.ensureVisible(signupButtonFinder);
      await tester.tap(signupButtonFinder);
      await tester.pump();
      expect(find.text('Invalid email format'), findsOneWidget);
    });
    testWidgets(
        'GIVEN mobile signup screen, WHEN user enter email without dot, THEN he should see alert message',
        (tester) async {
      await tester.pumpWidget(createMobileSignupScreen());
      await tester.pumpAndSettle();
      final emailFieldFinder = find.byKey(const Key('emailTextField'));
      await tester.enterText(emailFieldFinder, 'test@gmailcom');
      await tester.pumpAndSettle();
      final signupButtonFinder = find.byKey(const Key('createYourAccount'));
      await tester.ensureVisible(signupButtonFinder);
      await tester.tap(signupButtonFinder);
      await tester.pump();
      expect(find.text('Invalid email format'), findsOneWidget);
    });
    testWidgets(
        'GIVEN mobile signup screen, WHEN user enter email without string before @, THEN he should see alert message',
        (tester) async {
      await tester.pumpWidget(createMobileSignupScreen());
      await tester.pumpAndSettle();
      final emailFieldFinder = find.byKey(const Key('emailTextField'));
      await tester.enterText(emailFieldFinder, '@gmail.com');
      await tester.pumpAndSettle();
      final signupButtonFinder = find.byKey(const Key('createYourAccount'));
      await tester.ensureVisible(signupButtonFinder);
      await tester.tap(signupButtonFinder);
      await tester.pump();
      expect(find.text('Invalid email format'), findsOneWidget);
    });
    testWidgets(
        'GIVEN mobile signup screen, WHEN user enter email in valid format, THEN he shouldn\'t see alert message',
        (tester) async {
      await tester.pumpWidget(createMobileSignupScreen());
      await tester.pumpAndSettle();
      final emailFieldFinder = find.byKey(const Key('emailTextField'));
      await tester.enterText(emailFieldFinder, 'test@gmail.com');
      await tester.pumpAndSettle();
      final signupButtonFinder = find.byKey(const Key('createYourAccount'));
      await tester.ensureVisible(signupButtonFinder);
      await tester.tap(signupButtonFinder);
      await tester.pump();
      expect(find.text('Invalid email format'), findsNothing);
    });
    testWidgets(
        'GIVEN mobile signup screen, WHEN user enter password without number and special character, THEN he should see alert message',
        (tester) async {
      await tester.pumpWidget(createMobileSignupScreen());
      await tester.pumpAndSettle();
      final passwordFieldFinder =
          find.byKey(const Key('passwordSignUpTextField'));
      await tester.ensureVisible(passwordFieldFinder);
      await tester.tap(passwordFieldFinder);
      await tester.enterText(passwordFieldFinder, 'Hello');
      await tester.pumpAndSettle();
      final signupButtonFinder = find.byKey(const Key('createYourAccount'));
      await tester.ensureVisible(signupButtonFinder);
      await tester.tap(signupButtonFinder);
      await tester.pump();
      expect(
          find.text(
              'Password must contain a minimum of 8 characters, uppercase, lower case, number and special character.'),
          findsOneWidget);
    });
    testWidgets(
        'GIVEN mobile signup screen, WHEN user enter password without capital letter, THEN he should see alert message',
        (tester) async {
      await tester.pumpWidget(createMobileSignupScreen());
      await tester.pumpAndSettle();
      final passwordFieldFinder =
          find.byKey(const Key('passwordSignUpTextField'));
      await tester.ensureVisible(passwordFieldFinder);
      await tester.tap(passwordFieldFinder);
      await tester.enterText(passwordFieldFinder, 'hello123!');
      await tester.pumpAndSettle();
      final signupButtonFinder = find.byKey(const Key('createYourAccount'));
      await tester.ensureVisible(signupButtonFinder);
      await tester.tap(signupButtonFinder);
      await tester.pump();
      expect(
          find.text(
              'Password must contain a minimum of 8 characters, uppercase, lower case, number and special character.'),
          findsOneWidget);
    });

    testWidgets(
        'GIVEN mobile signup screen, WHEN user enter password longer than 16 characters, THEN he should see alert message',
        (tester) async {
      await tester.pumpWidget(createMobileSignupScreen());
      await tester.pumpAndSettle();
      final passwordFieldFinder =
          find.byKey(const Key('passwordSignUpTextField'));
      await tester.ensureVisible(passwordFieldFinder);
      await tester.tap(passwordFieldFinder);
      await tester.enterText(passwordFieldFinder, 'Helloworldinanawesomeway');
      await tester.pumpAndSettle();
      final signupButtonFinder = find.byKey(const Key('createYourAccount'));
      await tester.ensureVisible(signupButtonFinder);
      await tester.tap(signupButtonFinder);
      await tester.pump();
      expect(
          find.text(
              'Password must contain a minimum of 8 characters, uppercase, lower case, number and special character.'),
          findsOneWidget);
    });

    testWidgets(
        'GIVEN mobile signup screen, WHEN user enter password without special character, THEN he should see alert message',
        (tester) async {
      await tester.pumpWidget(createMobileSignupScreen());
      await tester.pumpAndSettle();
      final passwordFieldFinder =
          find.byKey(const Key('passwordSignUpTextField'));
      await tester.ensureVisible(passwordFieldFinder);
      await tester.tap(passwordFieldFinder);
      await tester.enterText(passwordFieldFinder, 'HelloWorld123');
      await tester.pumpAndSettle();
      final signupButtonFinder = find.byKey(const Key('createYourAccount'));
      await tester.ensureVisible(signupButtonFinder);
      await tester.tap(signupButtonFinder);
      await tester.pump();
      expect(
          find.text(
              'Password must contain a minimum of 8 characters, uppercase, lower case, number and special character.'),
          findsOneWidget);
    });

    testWidgets(
        'GIVEN mobile signup screen, WHEN user enter valid password, THEN he shouldn\'t see alert message',
        (tester) async {
      await tester.pumpWidget(createMobileSignupScreen());
      await tester.pumpAndSettle();
      final passwordFieldFinder =
          find.byKey(const Key('passwordSignUpTextField'));
      await tester.ensureVisible(passwordFieldFinder);
      await tester.tap(passwordFieldFinder);
      await tester.enterText(passwordFieldFinder, 'HelloWorld123!');
      await tester.pumpAndSettle();
      final signupButtonFinder = find.byKey(const Key('createYourAccount'));
      await tester.ensureVisible(signupButtonFinder);
      await tester.tap(signupButtonFinder);
      await tester.pump();
      expect(
          find.text(
              'Password must contain a minimum of 8 characters, uppercase, lower case, number and special character.'),
          findsNothing);
    });
    testWidgets(
        'GIVEN mobile signup screen, WHEN user that already have account click on login, THEN he should be redirected to login screen',
        (tester) async {
      await tester.pumpWidget(createMobileSignupScreen());
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('loginRedirection')), findsOneWidget);
      final loginButtonFinder = find.byKey(const Key('loginRedirection'));
      await tester.ensureVisible(loginButtonFinder);
      await tester.tap(find.byKey(const Key('loginRedirection')));
      await tester.pumpAndSettle();
      expect(find.byType(MobileLoginScreen), findsOneWidget);
    });
  });
}
