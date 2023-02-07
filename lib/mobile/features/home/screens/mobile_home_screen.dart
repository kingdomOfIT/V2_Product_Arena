import 'package:flutter/material.dart';

class MobileHomeScreen extends StatelessWidget {
  static const routeName = '/mobile-home';

  const MobileHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Home screen'),
      ),
    );
  }
}
