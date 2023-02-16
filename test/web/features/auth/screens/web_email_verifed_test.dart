import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_email_verifed.dart';

void main() {
  group('Web email verified screen tests', () {
    testWidgets(
        'GIVEN web email verified screen, WHEN screen loads, THEN check circle image should be visible',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: Verifed()));
      await tester.pumpAndSettle(const Duration(seconds: 5));
      final imageFinder = find.byWidgetPredicate((widget) =>
          widget is DecoratedBox &&
          widget.decoration is BoxDecoration &&
          (widget.decoration as BoxDecoration).image is DecorationImage &&
          ((widget.decoration as BoxDecoration).image as DecorationImage).image
              is AssetImage &&
          (((widget.decoration as BoxDecoration).image as DecorationImage).image
                      as AssetImage)
                  .assetName ==
              'assets/images/webbackground.png');

      // Verify that the widget is present on the screen
      expect(imageFinder, findsOneWidget);
    });
    testWidgets(
        'GIVEN web email verified screen, WHEN screen loads, THEN all required text should be visible',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: Verifed()));
      await tester.pumpAndSettle(const Duration(seconds: 5));

      expect(find.text('Email verified'), findsOneWidget);
      expect(find.text('Your email is successfully verified'), findsOneWidget);
    });
    testWidgets(
        'GIVEN web email verified screen, WHEN screen loads, THEN check circle image should be visible',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: Verifed()));
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final imageWidget = find.byType(Image).evaluate().last.widget as Image;
      expect(imageWidget.image, isA<AssetImage>());
      final assetImage = imageWidget.image as AssetImage;
      expect(assetImage.assetName, equals('assets/images/PAlogowhite.png'));
    });
  });
}
