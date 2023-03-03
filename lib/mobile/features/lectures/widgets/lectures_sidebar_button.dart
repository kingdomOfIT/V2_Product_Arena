// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unused_import

import 'package:amplify_flutter/amplify_flutter.dart';
import "package:flutter/material.dart";
import 'package:v2_product_arena/mobile/features/auth/screens/mobile_login_screen.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SidebarButton extends StatelessWidget {
  const SidebarButton({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    return Container(
      height: screenHeight * (34 / 803),
      width: screenWidth * (94 / 360),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black87,
            side: BorderSide(
              color: Color(0xFFFFFFFF),
              width: 2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenWidth * (3 / 360)),
            )),
        child: Padding(
          padding: EdgeInsets.only(
            top: screenHeight * (7.5 / 803),
            right: screenWidth * (2 / 360),
            bottom: screenHeight * (7.5 / 803),
            left: screenWidth * (2 / 360),
          ),
          child: Text(
            "Log out",
            textAlign: TextAlign.center,
            style: GoogleFonts.notoSans(
              textStyle: TextStyle(
                  fontSize: screenHeight * (14 / 803),
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                  color: Color(0xFFFFFFFF)),
            ),
          ),
        ),
        onPressed: () async {
          try {
            final res = await Amplify.Auth.signOut();

            safePrint(res);
            // ignore: use_build_context_synchronously
            // Navigator.of(context)
            //     .pushReplacementNamed(MobileLoginScreen.routeName);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MobileLoginScreen()),
              (Route<dynamic> route) => false,
            );
          } on AuthException catch (e) {
            safePrint(e.message);
          }
        },
      ),
    );
  }
}
