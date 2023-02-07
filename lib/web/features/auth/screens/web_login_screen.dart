import 'package:flutter/material.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_signup_screen.dart';
import 'package:v2_product_arena/web/features/auth/widgets/web_login_form.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_appbar.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_footer.dart';

class WebLoginScreen extends StatelessWidget {
  static const routeName = '/web-login';

  const WebLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
        child: WebAppBar(
          text: 'Sign Up',
          routeName: WebSignUpScreen.routeName,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Image.asset(
                'assets/images/PAlogowhite.png',
                width: 80,
                height: 80,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Welcome to',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              const Text(
                'Product Arena',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                'All great things take time to accomplish',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  color: Color(0xFF605D66),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              const WebLoginForm(),
            ],
          ),
          const WebFooter(),
        ],
      ),
    );
  }
}
