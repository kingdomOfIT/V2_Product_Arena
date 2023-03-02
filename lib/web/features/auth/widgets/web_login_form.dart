import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/web/features/home/screens/web_home_screen.dart';

import '../../../providers/web_auth_provider.dart';

class WebLoginForm extends StatefulWidget {
  const WebLoginForm({super.key});

  @override
  State<WebLoginForm> createState() => _WebLoginFormState();
}

class _WebLoginFormState extends State<WebLoginForm> {
  final _loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String _swarven = '';

  bool isLoading = false;
  bool _backError = false;
  bool emailErrored = false;
  bool passwordErrored = false;
  bool viewPassword = false;

  // ignore: avoid_init_to_null
  var _backErrorMsg = null;

  var emailColor = const Color(0xFF605D66);
  var passwordColor = const Color(0xFF605D66);

  RegExp emailRegExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  RegExp passwordRegExp = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{8,}$');

  @override
  Widget build(BuildContext context) {
    final webAuth = Provider.of<WebAuth>(context, listen: false);

    return isLoading
        ? const Center(
            child: SpinKitRing(
              color: Color.fromRGBO(34, 233, 116, 1),
              size: 90.0,
              lineWidth: 10.0,
            ),
          )
        : Form(
            key: _loginFormKey,
            child: SizedBox(
              width: 340,
              child: Column(
                children: [
                  TextFormField(
                    key: const Key('emailField'),
                    controller: emailController,
                    onChanged: (value) {
                      if (value.isNotEmpty && !emailErrored) {
                        setState(() {
                          emailColor = const Color(0xFF000000);
                        });
                      } else if (!emailErrored) {
                        setState(() {
                          emailColor = const Color(0xFF605D66);
                        });
                      }
                    },
                    validator: (value) {
                      if (value == '' || value == null) {
                        setState(() {
                          emailErrored = true;
                          emailColor = const Color(0xFFB3261E);
                        });
                        return 'Please fill the required field.';
                      } else if (!emailRegExp.hasMatch(value)) {
                        setState(() {
                          emailErrored = true;
                          emailColor = const Color(0xFFB3261E);
                        });
                        return 'Invalid email format.';
                      }
                      setState(() {
                        emailErrored = false;
                        emailColor = const Color(0xFF000000);
                      });
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      errorText: _backError ? '' : null,
                      helperText: '',
                      suffixIcon: Visibility(
                        visible: emailErrored,
                        child: const Icon(
                          Icons.error,
                          color: Color(0xFFB3261E),
                          size: 30,
                        ),
                      ),
                      errorStyle: GoogleFonts.notoSans(
                        color: const Color(0xFFB3261E),
                      ),
                      label: Text(
                        'Email',
                        style: GoogleFonts.notoSans(
                          fontSize: 14,
                          //color: emailColor,
                        ),
                      ),
                      fillColor: Colors.black,
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF22E974),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: emailColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: emailColor,
                        ),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFB3261E),
                        ),
                      ),
                    ),
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    key: const Key('passwordField'),
                    controller: passwordController,
                    onChanged: (value) {
                      setState(() {
                        _swarven = value;
                      });
                      if (value.isNotEmpty && !passwordErrored) {
                        setState(() {
                          passwordColor = const Color(0xFF000000);
                        });
                      } else if (!passwordErrored) {
                        setState(() {
                          passwordColor = const Color(0xFF605D66);
                        });
                      }
                    },
                    obscureText: viewPassword ? false : true,
                    validator: (value) {
                      if (value == '' || value == null) {
                        setState(() {
                          passwordErrored = true;
                          passwordColor = const Color(0xFFB3261E);
                        });
                        return 'Please fill the required field.';
                      } else if (!passwordRegExp.hasMatch(value)) {
                        setState(() {
                          passwordErrored = true;
                          passwordColor = const Color(0xFFB3261E);
                        });
                        return 'Invalid password format';
                      }
                      setState(() {
                        passwordErrored = false;
                        passwordColor = const Color(0xFF000000);
                      });

                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      helperText: '',
                      errorText: _backErrorMsg,
                      errorStyle: GoogleFonts.notoSans(
                        color: const Color(0xFFB3261E),
                      ),
                      suffixIcon: _swarven.isEmpty
                          ? null
                          : InkWell(
                              key: const Key('togglePasswordView'),
                              onTap: () {
                                setState(() {
                                  viewPassword = !viewPassword;
                                });
                              },
                              child: Icon(
                                viewPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: viewPassword
                                    ? passwordErrored
                                        ? const Color(0xFFB3261E)
                                        : Colors.black
                                    : passwordErrored
                                        ? const Color(0xFFB3261E)
                                        : const Color(0xFF605D66),
                                size: 30,
                              ),
                            ),
                      label: Text(
                        'Password',
                        style: GoogleFonts.notoSans(
                          fontSize: 14,
                          //color: passwordColor,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF22E974),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: emailColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: passwordColor,
                        ),
                      ),
                      errorBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFB3261E),
                        ),
                      ),
                    ),
                    style: GoogleFonts.notoSans(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    key: const Key('loginButton'),
                    onPressed: () async {
                      if (_loginFormKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          final result = await Amplify.Auth.signIn(
                            username: emailController.text.trim(),
                            password: passwordController.text,
                          );
                          await webAuth.getUserLectures();
                          safePrint(result);
                          if (result.isSignedIn && mounted) {
                            setState(() {
                              _backError = false;
                              _backErrorMsg = null;
                            });
                            Navigator.of(context)
                                .pushReplacementNamed(WebHomeScreen.routeName);
                          } else if (result.nextStep.signInStep ==
                              'CONFIRM_SIGN_IN_WITH_NEW_PASSWORD') {
                            setState(() {
                              _backError = false;
                              _backErrorMsg = null;
                            });
                            Navigator.of(context)
                                .pushReplacementNamed(WebHomeScreen.routeName);
                            safePrint('Please create an account through app');
                          }
                        } on InvalidCredentialsException {
                          safePrint('Incorrect email or password.');
                          setState(() {
                            _backError = true;
                            _backErrorMsg = 'Incorrect email or password.';
                            emailColor = const Color(0xFFB3261E);
                            passwordColor = const Color(0xFFB3261E);
                          });
                        } on UserNotFoundException {
                          safePrint('User does not exist.');
                          setState(() {
                            _backError = true;
                            _backErrorMsg = 'Incorrect email or password.';
                            emailColor = const Color(0xFFB3261E);
                            passwordColor = const Color(0xFFB3261E);
                          });
                        } on Exception catch (e) {
                          safePrint(
                              'An unexpected error has happened. Check the logs for detail');
                          safePrint(e.toString());
                        }
                      }
                      webAuth.getUserLectures();
                      setState(() {
                        isLoading = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 56),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
  }
}
