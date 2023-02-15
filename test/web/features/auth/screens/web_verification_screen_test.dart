import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_email_verifed.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_login_screen.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_verification_screen.dart';
import 'package:v2_product_arena/web/providers/web_auth_provider.dart';

late WebAuth auth;

Widget createWebEmailVerificationScreen() => ChangeNotifierProvider<WebAuth>(
      create: (context) {
        auth = WebAuth();
        return auth;
      },
      child: MaterialApp(
        routes: {
          '/web-login': (context) => const WebLoginScreen(),
          '/email-verified': (context) => const WebEmailVerified(),
        },
        home: SignupConfirmation(),
      ),
    );

void main() {
  group('Web email verification screen tests', () {
    testWidgets(
        'GIVEN web email verification screen, WHEN widget is built, THEN all input fields and buttons should be visible',
        (tester) async {
      await tester.pumpWidget(createWebEmailVerificationScreen());
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('verificationField1')), findsOneWidget);
      expect(find.byKey(const Key('verificationField2')), findsOneWidget);
      expect(find.byKey(const Key('verificationField3')), findsOneWidget);
      expect(find.byKey(const Key('verificationField4')), findsOneWidget);
      expect(find.byKey(const Key('verificationField5')), findsOneWidget);
      expect(find.byKey(const Key('verificationField6')), findsOneWidget);
      expect(find.byKey(const Key('verifyButton')), findsOneWidget);
    });
    testWidgets(
        'GIVEN web email verification screen, WHEN widget is built, THEN all required text should be visible',
        (tester) async {
      await tester.pumpWidget(createWebEmailVerificationScreen());
      await tester.pumpAndSettle();

      expect(find.text('Just to be sure...'), findsOneWidget);
      expect(find.text('We’ve sent a 6-digit code to your e-mail'),
          findsOneWidget);
    });
    testWidgets(
        'GIVEN web email verification screen, WHEN widget is built, THEN Tech387 logo should be visible on screen',
        (tester) async {
      await tester.pumpWidget(createWebEmailVerificationScreen());
      await tester.pumpAndSettle();

      final imageWidget = find.byType(Image).evaluate().first.widget as Image;
      expect(imageWidget.image, isA<AssetImage>());
      final assetImage = imageWidget.image as AssetImage;
      expect(assetImage.assetName, equals('assets/images/PAlogowhite.png'));
    });
  });
}
