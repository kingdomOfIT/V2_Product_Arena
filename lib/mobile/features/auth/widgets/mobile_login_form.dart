// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/mobile/providers/mobile_auth_provider.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FocusNode passwordFocusNode;
  final GlobalKey formKey;
  final bool isHiddenPassword;
  final VoidCallback togglePasswordView;
  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.passwordFocusNode,
    required this.formKey,
    required this.isHiddenPassword,
    required this.togglePasswordView,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final RegExp email = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  String _text = '';

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    final mobileAuth = Provider.of<MobileAuth>(context, listen: false);
    return Form(
      key: widget.formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            key: const Key('emailLoginTextField'),
            controller: widget.emailController,
            style: TextStyle(
              color: mobileAuth.isLoginEmailError ? Colors.red : Colors.black,
              fontSize: screenHeight * (14 / 800),
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              isDense: true,
              labelStyle: TextStyle(fontSize: screenHeight * (14 / 800)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(34, 233, 116, 1),
                  )),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  )),
              contentPadding: EdgeInsets.symmetric(
                vertical: screenHeight * (15 / 800),
                horizontal: screenWidth * (16 / 360),
              ),
              label: Text(
                "Email",
                style: GoogleFonts.notoSans(
                  // ignore: prefer_const_constructors
                  textStyle: TextStyle(
                    fontSize: screenHeight * (14 / 800),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              suffixIcon: Icon(
                mobileAuth.isLoginEmailError ? Icons.error : null,
                color: Colors.red,
                size: screenWidth * (24 / 360),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                mobileAuth.isLoginEmailError = true;
                return 'Please fill the required field.';
              } else if (!email.hasMatch(value)) {
                mobileAuth.isLoginEmailError = true;
                return 'Enter valid email';
              } else {
                mobileAuth.isLoginEmailError = false;
                return null;
              }
            },
            onEditingComplete: () =>
                FocusScope.of(context).requestFocus(widget.passwordFocusNode),
          ),
          SizedBox(
            height: screenHeight * (30 / 800),
          ),
          TextFormField(
            key: const Key('passwordLoginTextField'),
            controller: widget.passwordController,
            style: TextStyle(
              color:
                  mobileAuth.isLoginPasswordError ? Colors.red : Colors.black,
              fontSize: screenHeight * (14 / 800),
              fontWeight: FontWeight.w700,
            ),
            obscureText: widget.isHiddenPassword,
            decoration: InputDecoration(
              isDense: true,
              labelStyle: TextStyle(fontSize: screenHeight * (14 / 800)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(34, 233, 116, 1),
                  )),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.black,
                  )),
              contentPadding: EdgeInsets.symmetric(
                vertical: screenHeight * (15 / 800),
                horizontal: screenWidth * (16 / 360),
              ),
              suffixIcon: _text.isNotEmpty
                  ? InkWell(
                      key: const Key('togglePasswordViewLogin'),
                      onTap: widget.togglePasswordView,
                      child: SizedBox(
                        height: screenWidth * (30 / 360),
                        width: screenWidth * (30 / 360),
                        child: Icon(
                          widget.isHiddenPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: mobileAuth.isLoginPasswordError
                              ? Colors.red
                              : null,
                        ),
                      ),
                    )
                  : null,
              label: Text(
                "Password",
                style: GoogleFonts.notoSans(
                  textStyle: TextStyle(
                    fontSize: screenHeight * (14 / 800),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            focusNode: widget.passwordFocusNode,
            onChanged: (value) {
              setState(() {
                _text = value;
              });
            },
            onEditingComplete: () => FocusScope.of(context).unfocus(),
            validator: (value) {
              if (value == null || value == '') {
                mobileAuth.isLoginPasswordError = true;
                return 'Please enter password';
              } else if (value.length < 8) {
                mobileAuth.isLoginPasswordError = true;
                return 'Password is too short';
              } else {
                mobileAuth.isLoginPasswordError = false;
                return null;
              }
            },
          ),
        ],
      ),
    );
  }
}
