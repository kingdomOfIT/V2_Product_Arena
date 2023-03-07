// ignore_for_file: unused_local_variable, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/mobile_signup_screen.dart';
import 'package:v2_product_arena/mobile/features/auth/widgets/mobile_login_form.dart';
import 'package:v2_product_arena/mobile/features/lectures/screens/hello_screen.dart';
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
  bool isLoading = false;

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
      setState(() {
        isLoading = true;
      });

      await Provider.of<MobileAuth>(context, listen: false).signInUser(
        emailController.text.trim(),
        passwordController.text,
        context,
        WelcomePage.routeName,
        // ExampleLectures.routeName,
      );

      // ignore: use_build_context_synchronously
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    final mobileAuth = Provider.of<MobileAuth>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(233, 233, 233, 1),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
        child: const MobileAppBar(),
      ),
      body: isLoading
          ? const Center(
              child: SpinKitRing(
                color: Color.fromRGBO(34, 233, 116, 1),
                size: 90.0,
                lineWidth: 10.0,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Column(
                      children: <Widget>[
                        // Column(
                        //   children: const <Widget>[],
                        // ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: screenHeight * (40 / 800)),
                          child: Text(
                            'Welcome to',
                            style: GoogleFonts.notoSans(
                              fontSize: screenHeight * (32 / 800),
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * (65 / 360)),
                          child: Text(
                            'Product Arena',
                            style: GoogleFonts.notoSans(
                              fontSize: screenHeight * (32 / 800),
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * (128 / 800),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * (32 / 360)),
                          child: LoginForm(
                            emailController: emailController,
                            passwordController: passwordController,
                            passwordFocusNode: passwordFocusNode,
                            formKey: formKey,
                            isHiddenPassword: isHiddenPassword,
                            togglePasswordView: togglePasswordView,
                          ),
                        ),
                        mobileAuth.loginErrorText.isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: screenHeight * (10 / 800)),
                                child: Text(
                                  mobileAuth.loginErrorText,
                                  style: const TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            : SizedBox(height: screenHeight * (0 / 800)),
                        SizedBox(
                          height: screenHeight * (40 / 800),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * (32 / 360)),
                          child: CustomButton(
                            key: const Key('loginButton'),
                            content: Text(
                              'Login',
                              style: GoogleFonts.notoSans(
                                fontSize: screenHeight * (14 / 800),
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            buttonFunction: onSubmitLogin,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * (10 / 800),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * (96 / 360)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Don’t you have an account?',
                                style: GoogleFonts.notoSans(
                                  fontSize: screenHeight * (10 / 800),
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                width: screenWidth * (3 / 360),
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
                                    fontSize: screenHeight * (10 / 800),
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * (167 / 800),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * (150 / 360)),
                          child: SizedBox(
                            height: screenHeight * (60 / 800),
                            width: screenWidth * (60 / 360),
                            child: Image.asset(
                              'assets/images/group2.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenHeight * (23.11 / 800)),
                    child: const MobileFooter(),
                  ),
                ],
              ),
            ),
    );
  }
}
