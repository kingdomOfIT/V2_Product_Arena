// ignore_for_file: unused_import, sized_box_for_whitespace, prefer_const_constructors, non_constant_identifier_names

import "package:flutter/material.dart";
import '../screens/welcome_page.dart';
import './mobile_sidebar.dart';

class WelcomepageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const WelcomepageAppBar({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    return AppBar(
      backgroundColor: const Color(0xFFFFFFFF),
      elevation: 0,
      leading: Container(
        height: screenHeight * 0.06,
        width: screenWidth * 1,
        child: Padding(
          padding: EdgeInsets.only(
              top: screenHeight * 0.0124,
              bottom: screenHeight * 0.0124,
              left: screenWidth * 0.0416),
          child: Image.asset(
            "assets/images/PAlogowhite.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
      actions: [
        Builder(builder: (context) {
          return IconButton(
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
            icon: const Icon(Icons.menu),
            color: Colors.black87,
          );
        }),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55.0);
  Size get PreferredSize => const Size.fromWidth(360.0);
}
