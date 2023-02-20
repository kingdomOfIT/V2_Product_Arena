// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
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
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
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
              fontSize: deviceHeight * 0.0187,
              fontWeight: FontWeight.w700,
            ),
            decoration: InputDecoration(
              isDense: true,
              labelStyle: const TextStyle(fontSize: 20),
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
                vertical: deviceHeight * 0.018,
                horizontal: deviceWidth * 0.05,
              ),
              label: Text(
                'Email',
                style: TextStyle(
                  fontSize: deviceHeight * 0.0187,
                  fontWeight: FontWeight.w700,
                ),
              ),
              suffixIcon: Icon(
                mobileAuth.isLoginEmailError ? Icons.error : null,
                color: Colors.red,
                size: deviceHeight * 0.03,
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
            height: deviceHeight * 0.028,
          ),
          TextFormField(
            key: const Key('passwordLoginTextField'),
            controller: widget.passwordController,
            style: TextStyle(
              color:
                  mobileAuth.isLoginPasswordError ? Colors.red : Colors.black,
              fontSize: deviceHeight * 0.0187,
              fontWeight: FontWeight.w700,
            ),
            obscureText: widget.isHiddenPassword,
            decoration: InputDecoration(
              isDense: true,
              labelStyle: const TextStyle(fontSize: 20),
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
                vertical: deviceHeight * 0.018,
                horizontal: deviceWidth * 0.05,
              ),
              suffixIcon: _text.isNotEmpty
                  ? InkWell(
                      key: const Key('togglePasswordViewLogin'),
                      onTap: widget.togglePasswordView,
                      child: Icon(
                        widget.isHiddenPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color:
                            mobileAuth.isLoginPasswordError ? Colors.red : null,
                        size: deviceHeight * 0.03,
                      ),
                    )
                  : null,
              label: Text(
                'Password',
                style: TextStyle(
                  fontSize: deviceHeight * 0.0175,
                  fontWeight: FontWeight.w700,
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
