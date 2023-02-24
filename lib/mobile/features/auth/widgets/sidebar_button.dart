// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unused_import

import "package:flutter/material.dart";
import 'mobile_sidebar.dart';
import 'package:google_fonts/google_fonts.dart';

class SidebarButton extends StatelessWidget {
  const SidebarButton({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    return Container(
      height: screenHeight * 0.0423412204,
      width: screenWidth * 0.2611111111,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black87,
            side: BorderSide(
              color: Color(0xFFFFFFFF),
              width: 2,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            )),
        child: Text(
          "Log Out",
          style: GoogleFonts.notoSans(
            textStyle: TextStyle(
                fontSize: screenHeight * 0.0202,
                fontWeight: FontWeight.w700,
                color: Color(0xFFFFFFFF)),
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
