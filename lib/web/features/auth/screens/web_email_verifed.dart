// ignore_for_file: use_key_in_widget_constructors, depend_on_referenced_packages, avoid_print

import 'package:flutter/material.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_login_screen.dart';

import '../../../reusable_web_widgets/web_appbar.dart';
import '../../../reusable_web_widgets/web_footer.dart';

class Verifed extends StatelessWidget {
  static const routeName = '/verifed';

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.05),
        child: WebAppBar(
          text: 'Login',
          routeName: WebLoginScreen.routeName,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  width: maxwidth,
                  height: 1133,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/webbackground.png'),
                        fit: BoxFit.cover),
                  ),
                  child: Center(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      width: MediaQuery.of(context).size.width * 0.51,
                      height: 465,
                      child: Column(
                        children: [
                          const SizedBox(height: 116),
                          SizedBox(
                            width: 102,
                            height: 102,
                            child: Image.asset('assets/images/checkcircle.png'),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            'Email verified',
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Text(
                            'Your email is successfully verified',
                            style: TextStyle(
                              color: Color(0xFF605D66),
                              fontSize: 32,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 23),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 45),
            const WebFooter(),
          ],
        ),
      ),
    );
  }
}
