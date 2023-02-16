import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/email_verification_screen.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/email_verified_screen.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/mobile_login_screen.dart';
import 'package:v2_product_arena/mobile/providers/mobile_auth_provider.dart';

late MobileAuth auth;

Widget createMobileEmailVerificationScreen() =>
    ChangeNotifierProvider<MobileAuth>(
      create: (context) {
        auth = MobileAuth();
        return auth;
      },
      child: MaterialApp(
        routes: {
          '/mobile-login': (context) => const MobileLoginScreen(),
          '/email-verified': (context) => const EmailVerified(),
        },
        home: const EmailVerificationScreen(),
      ),
    );

void main() {
  group('Mobile email verification screen tests', () {
    testWidgets(
        'GIVEN mobile email verification screen, WHEN widget is built, THEN all input fields and buttons should be visible',
        (tester) async {
      await tester.pumpWidget(createMobileEmailVerificationScreen());
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('emailverificationField1')), findsOneWidget);
      expect(find.byKey(const Key('emailverificationField2')), findsOneWidget);
      expect(find.byKey(const Key('emailverificationField3')), findsOneWidget);
      expect(find.byKey(const Key('emailverificationField4')), findsOneWidget);
      expect(find.byKey(const Key('emailverificationField5')), findsOneWidget);
      expect(find.byKey(const Key('emailverificationField6')), findsOneWidget);
      expect(find.byKey(const Key('emailVerifyButton')), findsOneWidget);
      expect(find.byKey(const Key('loginRedirection')), findsOneWidget);
    });
    testWidgets(
        'GIVEN mobile email verification screen, WHEN widget is built, THEN all required text should be visible',
        (tester) async {
      await tester.pumpWidget(createMobileEmailVerificationScreen());
      await tester.pumpAndSettle();

      expect(find.text('Just to be sure...'), findsOneWidget);
      expect(find.text('We’ve sent a 6-digit code to your e-mail'),
          findsOneWidget);
      expect(find.text('Already have an account?'), findsOneWidget);
    });
    testWidgets(
        'GIVEN mobile email verification screen, WHEN widget is built, THEN Tech387 logo should be visible on screen',
        (tester) async {
      await tester.pumpWidget(createMobileEmailVerificationScreen());
      await tester.pumpAndSettle();

      final imageWidget = find.byType(Image).evaluate().first.widget as Image;
      expect(imageWidget.image, isA<AssetImage>());
      final assetImage = imageWidget.image as AssetImage;
      expect(assetImage.assetName, equals('assets/images/tech.png'));
    });
    testWidgets(
        'GIVEN mobile email verification screen, WHEN user tap on log in button, THEN he should be redirected to the login screen',
        (tester) async {
      await tester.pumpWidget(createMobileEmailVerificationScreen());
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('loginRedirection')));
      await tester.pumpAndSettle();
      expect(find.text('Welcome to'), findsOneWidget);
      expect(find.text('Product Arena'), findsOneWidget);
    });
  });
}
