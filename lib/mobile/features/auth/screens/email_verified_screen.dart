import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/mobile/features/onboarding/screens/welcome_screen.dart';
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/mobile_appbar.dart';
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/mobile_footer.dart';

class EmailVerified extends StatefulWidget {
  static const routeName = '/email-verified';
  const EmailVerified({super.key});
  @override
  State<EmailVerified> createState() => _EmailVerifiedState();
}

class _EmailVerifiedState extends State<EmailVerified> {
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
    // final deviceWidth = MediaQuery.of(context).size.width;
    // final deviceHeight = MediaQuery.of(context).size.height;
    return _isLoading ? const Verified() : const FirstPage();
  }
}

class Verified extends StatelessWidget {
  const Verified({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
            child: const MobileAppBar(),
          ),
          backgroundColor: Colors.white,
          body: Center(
            child: Padding(
              padding: EdgeInsets.only(
                top: deviceHeight * 0.177,
                right: deviceWidth * 0.089,
                left: deviceWidth * 0.089,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        SizedBox(
                          height: 72,
                          width: 72,
                          child: Image.asset(
                            'assets/images/checkcircle.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: deviceHeight * 0.021,
                        ),
                        Text(
                          'Email verified',
                          style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: deviceHeight * 0.043,
                          ),
                        ),
                        SizedBox(
                          height: deviceHeight * 0.021,
                        ),
                        Text(
                          'Your email is successfully verified',
                          style: GoogleFonts.notoSans(
                            color: Colors.black45,
                            fontWeight: FontWeight.w400,
                            fontSize: deviceHeight * 0.021,
                          ),
                        ),
                        SizedBox(
                          height: deviceHeight * 0.3,
                        ),
                        SizedBox(
                          height: deviceHeight * 0.07,
                          width: deviceHeight * 0.07,
                          child: Image.asset(
                            'assets/images/tech.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    const MobileFooter(),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
