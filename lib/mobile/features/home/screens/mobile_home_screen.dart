import 'package:flutter/material.dart';
import 'package:v2_product_arena/mobile/providers/mobile_auth_provider.dart';
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/custom_button.dart';
import 'package:provider/provider.dart';

class MobileHomeScreen extends StatelessWidget {
  static const routeName = '/mobile-home';

  const MobileHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Home screen'),
      ),
      body: Center(
        child: CustomButton(
            key: const Key('logOutButton'),
            content: const Text(
              'Log Out',
              style: TextStyle(color: Colors.white),
            ),
            buttonFunction: () =>
                Provider.of<MobileAuth>(context, listen: false)
                    .signOutCurrentUser(),
            color: Colors.black),
      ),
    );
  }
}
