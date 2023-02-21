// ignore_for_file: unused_import, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_login_screen.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_signup_screen.dart';
import 'package:v2_product_arena/web/features/onboarding/web_constansts_ob.dart';

// ignore: must_be_immutable
class WebOBAppBar extends StatelessWidget {
  final String text;

  WebOBAppBar({
    super.key,
    required this.text,
  });

  bool isLogin = true;

  bool isSingup = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: Container(
        padding: const EdgeInsets.only(left: 52),
        child: Image.asset(
          'assets/images/LogoPAwhitebackground.png',
        ),
      ),
      leadingWidth: 240,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: CustomText(
        'Tech387',
        16,
        FontWeight.w400,
      ),
    );
  }
}
