import 'dart:async';
import 'package:flutter/material.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/mobile_login_screen.dart';
import 'package:v2_product_arena/mobile/features/home/screens/mobile_home_screen.dart';
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/mobile_appbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/mobile_footer.dart';

class MobileVerifiedOnboardingScreen extends StatefulWidget {
  static const routeName = '/mobile-verified-onboarding';
  const MobileVerifiedOnboardingScreen({super.key});

  @override
  State<MobileVerifiedOnboardingScreen> createState() =>
      _MobileVerifiedOnboardingScreenState();
}

class _MobileVerifiedOnboardingScreenState
    extends State<MobileVerifiedOnboardingScreen> {
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
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return _isLoading
        ? Scaffold(
            backgroundColor: const Color.fromRGBO(233, 233, 233, 1),
            appBar: PreferredSize(
              preferredSize:
                  Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
              child: const MobileAppBar(),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: deviceWidth * (34 / 360),
                    ),
                    child: Container(
                      color: Colors.white,
                      height: deviceHeight * (187 / 800),
                      width: double.infinity,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: deviceHeight * (30 / 800),
                          ),
                          SizedBox(
                            height: 72,
                            width: 72,
                            child: Image.asset(
                              'assets/images/checkcircle.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            height: deviceHeight * (21 / 800),
                          ),
                          Text(
                            'Congratulations',
                            style: GoogleFonts.notoSans(
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.w700,
                                fontSize: (16 / 360) *
                                    MediaQuery.of(context).size.width),
                          ),
                          Text(
                            'You’ve successfully created an account',
                            style: GoogleFonts.notoSans(
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.w400,
                                fontSize: (14 / 360) *
                                    MediaQuery.of(context).size.width),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const MobileFooter(),
              ],
            ),
          )
        : const MobileLoginScreen();
  }
}
