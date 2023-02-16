import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/email_verified_screen.dart';

void main() {
  group('Mobile email verified screen tests', () {
    testWidgets(
        'GIVEN mobile email verified screen, WHEN widget is built, THEN check circle image should be visible',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: Verified()));
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final imageWidget = find.byType(Image).evaluate().first.widget as Image;
      expect(imageWidget.image, isA<AssetImage>());
      final assetImage = imageWidget.image as AssetImage;
      expect(assetImage.assetName, equals('assets/images/checkcircle.png'));
    });
    testWidgets(
        'GIVEN mobile email verified screen, WHEN widget is built, THEN all required text should be visible',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: Verified()));
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(find.text('Email verified'), findsOneWidget);
      expect(find.text('Your email is successfully verified'), findsOneWidget);
    });
    testWidgets(
        'GIVEN mobile email verified screen, WHEN widget is built, THEN Tech387 logo image should be visible',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: Verified()));
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final imageWidget = find.byType(Image).evaluate().last.widget as Image;
      expect(imageWidget.image, isA<AssetImage>());
      final assetImage = imageWidget.image as AssetImage;
      expect(assetImage.assetName, equals('assets/images/PAlogowhite.png'));
    });
  });
}
