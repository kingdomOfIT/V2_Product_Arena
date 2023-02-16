// ignore_for_file: unused_import, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_login_screen.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_signup_screen.dart';

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
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(widget.routeName);
                  },
                  child: Text(
                    widget.text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
