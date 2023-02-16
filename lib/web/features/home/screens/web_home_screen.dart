import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_login_screen.dart';

class WebHomeScreen extends StatelessWidget {
  static const routeName = '/web-home';

  const WebHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web home screen'),
      ),
      body: Center(
        child: ElevatedButton(
          key: const Key('logOutButton'),
          onPressed: () async {
            try {
              final res = await Amplify.Auth.signOut();
              safePrint(res);
              // ignore: use_build_context_synchronously
              Navigator.of(context)
                  .pushReplacementNamed(WebLoginScreen.routeName);
            } on AuthException catch (e) {
              safePrint(e.message);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            minimumSize: const Size(200, 200),
          ),
          child: const Text('LogOut'),
        ),
      ),
    );
  }
}
