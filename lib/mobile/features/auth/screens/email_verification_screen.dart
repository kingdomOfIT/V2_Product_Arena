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
    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      top: screenHeight * (40 / 749),
                      left: screenWidth * (65 / 360),
                      right: screenWidth * (55 / 360),
                    ),
                    child: Text(
                      'Just to be sure...',
                      style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: screenHeight * (32 / 749),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * (20 / 749),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * (32 / 360),
                      right: screenWidth * (32 / 360),
                    ),
                    child: Text(
                      'We’ve sent a 6-digit code to your e-mail',
                      style: GoogleFonts.notoSans(
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                        fontSize: screenHeight * (16 / 749),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * (70 / 749),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: screenWidth * (33 / 360),
                      right: screenWidth * (33 / 360),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        TextFieldOTP(
                          key: const Key('emailverificationField1'),
                          first: true,
                          last: false,
                          controller: firstController,
                          focusNode: firstFocusNode,
                        ),
                        SizedBox(
                          width: screenWidth * (3.5 / 360),
                        ),
                        TextFieldOTP(
                          key: const Key('emailverificationField2'),
                          first: false,
                          last: false,
                          controller: secondController,
                          focusNode: secondFocusNode,
                        ),
                        SizedBox(
                          width: screenWidth * (3.5 / 360),
                        ),
                        TextFieldOTP(
                          key: const Key('emailverificationField3'),
                          first: false,
                          last: false,
                          controller: thirdController,
                          focusNode: thirdFocusNode,
                        ),
                        SizedBox(
                          width: screenWidth * (3.5 / 360),
                        ),
                        TextFieldOTP(
                          key: const Key('emailverificationField4'),
                          first: false,
                          last: false,
                          controller: fourthController,
                          focusNode: fourthFocusNode,
                        ),
                        SizedBox(
                          width: screenWidth * (3.5 / 360),
                        ),
                        TextFieldOTP(
                          key: const Key('emailverificationField5'),
                          first: false,
                          last: false,
                          controller: fifthController,
                          focusNode: fifthFocusNode,
                        ),
                        SizedBox(
                          width: screenWidth * (3.5 / 360),
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
                  ),
                  SizedBox(
                    height: screenHeight * (1 / 749),
                  ),
                  mobileAuth.isOTPerror
                      ? Text(
                          'Confirmation code does not match',
                          style: GoogleFonts.notoSans(
                            color: Colors.red,
                            fontWeight: FontWeight.w700,
                            fontSize: screenHeight * (14 / 749),
                          ),
                        )
                      : SizedBox(
                          height: screenHeight * (52 / 749),
                        ),
                  SizedBox(
                    height: screenHeight * (37 / 749),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * (32 / 360),
                        right: screenWidth * (32 / 360)),
                    child: CustomButton(
                      key: const Key('emailVerifyButton'),
                      content: Padding(
                        padding: EdgeInsets.only(
                          top: screenHeight * (11 / 749),
                          bottom: screenHeight * (10 / 749),
                        ),
                        child: Text(
                          'Verify',
                          style: GoogleFonts.notoSans(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: screenHeight * (14 / 749),
                          ),
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
                  ),
                  SizedBox(
                    height: screenHeight * (10 / 749),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * (104 / 360),
                        right: screenWidth * (103 / 360)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Already have an account?',
                          style: GoogleFonts.notoSans(
                            fontSize: screenHeight * (10 / 749),
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
                              fontSize: screenHeight * (10 / 749),
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * (150 / 749),
                  ),
                  SizedBox(
                    height: screenHeight * (60 / 749),
                    width: screenWidth * (60 / 360),
                    child: Image.asset(
                      'assets/images/group2.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * (38.1 / 749)),
                child: const MobileFooter(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
