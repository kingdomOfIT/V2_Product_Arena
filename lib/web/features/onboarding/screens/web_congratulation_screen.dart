// ignore_for_file: avoid_unnecessary_containers

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_footer.dart';

import '../../../reusable_web_widgets/web_ob_appbar.dart';
import '../../home/screens/web_home_screen.dart';

class WebCongratulationObScreen extends StatefulWidget {
  static const routeName = '/verified-onboarding';
  const WebCongratulationObScreen({super.key});

  @override
  State<WebCongratulationObScreen> createState() =>
      _WebCongratulationObScreenState();
}

class _WebCongratulationObScreenState extends State<WebCongratulationObScreen> {
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
        ? Container(
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                preferredSize:
                    Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
                child: PreferredSize(
                  preferredSize: Size.fromHeight(
                      MediaQuery.of(context).size.height * 0.05),
                  child: WebOBAppBar(
                    text: 'Tech387',
                  ),
                ),
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
                        height: deviceHeight * (465 / 1133),
                        color: Colors.white,
                        width: double.infinity,
                        child: SizedBox(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: deviceHeight * (30 / 800),
                              ),
                              SizedBox(
                                height: 80,
                                width: 80,
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
                                style: GoogleFonts.outfit(
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w400,
                                    fontSize: (16 / 360) *
                                        MediaQuery.of(context).size.width),
                              ),
                              Text(
                                'You’ve successfully created an account',
                                style: GoogleFonts.outfit(
                                    color: const Color(0xFF605D66),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 30),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const WebFooter(),
                ],
              ),
            ),
          )
        : const WebHomeScreen();
  }
}
