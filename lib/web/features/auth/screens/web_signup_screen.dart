// ignore_for_file: use_key_in_widget_constructors, avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/amplifyconfiguration.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_login_screen.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_appbar.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_footer.dart';
import 'dart:convert';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

class WebSignUpScreen extends StatefulWidget {
  static const routeName = '/web-signup';

  @override
  State<WebSignUpScreen> createState() => _WebSignUpScreenState();
}

class _WebSignUpScreenState extends State<WebSignUpScreen> {
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final birthdateController = TextEditingController();
  final cityController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final statusController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  var dropdownValue;

  void onSubmitSignup() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      setState(() {});
    }
  }

  Future<void> _configureAmplify() async {
    try {
      // amplify plugins

      final apiPlugin = AmplifyAPI();
      final authPlugin = AmplifyAuthCognito();

      // add Amplify plugins
      await Amplify.addPlugins([apiPlugin, authPlugin]);

      await Amplify.configure(amplifyconfig);
    } catch (e) {}
  }

  Future<void> signUpUser() async {
    await _configureAmplify();
    try {
      Navigator.of(context).pushReplacementNamed('/confirmation');
      final userAttributes = <CognitoUserAttributeKey, String>{
        CognitoUserAttributeKey.email: emailController.text,
        CognitoUserAttributeKey.phoneNumber: phoneController.text,
        CognitoUserAttributeKey.givenName: nameController.text,
        CognitoUserAttributeKey.familyName: surnameController.text,
        CognitoUserAttributeKey.address: cityController.text,
        CognitoUserAttributeKey.birthdate: birthdateController.text,
        const CognitoUserAttributeKey.custom("status"): dropdownValue
      };
      final result = await Amplify.Auth.signUp(
        username: emailController.text,
        password: passwordController.text,
        options: CognitoSignUpOptions(userAttributes: userAttributes),
      );
      print(result);
      setState(() {
        var isSignUpComplete = result.isSignUpComplete;
      });
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    // double maxheight = MediaQuery.of(context).size.height;

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
                      height: 1010,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(31),
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child:
                                  Image.asset('assets/images/PAlogowhite.png'),
                            ),
                          ),
                          const Text(
                            'Welcome to',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Text(
                            'Product Arena',
                            style: TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 40),
///////
////////
/////////FORM
////////
                          SizedBox(
                            width: 457,
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  //Name
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          style: GoogleFonts.notoSans(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          cursorColor: const Color(0xFF22E974),
                                          decoration: InputDecoration(
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFF22E974),
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                              ),
                                            ),
                                            border: const OutlineInputBorder(),
                                            label: Text(
                                              'Name',
                                              style: GoogleFonts.notoSans(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: const Color(
                                                  0xFF605D66,
                                                ),
                                              ),
                                            ),
                                          ),
                                          controller: nameController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Name';
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      //Surname
                                      Expanded(
                                        child: TextFormField(
                                          style: GoogleFonts.notoSans(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          cursorColor: const Color(0xFF22E974),
                                          decoration: InputDecoration(
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFF22E974),
                                              ),
                                            ),
                                            focusedErrorBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                              ),
                                            ),
                                            border: const OutlineInputBorder(),
                                            label: Text(
                                              'Surname',
                                              style: GoogleFonts.notoSans(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: const Color(
                                                  0xFF605D66,
                                                ),
                                              ),
                                            ),
                                          ),
                                          controller: surnameController,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                  //Birthdate
                                  TextFormField(
                                    style: GoogleFonts.notoSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    cursorColor: const Color(0xFF22E974),
                                    decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF22E974),
                                        ),
                                      ),
                                      focusedErrorBorder:
                                          const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                      border: const OutlineInputBorder(),
                                      label: Text(
                                        'Birthdate',
                                        style: GoogleFonts.notoSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(
                                            0xFF605D66,
                                          ),
                                        ),
                                      ),
                                    ),
                                    controller: birthdateController,
                                  ),
                                  const SizedBox(height: 30),
                                  //City
                                  TextFormField(
                                    style: GoogleFonts.notoSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    cursorColor: const Color(0xFF22E974),
                                    decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF22E974),
                                        ),
                                      ),
                                      focusedErrorBorder:
                                          const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                      border: const OutlineInputBorder(),
                                      label: Text(
                                        'City',
                                        style: GoogleFonts.notoSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(
                                            0xFF605D66,
                                          ),
                                        ),
                                      ),
                                    ),
                                    controller: cityController,
                                  ),
                                  const SizedBox(height: 30),
                                  //Status
                                  SizedBox(
                                    height: 56,
                                    child: DropdownButtonFormField<String>(
                                      value: dropdownValue,
                                      decoration: InputDecoration(
                                        focusedErrorBorder:
                                            const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.red,
                                          ),
                                        ),
                                        border: const OutlineInputBorder(),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF22E974),
                                            width: 1,
                                          ),
                                        ),
                                        hintText: 'Status',
                                        hintStyle: GoogleFonts.notoSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(
                                            0xFF605D66,
                                          ),
                                        ),
                                      ),
                                      dropdownColor: const Color(0xFFF3F3F9),
                                      items: [
                                        'Student',
                                        'Employed',
                                        'Unemployed'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: GoogleFonts.notoSans(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(
                                                0xFF605D66,
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          dropdownValue = newValue!;
                                        });
                                      },
                                    ),
                                  ),

                                  const SizedBox(height: 30),
                                  //Phone
                                  TextFormField(
                                    style: GoogleFonts.notoSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    cursorColor: const Color(0xFF22E974),
                                    decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF22E974),
                                        ),
                                      ),
                                      focusedErrorBorder:
                                          const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                      border: const OutlineInputBorder(),
                                      label: Text(
                                        'Phone(+123 00 000000)',
                                        style: GoogleFonts.notoSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(
                                            0xFF605D66,
                                          ),
                                        ),
                                      ),
                                    ),
                                    controller: phoneController,
                                  ),
                                  const SizedBox(height: 30),
                                  //email
                                  TextFormField(
                                    style: GoogleFonts.notoSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    cursorColor: const Color(0xFF22E974),
                                    decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF22E974),
                                        ),
                                      ),
                                      focusedErrorBorder:
                                          const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                      border: const OutlineInputBorder(),
                                      label: Text(
                                        'Email',
                                        style: GoogleFonts.notoSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(
                                            0xFF605D66,
                                          ),
                                        ),
                                      ),
                                    ),
                                    controller: emailController,
                                  ),
                                  const SizedBox(height: 30),
                                  //Password
                                  TextFormField(
                                    style: GoogleFonts.notoSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    cursorColor: const Color(0xFF22E974),
                                    decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF22E974),
                                        ),
                                      ),
                                      focusedErrorBorder:
                                          const OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                        ),
                                      ),
                                      border: const OutlineInputBorder(),
                                      label: Text(
                                        'Password',
                                        style: GoogleFonts.notoSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(
                                            0xFF605D66,
                                          ),
                                        ),
                                      ),
                                    ),
                                    controller: passwordController,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          /////////////
                          ///////////
                          ///////////
                          const SizedBox(height: 23),
                          SizedBox(
                            width: 457,
                            child: InkWell(
                              child: Text(
                                'By creating an account, you agree to our  Terms and have read and acknowledge the Global Privacy Statement.',
                                style: GoogleFonts.notoSans(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(
                                    0xFF605D66,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 23),
                          SizedBox(
                            width: 452,
                            height: 56,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              onPressed: () {
                                signUpUser();
                                // Navigator.of(context)
                                //     .pushReplacementNamed('/confirmation');
                              },
                              child: const Text(
                                'Create your Account',
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
