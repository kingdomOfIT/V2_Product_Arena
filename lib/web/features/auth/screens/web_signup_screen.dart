// ignore_for_file: use_key_in_widget_constructors, avoid_print, prefer_typing_uninitialized_variables, depend_on_referenced_packages, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/amplifyconfiguration.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_login_screen.dart';
import 'package:v2_product_arena/web/providers/web_auth_provider.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_appbar.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_footer.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:provider/provider.dart';

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

  var _text = '';

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
      Provider.of<WebAuth>(context).email = emailController.text;
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
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/webbackground.png'),
                        fit: BoxFit.cover),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 60),
                    child: Center(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width * 0.51,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(31),
                              child: SizedBox(
                                width: 100,
                                height: 100,
                                child: Image.asset(
                                    'assets/images/PAlogowhite.png'),
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
                                            cursorColor:
                                                const Color(0xFF22E974),
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
                                              border:
                                                  const OutlineInputBorder(),
                                              label: Text(
                                                'Name',
                                                style: GoogleFonts.notoSans(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            onChanged: (text) =>
                                                setState(() => _text),
                                            controller: nameController,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please fill the required field.';
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
                                            cursorColor:
                                                const Color(0xFF22E974),
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
                                              border:
                                                  const OutlineInputBorder(),
                                              label: Text(
                                                'Surname',
                                                style: GoogleFonts.notoSans(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                            controller: surnameController,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please fill the required field.';
                                              } else {
                                                return null;
                                              }
                                            },
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
                                          ),
                                        ),
                                      ),
                                      controller: birthdateController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please fill the required field.';
                                        }
                                        if (value.length < 10) {
                                          return 'Insert correct format DD-MM-YYYY';
                                        } else {
                                          return null;
                                        }
                                      },
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
                                          ),
                                        ),
                                      ),
                                      controller: cityController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please fill the required field.';
                                        } else {
                                          return null;
                                        }
                                      },
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
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF22E974),
                                              width: 1,
                                            ),
                                          ),
                                          hintText: 'Status',
                                          hintStyle: GoogleFonts.notoSans(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
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
                                          ),
                                        ),
                                      ),
                                      controller: phoneController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please fill the required field.';
                                        } else {
                                          return null;
                                        }
                                      },
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
                                          ),
                                        ),
                                      ),
                                      controller: emailController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please fill the required field.';
                                        }
                                        if (!value.contains('@')) {
                                          return 'Invalid email address';
                                        }
                                        if (!value.contains('.com')) {
                                          return 'Invalid email address';
                                        } else {
                                          return null;
                                        }
                                      },
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
                                          ),
                                        ),
                                      ),
                                      controller: passwordController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please fill the required field.';
                                        } else {
                                          return null;
                                        }
                                      },
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

                            Padding(
                              padding: const EdgeInsets.all(30),
                              child: SizedBox(
                                width: 452,
                                height: 56,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {}
                                    Navigator.of(context)
                                        .pushReplacementNamed('/confirmation');

                                    // signUpUser();
                                  },
                                  child: const Text(
                                    'Create your Account',
                                  ),
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
