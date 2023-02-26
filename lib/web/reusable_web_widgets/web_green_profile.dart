import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_login_screen.dart';

class WebProfilePopup extends StatelessWidget {
  const WebProfilePopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * (70 / 1440),
      alignment: Alignment.topRight,
      child: PopupMenuButton<int>(
        icon: Image.asset('assets/images/Profileicon.png'),
        iconSize: MediaQuery.of(context).size.width * (50 / 1440),
        itemBuilder: (context) => [
          PopupMenuItem(
            //value: 1,
            onTap: () async {
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
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.logout),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * (10 / 1440),
                    ),
                    const Text("Logout"),
                  ],
                ),
              ],
            ),
          ),
        ],
        offset: const Offset(-50, 65),
        color: Colors.white,
      ),
    );
  }
}
