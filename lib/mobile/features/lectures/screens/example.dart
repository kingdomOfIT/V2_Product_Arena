import 'package:flutter/material.dart';
import 'package:v2_product_arena/mobile/features/lectures/screens/welcome_lectures_screen.dart';
import 'package:v2_product_arena/mobile/features/onboarding/widgets/form_button.dart';

class ExampleLectures extends StatelessWidget {
  const ExampleLectures({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FormButton(
          backgroundColor: Colors.black,
          borderColor: Colors.black,
          text: 'Dalje',
          textColor: Colors.white,
          onPressed: () {
            Navigator.of(context).pushNamed(WelcomeLecturesScreen.routeName);
          },
          buttonHeight: 50,
          buttonWidth: 90,
        ),
      ),
    );
  }
}
