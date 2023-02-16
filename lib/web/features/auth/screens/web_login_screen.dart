import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_signup_screen.dart';
import 'package:v2_product_arena/web/features/auth/widgets/web_login_form.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_appbar.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_footer.dart';

class WebLoginScreen extends StatelessWidget {
  static const routeName = '/web-login';

  const WebLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isScrollable = false;
    if (MediaQuery.of(context).size.height < 770) {
      isScrollable = true;
    } else {
      isScrollable = false;
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.06),
        child: WebAppBar(
          text: 'Sign Up',
          routeName: WebSignUpScreen.routeName,
        ),
      ),
      body: isScrollable
          ? SingleChildScrollView(
              child: Column(
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
                      Text(
                        'Welcome to',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: 30,
                        ),
                      ),
                      Text(
                        'Product Arena',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.notoSans(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'All great things take time to accomplish',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.outfit(
                          fontSize: 24,
                          color: const Color(0xFF605D66),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const WebLoginForm(),
                    ],
                  ),
                  const WebFooter(),
                ],
              ),
            )
          : Column(
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
                    Text(
                      'Welcome to',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      'Product Arena',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.notoSans(
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'All great things take time to accomplish',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.outfit(
                        fontSize: 24,
                        color: const Color(0xFF605D66),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const WebLoginForm(),
                  ],
                ),
                const WebFooter(),
              ],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Column(
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
                  Text(
                    'Welcome to',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    'Product Arena',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSans(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'All great things take time to accomplish',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      color: const Color(0xFF605D66),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const WebLoginForm(),
                ],
              ),
            ),
    );
  }
}
