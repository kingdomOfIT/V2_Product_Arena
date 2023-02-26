// ignore_for_file: prefer_const_literals_to_create_immutables, unused_import, unused_import, duplicate_ignore, prefer_const_declarations, prefer_const_constructors, non_constant_identifier_names, sort_child_properties_last, sized_box_for_whitespace

import "package:flutter/material.dart";
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/mobile_footer.dart';
import "package:google_fonts/google_fonts.dart";
import './sidebar_button.dart';

class MobileSidebar extends StatefulWidget {
  const MobileSidebar({Key? key}) : super(key: key);

  @override
  State<MobileSidebar> createState() => _MobileSidebarState();
}

class _MobileSidebarState extends State<MobileSidebar> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    return Drawer(
      backgroundColor: Color(0xFF000000),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: screenHeight * (90 / 803),
            width: screenWidth * (360 / 360),
            child: DrawerHeader(
              child: Text(
                "John Doe",
                style: GoogleFonts.notoSans(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: screenHeight * (32 / 803),
                    color: Color(0xFF22E974),
                  ),
                ),
              ),
              margin: EdgeInsets.all(screenHeight * (0 / 803)),
            ),
          ),
          ListTile(
            title: Text(
              'johndoe@gmail.com',
              style: GoogleFonts.notoSans(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: screenHeight * (16 / 803),
                  color: Colors.white,
                ),
              ),
            ),
            leading: Image.asset(
              "assets/images/user-line.png",
              height: screenHeight * (24 / 803),
              width: screenWidth * (24 / 360),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: RichText(
              text: TextSpan(
                text: "2/27",
                style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w700,
                    fontSize: screenHeight * (16 / 803)),
                children: <TextSpan>[
                  TextSpan(
                    text: " Lessons",
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.w400,
                      fontSize: screenHeight * (16 / 803),
                    ),
                  ),
                ],
              ),
            ),
            leading: Image.asset(
              "assets/images/rolevectorwhite4.png",
              height: screenHeight * (24 / 803),
              width: screenWidth * (24 / 360),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * (20 / 360)),
            child: Divider(color: Colors.white),
          ),
          ListTile(
            title: Text(
              "UI/UX Design",
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w700,
                fontSize: screenHeight * (16 / 803),
                color: Colors.white,
              ),
            ),
            leading: Image.asset(
              "assets/images/rolevectorwhite4.png",
              height: screenHeight * (24 / 803),
              width: screenWidth * (24 / 360),
            ),
          ),
          ListTile(
            title: Text(
              "Recent Lessons",
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w700,
                fontSize: screenHeight * (16 / 803),
                color: Colors.white,
              ),
            ),
            leading: Image.asset(
              "assets/images/Recent icon.png",
              height: screenHeight * (24 / 803),
              width: screenWidth * (24 / 360),
            ),
          ),
          ListTile(
            title: Text(
              "Contact us !",
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w700,
                fontSize: screenHeight * (16 / 803),
                color: Colors.white,
              ),
            ),
            leading: Image.asset(
              "assets/images/contact us.png",
              height: screenHeight * (24 / 803),
              width: screenWidth * (24 / 360),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * (149 / 803)),
              child: SidebarButton(),
            ),
          )
        ],
      ),
    );
  }
}
