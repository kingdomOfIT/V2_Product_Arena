// ignore_for_file: use_key_in_widget_constructors, avoid_print, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
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
  Future<void> confirmUserr(String email, String confirmationCode) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
          username: email, confirmationCode: confirmationCode);
      print(result);
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
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
          children: [
            Column(
              children: [
                Container(
                  width: maxwidth,
                  height: 1133,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/webbackground.png'),
                        fit: BoxFit.cover),
                  ),
                  child: Center(
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
                          const SizedBox(height: 183),
                          Padding(
                            padding: const EdgeInsets.all(23),
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child:
                                  Image.asset('assets/images/PAlogowhite.png'),
                            ),
                          ),
                          const Text(
                            'Just to be sure...',
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Text(
                            'We’ve sent a 6-digit code to your e-mail',
                            style: TextStyle(
                              color: Color(0xFF605D66),
                              fontSize: 32,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 23),

                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 85,
                            child: Form(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: TextFormField(
                                      onSaved: (pin1) {},
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      style: GoogleFonts.notoSans(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w900,
                                      ),
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      cursorColor: const Color(0xFF22E974),
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(20),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF22E974),
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: TextFormField(
                                      onSaved: (pin2) {},
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      style: GoogleFonts.notoSans(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w900,
                                      ),
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      cursorColor: const Color(0xFF22E974),
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(20),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF22E974),
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: TextFormField(
                                      onSaved: (pin3) {},
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      style: GoogleFonts.notoSans(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w900,
                                      ),
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      cursorColor: const Color(0xFF22E974),
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(20),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF22E974),
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: TextFormField(
                                      onSaved: (pin4) {},
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      style: GoogleFonts.notoSans(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w900,
                                      ),
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      cursorColor: const Color(0xFF22E974),
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(20),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF22E974),
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: TextFormField(
                                      onSaved: (pin5) {},
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          FocusScope.of(context).nextFocus();
                                        }
                                      },
                                      style: GoogleFonts.notoSans(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w900,
                                      ),
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      cursorColor: const Color(0xFF22E974),
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(20),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF22E974),
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      textAlign: TextAlign.center,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: TextFormField(
                                      onSaved: (pin6) {},
                                      onChanged: (value) {
                                        if (value.length == 1) {
                                          FocusScope.of(context).nextFocus();
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
                                      cursorColor: const Color(0xFF22E974),
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.all(20),
                                        border: OutlineInputBorder(),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF22E974),
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(1),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 23),
                          //Verify Button
                          SizedBox(
                            width: 452,
                            height: 56,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/verifed');
                                confirmUserr(
                                    Provider.of<WebAuth>(context).email, '');
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
