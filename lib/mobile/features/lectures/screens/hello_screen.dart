import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/mobile/features/lectures/widgets/lectures_appbar.dart';
import 'package:v2_product_arena/mobile/features/lectures/widgets/lectures_sidebar.dart';
import 'package:v2_product_arena/mobile/providers/mobile_auth_provider.dart';
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/mobile_footer.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  static const routeName = 'lectures-welcome';
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<MobileAuth>(context);
    dataProvider.scaffoldKey = _scaffoldKey;
    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F9),
      appBar: WelcomepageAppBar(scaffoldKey: _scaffoldKey),
      body: Scaffold(
        key: _scaffoldKey,
        endDrawer: Drawer(
          width: screenWidth * (360 / 360),
          child: MobileSidebar(),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: screenHeight * (91 / 803),
                  right: screenWidth * (76 / 360),
                  bottom: screenHeight * (31 / 803),
                  left: screenWidth * (76 / 360),
                ),
                child: Image.asset(
                  "assets/images/UX.png",
                  height: screenHeight * (208 / 803),
                  width: screenWidth * (208 / 360),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * (30 / 803)),
                  child: RichText(
                    text: TextSpan(
                      text: "Welcome to",
                      style: GoogleFonts.notoSans(
                        textStyle: TextStyle(
                            fontSize: screenHeight * (32 / 803),
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF000000)),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: "\nProduct Arena",
                          style: GoogleFonts.notoSans(
                            textStyle: TextStyle(
                              fontSize: screenHeight * (32 / 803),
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
                  padding: EdgeInsets.only(bottom: screenHeight * (94 / 803)),
                  child: RichText(
                    text: TextSpan(
                      text:
                          "Our goal is to recognise persistence,\nmotivation and adaptability, that's why we \nencourage you to dive into these materials \nand wish you the best of luck in your \nstudies.",
                      style: GoogleFonts.notoSans(
                        textStyle: TextStyle(
                            fontSize: screenHeight * (14 / 803),
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF000000)),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text:
                              "\n\nOnce you have gone through all the lessons \nyou'll be able to take a test to show us what \nyou have learned!",
                          style: GoogleFonts.notoSans(
                            textStyle: TextStyle(
                              fontSize: screenHeight * (14 / 803),
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
    );
  }
}
