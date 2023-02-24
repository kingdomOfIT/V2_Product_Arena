// ignore_for_file: prefer_const_literals_to_create_immutables, unused_import, unused_import, duplicate_ignore, prefer_const_declarations, prefer_const_constructors, non_constant_identifier_names, sort_child_properties_last

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
      width: screenWidth,
      backgroundColor: Color(0xFF000000),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: screenHeight * 0.124,
            child: DrawerHeader(
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "John Doe",
                  style: GoogleFonts.notoSans(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 32,
                      color: Color(0xFF22E974),
                    ),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              'johndoe@gmail.com',
              style: GoogleFonts.notoSans(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            leading: Image.asset("assets/images/user-line.png"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: RichText(
              text: TextSpan(
                text: "2/27",
                style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w700, fontSize: 16),
                children: <TextSpan>[
                  TextSpan(
                      text: " Lessons",
                      style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w400, fontSize: 16)),
                ],
              ),
            ),
            leading: Image.asset(
              "assets/images/rolevectorwhite4.png",
              height: screenHeight * 0.07,
              width: screenWidth * 0.07,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.0555),
            child: Divider(color: Colors.white),
          ),
          ListTile(
            title: Text(
              "UI/UX Design",
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            leading: Image.asset(
              "assets/images/rolevectorwhite4.png",
              height: screenHeight * 0.07,
              width: screenWidth * 0.07,
            ),
          ),
          ListTile(
            title: Text(
              "Recent Lessons",
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            leading: Image.asset("assets/images/Recent icon.png"),
          ),
          ListTile(
            title: Text(
              "Contact us !",
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w700,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            leading: Image.asset("assets/images/contact us.png"),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * 0.185),
              child: SidebarButton(),
            ),
          )
        ],
      ),
    );
  }
}
