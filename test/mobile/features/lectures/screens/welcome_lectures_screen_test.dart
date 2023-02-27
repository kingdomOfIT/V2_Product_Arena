import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/mobile/features/lectures/screens/welcome_lectures_screen.dart';
import 'package:v2_product_arena/mobile/providers/mobile_auth_provider.dart';

late MobileAuth auth;

Widget createMobileWelcomeLecturesScreen() =>
    ChangeNotifierProvider<MobileAuth>(
      create: (context) {
        auth = MobileAuth();
        return auth;
      },
      child: const MaterialApp(
          // home: WelcomeLecturesScreen(),
          ),
    );
void main() {
  testWidgets('welcome lectures screen ...', (tester) async {
    await tester.pumpWidget(createMobileWelcomeLecturesScreen());
    await tester.pumpAndSettle();
    final button = find.text('Next');
    await tester.tap(button);
    await tester.pumpAndSettle();
  });
}
