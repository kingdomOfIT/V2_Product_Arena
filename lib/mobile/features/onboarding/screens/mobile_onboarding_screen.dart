import 'package:flutter/material.dart';

class MobileOnboardingScreen extends StatelessWidget {
  static const routeName = '/mobile-onboarding';

  const MobileOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile onboaring screen'),
      ),
    );
  }
}
