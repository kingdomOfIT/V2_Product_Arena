// ignore_for_file: unused_local_variable, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/mobile_signup_screen.dart';
import 'package:v2_product_arena/mobile/features/auth/widgets/mobile_login_form.dart';
import 'package:v2_product_arena/mobile/features/home/screens/mobile_home_screen.dart';
import 'package:v2_product_arena/mobile/providers/mobile_auth_provider.dart';
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/custom_button.dart';
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/mobile_appbar.dart';
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/mobile_footer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MobileLoginScreen extends StatefulWidget {
  static const routeName = '/mobile-login';
  const MobileLoginScreen({super.key});

  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final passwordFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  late final InputBorder? focusedBorder;

  bool isHiddenPassword = true;

  RegExp email = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  RegExp password =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  void onSubmitLogin() async {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      formKey.currentState!.save();
      Provider.of<MobileAuth>(context, listen: false).isLoading = true;
      await Provider.of<MobileAuth>(context, listen: false).signInUser(
        emailController.text,
        passwordController.text,
        context,
        MobileHomeScreen.routeName,
      );
    }
    Provider.of<MobileAuth>(context, listen: false).isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final mobileAuth = Provider.of<MobileAuth>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(233, 233, 233, 1),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
        child: const MobileAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: deviceWidth * 0.089,
                right: deviceWidth * 0.089,
                top: deviceHeight * 0.033,
              ),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Column(
                      children: const <Widget>[],
                    ),
                    Text(
                      'Welcome to',
                      style: GoogleFonts.notoSans(
                        fontSize: deviceHeight * 0.04,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Product Arena',
                      style: GoogleFonts.notoSans(
                        fontSize: deviceHeight * 0.04,
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.15,
                    ),
                    LoginForm(
                      emailController: emailController,
                      passwordController: passwordController,
                      passwordFocusNode: passwordFocusNode,
                      formKey: formKey,
                      isHiddenPassword: isHiddenPassword,
                      togglePasswordView: togglePasswordView,
                    ),
                    SizedBox(
                      height: deviceHeight * 0.042,
                    ),
                    CustomButton(
                      key: const Key('loginButton'),
                      content: Text(
                        'Login',
                        style: GoogleFonts.notoSans(
                          fontSize: deviceHeight * 0.019,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      buttonFunction: onSubmitLogin,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: deviceHeight * 0.013,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Don’t you have an account?',
                          style: GoogleFonts.notoSans(
                            fontSize: deviceHeight * 0.013,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        InkWell(
                          key: const Key('signUpRedirection'),
                          onTap: () {
                            Navigator.of(context).pushReplacementNamed(
                                MobileSignupScreen.routeName);
                            mobileAuth.isLoginEmailError = false;
                            mobileAuth.isLoginPasswordError = false;
                          },
                          child: Text(
                            'Sign Up',
                            style: GoogleFonts.notoSans(
                              fontSize: deviceHeight * 0.013,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: deviceHeight * 0.13,
                    ),
                    SizedBox(
                      height: deviceHeight * 0.07,
                      width: deviceHeight * 0.07,
                      child: Image.asset(
                        'assets/images/tech.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * 0.012,
                    ),
                  ],
                ),
              ),
            ),
            const MobileFooter(),
          ],
        ),
      ),
    );
  }
}
