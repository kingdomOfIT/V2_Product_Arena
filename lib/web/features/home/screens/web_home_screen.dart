import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_homepage_sidebar.dart';

import '../../../../constants/global_variables.dart';

class WebHomeScreen extends StatelessWidget {
  static const routeName = '/web-home';

  const WebHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Row(
        children: [
          const WebSideBar(),
          SizedBox(
            width: maxwidth * (1130 / 1440),
            child: Column(
              children: [
                const GreenProfileIcon(),
                Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (MediaQuery.of(context).size.width > 920)
                                ? Image.asset(
                                    'assets/images/TopUI.png',
                                    //height: 200,
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                  )
                                : const SizedBox(),
                            (MediaQuery.of(context).size.width > 920)
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
                                          fontSize: maxWidth * (60 / 1440),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        'Product Arena',
                                        style: GoogleFonts.notoSans(
                                          fontSize: maxWidth * (60 / 1440),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                'Our goal is to recognise persistence, motivation and\nadaptability,\nthat’s why we encourage you to dive into these materials\nand wish you the best of luck in your studies.',
                                style: GoogleFonts.outfit(
                                  fontSize: maxWidth * (32 / 1440),
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 68),
                              Text(
                                'Once you have gone through all the lessons you’ll be able to take\na test to show us what you have learned!',
                                style: GoogleFonts.outfit(
                                  fontSize: maxWidth * (32 / 1440),
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 58.93),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: SizedBox(
                                  width: maxWidth * (250 / 1440),
                                  child:
                                      Image.asset('assets/images/BottomQA.png'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Positioned(
                child: WebProfilePopup(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
