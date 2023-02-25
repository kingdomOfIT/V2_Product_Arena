import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: unused_import
import 'package:v2_product_arena/web/reusable_web_widgets/oldsidebar.dart';
// ignore: unused_import
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (MediaQuery.of(context).size.width > 920 &&
                                    MediaQuery.of(context).size.height > 790)
                                ? Image.asset(
                                    'assets/images/TopUI.png',
                                    //height: 200,
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                  )
                                : const SizedBox(),
                            (MediaQuery.of(context).size.width > 920 &&
                                    MediaQuery.of(context).size.height > 790)
                                ? const SizedBox(
                                    width: 50,
                                  )
                                : const SizedBox(),
                            (MediaQuery.of(context).size.width > 920)
                                ? RichText(
                                    text: TextSpan(
                                      text: 'Welcome to\n',
                                      style: GoogleFonts.notoSans(
                                        fontSize: 40,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Product Arena',
                                          style: GoogleFonts.notoSans(
                                            fontSize: 40,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Column(
                                    children: [
                                      Text(
                                        'Welcome to',
                                        style: GoogleFonts.notoSans(
                                          fontSize: 40,
                                        ),
                                      ),
                                      Text(
                                        'Product Arena',
                                        style: GoogleFonts.notoSans(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Text(
                            'Our goal is to recognise persistence, motivation and adaptability, that’s why we encourage you to dive into these materials and wish you the best of luck in your studies.',
                            style: GoogleFonts.outfit(
                              fontSize: 26,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: Text(
                            "Once you have gone through all the lessons you'll be able to take a test to show us what you have learned!",
                            style: GoogleFonts.outfit(
                              fontSize: 26,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    (MediaQuery.of(context).size.width > 920 &&
                            MediaQuery.of(context).size.height > 790)
                        ? Image.asset(
                            'assets/images/BottomQA.png',
                            height: 200,
                            width: MediaQuery.of(context).size.width * 0.5,
                            alignment: Alignment.centerRight,
                          )
                        : const SizedBox(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
