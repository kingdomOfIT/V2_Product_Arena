// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MobileFooter extends StatelessWidget {
  const MobileFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: deviceWidth * 0.056,
              right: deviceWidth * 0.056,
              top: deviceHeight * 0.027,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Privacy',
                  style: GoogleFonts.notoSans(
                    fontSize: deviceHeight * 0.013,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  'Terms',
                  style: GoogleFonts.notoSans(
                    fontSize: deviceHeight * 0.013,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '© Credits, 2023, Product Arena',
            style: GoogleFonts.notoSans(
              fontSize: deviceHeight * 0.013,
              color: Colors.black45,
            ),
          ),
          SizedBox(
            height: deviceHeight * 0.013,
          ),
        ],
      ),
    );
  }
}
