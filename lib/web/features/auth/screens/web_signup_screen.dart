import 'package:flutter/material.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_login_screen.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_appbar.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_footer.dart';

class WebSignUpScreen extends StatelessWidget {
  static const routeName = '/web-signup';

  const WebSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
        child: WebAppBar(
          text: 'Login',
          routeName: WebLoginScreen.routeName,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          const WebFooter(),
        ],
      ),
    );
  }
}
