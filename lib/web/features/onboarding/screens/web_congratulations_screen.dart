import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_login_screen.dart';
import 'package:v2_product_arena/web/features/home/screens/web_home_screen.dart';

import '../../../reusable_web_widgets/web_footer.dart';
import '../../../reusable_web_widgets/web_ob_appbar.dart';

class WebCongratulationsScreen extends StatefulWidget {
  static const routeName = '/web-congratulations';
  const WebCongratulationsScreen({super.key});

  @override
  State<WebCongratulationsScreen> createState() =>
      _WebCongratulationsScreenState();
}

class _WebCongratulationsScreenState extends State<WebCongratulationsScreen> {
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Scaffold(
            appBar: PreferredSize(
                preferredSize:
                    Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
                child: WebOBAppBar(text: 'Tech387')),
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height:
                            (476 / 1255) * MediaQuery.of(context).size.height,
                      ),
                      Image.asset('assets/images/checkcircle.png'),
                      Text(
                        'Congratulations',
                        style: GoogleFonts.notoSans(
                            fontSize:
                                (60 / 1440) * MediaQuery.of(context).size.width,
                            fontWeight: FontWeight.w400),
                      ),
                      Text(
                        'You\'ve successfully created an account',
                        style: GoogleFonts.notoSans(
                            fontSize:
                                (32 / 1440) * MediaQuery.of(context).size.width,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF605D66)),
                      ),
                      SizedBox(
                        height:
                            (313 / 1255) * MediaQuery.of(context).size.height,
                      ),
                      const WebFooter()
                    ],
                  ),
                ),
              ),
            ),
          )
        : const WebLoginScreen();
  }
}
