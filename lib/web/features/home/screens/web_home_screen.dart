import 'package:flutter/material.dart';

class WebHomeScreen extends StatelessWidget {
  static const routeName = '/web-home';

  const WebHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web home screen'),
      ),
    );
  }
}
