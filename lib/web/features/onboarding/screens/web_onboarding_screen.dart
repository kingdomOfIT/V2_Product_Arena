import 'package:flutter/material.dart';

class WebOnboardingScreen extends StatelessWidget {
  static const routeName = '/web-onboarding';

  const WebOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web onboarding screen'),
      ),
    );
  }
}
