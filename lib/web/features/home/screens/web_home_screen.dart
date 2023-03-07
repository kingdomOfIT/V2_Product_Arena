import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_homepage_sidebar.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_profile.dart';

class WebHomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const WebHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        children: [
          const WebSideBar(),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: maxwidth * (1130 / 1440),
            child: Column(
              children: [
                const WebProfile(),
                SizedBox(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Image.asset(
                              'assets/images/TopUI.png',
                              //height: 200,
                              width: maxwidth * (200 / 1440),
                              height: MediaQuery.of(context).size.height *
                                  (200 / 1094),
                            ),
                          ),
                          SizedBox(
                            width: maxwidth * (100 / 1440),
                          ),
                          SizedBox(
                            width: maxwidth * (430 / 1440),
                            height: MediaQuery.of(context).size.height *
                                (160 / 1094),
                            child: RichText(
                              text: TextSpan(
                                text: 'Welcome to\n',
                                style: GoogleFonts.outfit(
                                  fontSize: MediaQuery.of(context).size.height *
                                      (55 / 1094),
                                  color: Colors.black,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'Product Arena',
                                    style: GoogleFonts.outfit(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              (55 / 1094),
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height * (20 / 1094),
                      ),
                      SizedBox(
                        width: maxwidth * (700 / 1440),
                        height:
                            MediaQuery.of(context).size.height * (160 / 1094),
                        child: Text(
                          'Our goal is to recognise persistence, motivation and adaptability, that\'s why we encourage you to dive into these materials and wish you the best of luck in your studies.',
                          style: GoogleFonts.outfit(
                            fontSize: MediaQuery.of(context).size.height *
                                (28 / 1094),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.height * (80 / 1094),
                        width: maxwidth * (700 / 1440),
                        child: Text(
                          "Once you have gone through all the lessons you'll be able to take a test to show us what you have learned!",
                          style: GoogleFonts.outfit(
                            fontSize: MediaQuery.of(context).size.height *
                                (28 / 1094),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: maxwidth * (500 / 1440),
                          top: maxwidth * (35 / 1440),
                        ),
                        child: Image.asset(
                          'assets/images/BottomQA.png',
                          width: maxwidth * (250 / 1440),
                          height:
                              MediaQuery.of(context).size.height * (250 / 1094),
                          alignment: Alignment.centerRight,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
