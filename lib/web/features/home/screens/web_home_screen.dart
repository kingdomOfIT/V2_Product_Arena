import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_homepage_sidebar.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_profilepopup.dart';

class WebHomeScreen extends StatelessWidget {
  static const routeName = '/web-home';

  const WebHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width;
    final double maxHeigth = MediaQuery.of(context).size.height;
    final double contentWidth = maxWidth * 0.8 * (1130 / 1440);
    final double contentHeight = maxHeigth * 0.78;

    return Container(
      color: Colors.white,
      child: Scaffold(
        body: OverflowBox(
          minWidth: 0,
          child: Stack(
            children: [
              Row(
                children: [
                  const WebSideBar(),
                  Expanded(
                    child: Center(
                      child: SizedBox(
                        width: contentWidth,
                        height: contentHeight,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: maxWidth * (250 / 1440),
                                    child:
                                        Image.asset('assets/images/TopUI.png'),
                                  ),
                                  const SizedBox(width: 90),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
