import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/web/features/home/screens/web_contact_screen.dart';
import 'package:v2_product_arena/web/features/home/screens/web_home_screen.dart';

import 'package:v2_product_arena/web/features/home/screens/web_lectures_screen.dart';
import 'package:v2_product_arena/web/features/home/screens/web_recent_lectures.dart';
import 'package:v2_product_arena/web/providers/web_auth_provider.dart';

late WebAuth auth;

Widget createWebHomeScreen() => ChangeNotifierProvider<WebAuth>(
      create: (context) {
        auth = WebAuth();
        return auth;
      },
      child: MaterialApp(
        routes: {
          '/web-lectures': (context) => const WebLecturesPage(),
          '/web-recent': (context) => const WebRecentLecturesPage(),
          '/web-contact': (context) => const WebContactScreen(),
          '/web-home': (context) => const WebHomeScreen(),
        },
        home: const WebHomeScreen(),
      ),
    );

final webHomeScreenButton = find.byKey(const Key('homescreenButton'));
final webRoleLecturesScreenButton = find.byKey(const Key('roleLecturesScreen'));
final webRecentLecturesButton = find.byKey(const Key('recentLecturesButton'));
final webContactFormButton = find.byKey(const Key('contactFormButton'));
void main() {
  testWidgets(
      'GIVEN web home screen, WHEN home screen is loaded, THEN user should see welcoming text',
      (tester) async {
    await tester.pumpWidget(createWebHomeScreen());
    await tester.pumpAndSettle();
    expect(find.text('Welcome to'), findsOneWidget);
    expect(find.text('Product Arena'), findsOneWidget);
    expect(
        find.text(
            'Our goal is to recognise persistence, motivation and adaptability, that’s why we encourage you to dive into these materials and wish you the best of luck in your studies.'),
        findsOneWidget);
    expect(
        find.text(
            "Once you have gone through all the lessons you'll be able to take a test to show us what you have learned!"),
        findsOneWidget);
  });
  testWidgets(
      'GIVEN web home screen, WHEN user tap on homescreen button, THEN user should be redirected to the homescreen',
      (tester) async {
    await tester.pumpWidget(createWebHomeScreen());
    await tester.pumpAndSettle();
    await tester.tap(webHomeScreenButton);
    await tester.pumpAndSettle();
    expect(
        find.text(
            "Once you have gone through all the lessons you'll be able to take a test to show us what you have learned!"),
        findsOneWidget);
  });
  testWidgets(
      'GIVEN web home screen, WHEN user tap on role lectures page button, THEN user should be redirected to the lectures page',
      (tester) async {
    await tester.pumpWidget(createWebHomeScreen());
    await tester.pumpAndSettle();
    await tester.tap(webRoleLecturesScreenButton);
    await tester.pumpAndSettle();
    expect(find.byType(WebLecturesPage), findsOneWidget);
  });
  testWidgets(
      'GIVEN web home screen, WHEN user tap on recent lectures page button, THEN user should be redirected to the recent lectures page',
      (tester) async {
    await tester.pumpWidget(createWebHomeScreen());
    await tester.pumpAndSettle();
    await tester.tap(webRecentLecturesButton);
    await tester.pumpAndSettle();
    expect(find.byType(WebRecentLecturesPage), findsOneWidget);
  });
  testWidgets(
      'GIVEN web home screen, WHEN user tap on contact us button, THEN user should be redirected to the contact us screen',
      (tester) async {
    await tester.pumpWidget(createWebHomeScreen());
    await tester.pumpAndSettle();
    await tester.tap(webContactFormButton);
    await tester.pumpAndSettle();
    expect(
        find.text(
            'You are more than welcome to leave your\nmessage and we will be in touch shortly.'),
        findsOneWidget);
  });
}
