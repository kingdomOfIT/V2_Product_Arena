import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_homepage_sidebar.dart';

import '../../../../constants/global_variables.dart';

class WebHomeScreen extends StatelessWidget {
  static const routeName = '/web-home';

  const WebHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        children: [
          const WebSideBar(),
          Container(
            color: Colors.white,
            width: maxwidth * (1130 / 1440),
            child: Column(
              children: [
                const GreenProfileIcon(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: maxwidth * (250 / 1440),
                      child: Image.asset('assets/images/TopUI.png'),
                    ),
                    SizedBox(
                      width: maxwidth * (90 / 1440),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to',
                          style: GoogleFonts.notoSans(
                              fontSize: maxwidth * (60 / 1440),
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          'Product Arena',
                          style: GoogleFonts.notoSans(
                              fontSize: maxwidth * (60 / 1440),
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  'Our goal is to recognise persistence, motivation and adaptability, that’s why we encourage you to dive into these materials and wish you the best of luck in your studies.',
                  style: GoogleFonts.outfit(
                    fontSize: maxwidth * (32 / 1440),
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Once you have gone through all the lessons you’ll be able to take a test to show us what you have learned!',
                  style: GoogleFonts.outfit(
                    fontSize: maxwidth * (32 / 1440),
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: maxwidth * (250 / 1440),
                    child: Image.asset('assets/images/BottomQA.png'),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
