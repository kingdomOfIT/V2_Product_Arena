// ignore_for_file: use_key_in_widget_constructors, avoid_print, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_email_verifed.dart';
import '../../../providers/web_auth_provider.dart';
import '../../../reusable_web_widgets/web_appbar.dart';
import '../../../reusable_web_widgets/web_footer.dart';
import 'web_login_screen.dart';
import 'package:provider/provider.dart';

class SignupConfirmation extends StatefulWidget {
  static const routeName = '/confirmation';
  @override
  State<SignupConfirmation> createState() => _SignupConfirmationState();
}

class _SignupConfirmationState extends State<SignupConfirmation> {
  final _formKey = GlobalKey();

  final _otpController1 = TextEditingController();
  final _otpController2 = TextEditingController();
  final _otpController3 = TextEditingController();
  final _otpController4 = TextEditingController();
  final _otpController5 = TextEditingController();
  final _otpController6 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final webAuth = Provider.of<WebAuth>(context, listen: false);
    final isError = Provider.of<WebAuth>(context, listen: false).isOTPerror;
    double maxwidth = MediaQuery.of(context).size.width;
    double maxheight = MediaQuery.of(context).size.height;

    // if (MediaQuery.of(context).size.width < 980) {
    //   return const Icon(Icons.favorite);
    // }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.05),
        child: WebAppBar(
          text: 'Login',
          routeName: WebLoginScreen.routeName,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  width: maxwidth,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/webbackground.png'),
                        fit: BoxFit.cover),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 156, bottom: 156),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width * 0.51,
                        height: MediaQuery.of(context).size.height * 0.86,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 23, top: 183),
                              child: SizedBox(
                                width: 100,
                                child: Image.asset(
                                    'assets/images/PAlogowhite.png'),
                              ),
                            ),
                            Text(
                              'Just to be sure...',
                              style: TextStyle(
                                fontSize: maxwidth * 0.06,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              'We’ve sent a 6-digit code to your e-mail',
                              style: TextStyle(
                                color: const Color(0xFF605D66),
                                fontSize: maxwidth * 0.023,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 23),
                            Flexible(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Form(
                                  key: _formKey,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: SizedBox(
                                          width: maxwidth * 0.06,
                                          child: TextFormField(
                                            key:
                                                const Key('verificationField1'),
                                            controller: _otpController1,
                                            onChanged: (value) {
                                              if (value.length == 1) {
                                                FocusScope.of(context)
                                                    .nextFocus();
                                              }
                                            },
                                            style: GoogleFonts.notoSans(
                                              fontSize: 32,
                                              fontWeight: FontWeight.w900,
                                            ),
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            cursorColor:
                                                const Color(0xFF22E974),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(20),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: isError
                                                        ? Colors.red
                                                        : Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: isError
                                                        ? Colors.red
                                                        : Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            textAlign: TextAlign.center,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  1),
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: SizedBox(
                                          width: maxwidth * 0.06,
                                          child: TextFormField(
                                            key:
                                                const Key('verificationField2'),
                                            controller: _otpController2,
                                            onChanged: (value) {
                                              if (value.length == 1) {
                                                FocusScope.of(context)
                                                    .nextFocus();
                                              }
                                            },
                                            style: GoogleFonts.notoSans(
                                              fontSize: 32,
                                              fontWeight: FontWeight.w900,
                                            ),
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            cursorColor:
                                                const Color(0xFF22E974),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(20),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: isError
                                                        ? Colors.red
                                                        : Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: isError
                                                        ? Colors.red
                                                        : Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            textAlign: TextAlign.center,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  1),
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: SizedBox(
                                          width: maxwidth * 0.06,
                                          child: TextFormField(
                                            key:
                                                const Key('verificationField3'),
                                            controller: _otpController3,
                                            onChanged: (value) {
                                              if (value.length == 1) {
                                                FocusScope.of(context)
                                                    .nextFocus();
                                              }
                                            },
                                            style: GoogleFonts.notoSans(
                                              fontSize: 32,
                                              fontWeight: FontWeight.w900,
                                            ),
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            cursorColor:
                                                const Color(0xFF22E974),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(20),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: isError
                                                        ? Colors.red
                                                        : Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: isError
                                                        ? Colors.red
                                                        : Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            textAlign: TextAlign.center,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  1),
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: SizedBox(
                                          width: maxwidth * 0.06,
                                          child: TextFormField(
                                            key:
                                                const Key('verificationField4'),
                                            controller: _otpController4,
                                            onChanged: (value) {
                                              if (value.length == 1) {
                                                FocusScope.of(context)
                                                    .nextFocus();
                                              }
                                            },
                                            style: GoogleFonts.notoSans(
                                              fontSize: 32,
                                              fontWeight: FontWeight.w900,
                                            ),
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            cursorColor:
                                                const Color(0xFF22E974),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(20),
                                              border:
                                                  const OutlineInputBorder(),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: isError
                                                        ? Colors.red
                                                        : Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: isError
                                                        ? Colors.red
                                                        : Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            textAlign: TextAlign.center,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  1),
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: SizedBox(
                                          width: maxwidth * 0.06,
                                          child: TextFormField(
                                            key:
                                                const Key('verificationField5'),
                                            controller: _otpController5,
                                            onChanged: (value) {
                                              if (value.length == 1) {
                                                FocusScope.of(context)
                                                    .nextFocus();
                                              }
                                            },
                                            style: GoogleFonts.notoSans(
                                              fontSize: 32,
                                              fontWeight: FontWeight.w900,
                                            ),
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            cursorColor:
                                                const Color(0xFF22E974),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(20),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: isError
                                                        ? Colors.red
                                                        : Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: isError
                                                        ? Colors.red
                                                        : Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            textAlign: TextAlign.center,
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  1),
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: SizedBox(
                                          width: maxwidth * 0.06,
                                          child: TextFormField(
                                            key:
                                                const Key('verificationField6'),
                                            controller: _otpController6,
                                            onChanged: (value) {
                                              if (value.length == 1) {
                                                FocusScope.of(context)
                                                    .nextFocus();
                                              }
                                            },
                                            showCursor: false,
                                            readOnly: false,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.notoSans(
                                              fontSize: 32,
                                              fontWeight: FontWeight.w900,
                                            ),
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            cursorColor:
                                                const Color(0xFF22E974),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(20),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: isError
                                                        ? Colors.red
                                                        : Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    width: 2,
                                                    color: isError
                                                        ? Colors.red
                                                        : Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(
                                                  1),
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 23),
                            webAuth.isOTPerror
                                ? Text(
                                    'Confirmation code does not match',
                                    style: GoogleFonts.notoSans(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w700,
                                      fontSize: maxheight * 0.019,
                                    ),
                                  )
                                : const SizedBox(
                                    height: 25,
                                  ),
                            //Verify Button
                            SizedBox(
                              width: 452,
                              height: 56,
                              child: ElevatedButton(
                                key: const Key('verifyButton'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                ),
                                onPressed: () {
                                  final otp = _otpController1.text +
                                      _otpController2.text +
                                      _otpController3.text +
                                      _otpController4.text +
                                      _otpController5.text +
                                      _otpController6.text;

                                  webAuth.confirmUser(
                                    webAuth.userEmail,
                                    otp,
                                    context,
                                    Verifed.routeName,
                                  );
                                  print(webAuth.userEmail);
                                  print(isError);
                                },
                                child: const Text(
                                  'Verify',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 45),
            const WebFooter(),
          ],
        ),
      ),
    );
  }
}
