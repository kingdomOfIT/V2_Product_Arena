import 'package:flutter/material.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/email_verified_screen.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/mobile_login_screen.dart';
import 'package:v2_product_arena/mobile/features/auth/widgets/text_field_otp.dart';
import 'package:v2_product_arena/mobile/providers/mobile_auth_provider.dart';
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/custom_button.dart';
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/mobile_appbar.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/mobile_footer.dart';

class EmailVerificationScreen extends StatefulWidget {
  static const routeName = '/email-verification';
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  String oneTimePassword = '';

  final firstController = TextEditingController();

  final secondController = TextEditingController();

  final thirdController = TextEditingController();

  final fourthController = TextEditingController();

  final fifthController = TextEditingController();

  final sixthController = TextEditingController();

  final firstFocusNode = FocusNode();

  final secondFocusNode = FocusNode();

  final thirdFocusNode = FocusNode();

  final fourthFocusNode = FocusNode();

  final fifthFocusNode = FocusNode();

  final sixthFocusNode = FocusNode();

  void navigateToEmailVerificationScreen(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(EmailVerified.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final mobileAuth = Provider.of<MobileAuth>(
      context,
    );
    return Scaffold(
      backgroundColor: const Color.fromRGBO(243, 243, 249, 1),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
        child: const MobileAppBar(),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: deviceHeight * 0.053,
                right: deviceWidth * 0.091,
                left: deviceWidth * 0.091,
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    'Just to be sure...',
                    style: GoogleFonts.notoSans(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: deviceHeight * 0.037,
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.027,
                  ),
                  Text(
                    'We’ve sent a 6-digit code to your e-mail',
                    style: GoogleFonts.notoSans(
                      color: Colors.black54,
                      fontWeight: FontWeight.w400,
                      fontSize: deviceHeight * 0.016,
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.093,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextFieldOTP(
                        key: const Key('emailverificationField1'),
                        first: true,
                        last: false,
                        controller: firstController,
                        focusNode: firstFocusNode,
                      ),
                      TextFieldOTP(
                        key: const Key('emailverificationField2'),
                        first: false,
                        last: false,
                        controller: secondController,
                        focusNode: secondFocusNode,
                      ),
                      TextFieldOTP(
                        key: const Key('emailverificationField3'),
                        first: false,
                        last: false,
                        controller: thirdController,
                        focusNode: thirdFocusNode,
                      ),
                      TextFieldOTP(
                        key: const Key('emailverificationField4'),
                        first: false,
                        last: false,
                        controller: fourthController,
                        focusNode: fourthFocusNode,
                      ),
                      TextFieldOTP(
                        key: const Key('emailverificationField5'),
                        first: false,
                        last: false,
                        controller: fifthController,
                        focusNode: fifthFocusNode,
                      ),
                      TextFieldOTP(
                        key: const Key('emailverificationField6'),
                        first: false,
                        last: true,
                        controller: sixthController,
                        focusNode: sixthFocusNode,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: deviceHeight * 0.013,
                  ),
                  mobileAuth.isOTPerror
                      ? Text(
                          'Confirmation code does not match',
                          style: GoogleFonts.notoSans(
                            color: Colors.red,
                            fontWeight: FontWeight.w700,
                            fontSize: deviceHeight * 0.019,
                          ),
                        )
                      : SizedBox(
                          height: deviceHeight * 0.07,
                        ),
                  SizedBox(
                    height: deviceHeight * 0.05,
                  ),
                  CustomButton(
                    key: const Key('emailVerifyButton'),
                    content: Text(
                      'Verify',
                      style: GoogleFonts.notoSans(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: deviceHeight * 0.019,
                      ),
                    ),
                    buttonFunction: () {
                      oneTimePassword = firstController.text +
                          secondController.text +
                          thirdController.text +
                          fourthController.text +
                          fifthController.text +
                          sixthController.text;
                      Provider.of<MobileAuth>(context, listen: false)
                          .confirmUser(
                        Provider.of<MobileAuth>(context, listen: false)
                            .userEmail,
                        oneTimePassword,
                        context,
                        EmailVerified.routeName,
                      );
                    },
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: deviceHeight * 0.013,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Already have an account?',
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
                        key: const Key('loginRedirection'),
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed(
                              MobileLoginScreen.routeName);
                        },
                        child: Text(
                          'Log in',
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
                    height: deviceHeight * 0.15,
                  ),
                  SizedBox(
                    height: deviceHeight * 0.07,
                    width: deviceHeight * 0.07,
                    child: Image.asset(
                      'assets/images/tech.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            const MobileFooter(),
          ],
        ),
      ),
    );
  }
}
