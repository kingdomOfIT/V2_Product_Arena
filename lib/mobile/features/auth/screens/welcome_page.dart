// ignore_for_file: unused_import, unnecessary_string_escapes, prefer_const_constructors

import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/mobile_footer.dart';
import '../widgets/mobile_sidebar.dart';
import '../widgets/welcomepage_appbar.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;

    return MaterialApp(
      home: SizedBox(
        width: screenWidth * 1,
        height: screenHeight * 0.863,
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: const Color(0xFFF3F3F9),
          appBar: WelcomepageAppBar(scaffoldKey: _scaffoldKey),
          drawer: const Drawer(
            child: MobileSidebar(),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: screenHeight * 0.13,
                    right: screenWidth * 0.21,
                    bottom: screenHeight * 0.04,
                    left: screenWidth * 0.21,
                  ),
                  child: Image.asset(
                    "assets/images/UX.png",
                    height: screenHeight * 0.3,
                    width: screenWidth * 0.57,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.04),
                    child: RichText(
                      text: TextSpan(
                        text: "Welcome to",
                        style: GoogleFonts.notoSans(
                          textStyle: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF000000)),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "\nProduct Arena",
                            style: GoogleFonts.notoSans(
                              textStyle: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.135),
                    child: RichText(
                      text: TextSpan(
                        text:
                            "Our goal is to recognise persistence,\nmotivation and adaptability, that’s why we \nencourage you to dive into these materials \nand wish you the best of luck in your \nstudies.",
                        style: GoogleFonts.notoSans(
                          textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF000000)),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                "\nOnce you have gone through all the lessons \nyou'll be able to take a test to show us what \nyou have learned!",
                            style: GoogleFonts.notoSans(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF000000),
                              ),
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const MobileFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
