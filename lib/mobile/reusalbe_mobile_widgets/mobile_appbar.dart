// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class MobileAppBar extends StatelessWidget {
  const MobileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      title: Container(
        width: deviceWidth * 0.1,
        child: Image.asset(
          'assets/images/PAlogowhite.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
