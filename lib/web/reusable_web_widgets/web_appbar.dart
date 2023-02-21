// ignore_for_file: unused_import, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_login_screen.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_signup_screen.dart';
import 'package:provider/provider.dart';

import '../providers/web_auth_provider.dart';

class WebAppBar extends StatefulWidget {
  final String text;
  final String routeName;
  WebAppBar({
    super.key,
    required this.text,
    required this.routeName,
  });

  @override
  State<WebAppBar> createState() => _WebAppBarState();
}

class _WebAppBarState extends State<WebAppBar> {
  bool isLogin = true;
  bool isSingup = false;

  @override
  Widget build(BuildContext context) {
    final webAuth = Provider.of<WebAuth>(context, listen: false);

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
      title: const Text(
        'Tech387',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 52),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(
                    width: 2,
                    color: Colors.black,
                  ),
                ),
                child: ElevatedButton(
                  key: const Key('signUpRedirection'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(widget.routeName);
                    webAuth.isEmailError = false;
                    webAuth.isNameError = false;
                    webAuth.isSurnameError = false;
                    webAuth.isBirthDateError = false;
                    webAuth.isCityError = false;
                    webAuth.isPhoneNumError = false;
                    webAuth.isPasswordError = false;
                  },
                  child: Text(widget.text,
                      style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
