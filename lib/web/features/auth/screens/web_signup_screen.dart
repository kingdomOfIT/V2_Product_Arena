// ignore_for_file: use_key_in_widget_constructors, avoid_print, prefer_typing_uninitialized_variables, depend_on_referenced_packages, unused_local_variable, use_build_context_synchronously, body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_login_screen.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_verification_screen.dart';
import 'package:v2_product_arena/web/providers/web_auth_provider.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_appbar.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_footer.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../../../../mobile/features/auth/screens/mobile_signup_screen.dart';

class WebSignUpScreen extends StatefulWidget {
  static const routeName = '/signup';

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
  var dropdownValueError;

  String _text = '';
  bool isHiddenPassword = true;
  bool isLoading = false;

  void navigateToEmailVerificationScreen(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(SignupConfirmation.routeName);
  }

  void onSubmitSignUp() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      final provider = Provider.of<WebAuth>(context, listen: false);
      await provider.signUpUser(
        nameController.text,
        surnameController.text,
        birthdateController.text,
        cityController.text,
        dropdownValue!,
        phoneController.text,
        emailController.text.trim(),
        passwordController.text,
        context,
        SignupConfirmation.routeName,
      );

      provider.userEmail = emailController.text;
      provider.userPassword = passwordController.text;
    }
    setState(() {
      isLoading = false;
    });
  }

  RegExp birthDate =
      RegExp(r'^(0[1-9]|[1-2][0-9]|3[0-1])-(0[1-9]|1[0-2])-\d{4}$');

  RegExp phoneNumber = RegExp(r'^[0-9]+$');

  RegExp email = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  DateTime date = DateTime(2022, 02, 02);

  void _selectBirthDate() {
    showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      String formattedDate = DateFormat("dd-MM-yyyy").format(pickedDate);

      birthdateController.text = formattedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    final maxheight = MediaQuery.of(context).size.height;
    final webAuth = Provider.of<WebAuth>(context, listen: false);

    if (MediaQuery.of(context).size.width < 600 ||
        MediaQuery.of(context).size.height < 600) {
      return const MobileSignupScreen();
    }

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
                              width: maxwidth * (452 / 1440),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        //Name
                                        Expanded(
                                          child: TextFormField(
                                            key: const Key('nameSignup'),
                                            style: GoogleFonts.notoSans(
                                              color: webAuth.isNameError
                                                  ? const Color(0xFFB3261E)
                                                  : Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            cursorColor:
                                                const Color(0xFF22E974),
                                            decoration: InputDecoration(
                                              suffixIcon: Icon(
                                                webAuth.isNameError
                                                    ? Icons.error
                                                    : null,
                                                color: const Color(0xFFB3261E),
                                              ),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFF22E974),
                                                ),
                                              ),
                                              focusedErrorBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFFB3261E),
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
                                            onChanged: (value) =>
                                                setState(() => _text),
                                            controller: nameController,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                webAuth.isNameError = true;
                                                return 'Please fill the required field.';
                                              } else if (value.length < 4) {
                                                webAuth.isNameError = true;
                                                return 'Name must contain a minimum of 4 characters.';
                                              } else {
                                                webAuth.isNameError = false;
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        //Surname
                                        Expanded(
                                          child: TextFormField(
                                            key: const Key('surnameSignup'),
                                            style: GoogleFonts.notoSans(
                                              color: webAuth.isSurnameError
                                                  ? const Color(0xFFB3261E)
                                                  : Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            cursorColor:
                                                const Color(0xFF22E974),
                                            decoration: InputDecoration(
                                              suffixIcon: Icon(
                                                webAuth.isSurnameError
                                                    ? Icons.error
                                                    : null,
                                                color: const Color(0xFFB3261E),
                                              ),
                                              focusedBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFF22E974),
                                                ),
                                              ),
                                              focusedErrorBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Color(0xFFB3261E),
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
                                                webAuth.isSurnameError = true;
                                                return 'Please fill the required field.';
                                              } else if (value.length < 4) {
                                                webAuth.isSurnameError = true;
                                                return 'Surname must contain a minimum of 4 characters.';
                                              } else {
                                                webAuth.isSurnameError = false;
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
                                      key: const Key('birthdateSignup'),
                                      style: GoogleFonts.notoSans(
                                        color: webAuth.isBirthDateError
                                            ? const Color(0xFFB3261E)
                                            : Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      cursorColor: const Color(0xFF22E974),
                                      decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          webAuth.isBirthDateError
                                              ? Icons.error
                                              : null,
                                          color: const Color(0xFFB3261E),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF22E974),
                                          ),
                                        ),
                                        prefixIcon: InkWell(
                                          key: const Key('datePicker'),
                                          onTap: _selectBirthDate,
                                          child: Icon(
                                            Icons.calendar_month,
                                            size: maxheight * 0.03,
                                          ),
                                        ),
                                        focusedErrorBorder:
                                            const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFB3261E),
                                          ),
                                        ),
                                        border: const OutlineInputBorder(),
                                        label: Text(
                                          'Birth date',
                                          style: GoogleFonts.notoSans(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      controller: birthdateController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          webAuth.isBirthDateError = true;
                                          return 'Please fill the required field.';
                                        }
                                        if (!birthDate.hasMatch(value)) {
                                          webAuth.isBirthDateError = true;
                                          return 'Invalid birth date format. Valid format: dd-mm-yyyy';
                                        } else {
                                          webAuth.isBirthDateError = false;
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 30),
                                    //City
                                    TextFormField(
                                      key: const Key('citySignup'),
                                      style: GoogleFonts.notoSans(
                                        color: webAuth.isCityError
                                            ? const Color(0xFFB3261E)
                                            : Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      cursorColor: const Color(0xFF22E974),
                                      decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          webAuth.isCityError
                                              ? Icons.error
                                              : null,
                                          color: const Color(0xFFB3261E),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF22E974),
                                          ),
                                        ),
                                        focusedErrorBorder:
                                            const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFB3261E),
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
                                          webAuth.isCityError = true;
                                          return 'Please fill the required field.';
                                        } else {
                                          webAuth.isCityError = false;
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 30),
                                    //Status
                                    SizedBox(
                                      height: 56,
                                      child: SingleChildScrollView(
                                        child: DropdownButtonFormField<String>(
                                          key:
                                              const Key('dropdownButtonSignup'),
                                          value: dropdownValue,
                                          decoration: InputDecoration(
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
                                          dropdownColor:
                                              const Color(0xFFF3F3F9),
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
                                              dropdownValueError = null;
                                            });
                                          },
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please select a status!';
                                            }
                                            return dropdownValueError;
                                          },
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 30),
                                    //Phone
                                    TextFormField(
                                        key: const Key('phoneSignup'),
                                        style: GoogleFonts.notoSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: webAuth.isPhoneNumError
                                              ? const Color(0xFFB3261E)
                                              : Colors.black,
                                        ),
                                        cursorColor: const Color(0xFF22E974),
                                        decoration: InputDecoration(
                                          suffixIcon: Icon(
                                            webAuth.isPhoneNumError
                                                ? Icons.error
                                                : null,
                                            color: const Color(0xFFB3261E),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF22E974),
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              const OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFFB3261E),
                                            ),
                                          ),
                                          border: const OutlineInputBorder(),
                                          label: Text(
                                            'Phone',
                                            style: GoogleFonts.notoSans(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        controller: phoneController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            webAuth.isPhoneNumError = true;
                                            return 'Please fill the required field.';
                                          } else if (value.length < 9) {
                                            webAuth.isPhoneNumError = true;
                                            return 'Phone number must contain a minimum of 9 numbers.';
                                          } else {
                                            webAuth.isPhoneNumError = false;
                                          }
                                        }),
                                    const SizedBox(height: 30),
                                    //email
                                    TextFormField(
                                      key: const Key('emailSignup'),
                                      style: GoogleFonts.notoSans(
                                        color: webAuth.isPhoneNumError
                                            ? const Color(0xFFB3261E)
                                            : Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      cursorColor: const Color(0xFF22E974),
                                      decoration: InputDecoration(
                                        suffixIcon: Icon(
                                          webAuth.isEmailError
                                              ? Icons.error
                                              : null,
                                          color: const Color(0xFFB3261E),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF22E974),
                                          ),
                                        ),
                                        focusedErrorBorder:
                                            const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFFB3261E),
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
                                          webAuth.isEmailError = true;
                                          return 'Please fill the required field.';
                                        }
                                        if (!email.hasMatch(value)) {
                                          webAuth.isEmailError = true;
                                          return 'Invalid email format';
                                        } else {
                                          webAuth.isEmailError = false;
                                          return null;
                                        }
                                      },
                                    ),
                                    const SizedBox(height: 30),
                                    //Password
                                    TextFormField(
                                      key: const Key('passwordSignup'),
                                      obscureText: isHiddenPassword,
                                      style: GoogleFonts.notoSans(
                                        color: webAuth.isPhoneNumError
                                            ? const Color(0xFFB3261E)
                                            : Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      cursorColor: const Color(0xFF22E974),
                                      decoration: InputDecoration(
                                        suffixIcon: _text.isNotEmpty
                                            ? InkWell(
                                                key: const Key(
                                                    'togglePasswordView'),
                                                onTap: togglePasswordView,
                                                child: Icon(
                                                  isHiddenPassword
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: webAuth.isPasswordError
                                                      ? const Color(0xFFB3261E)
                                                      : null,
                                                  size: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.027,
                                                ),
                                              )
                                            : null,
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0xFF22E974),
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
                                        errorMaxLines: 2,
                                      ),
                                      controller: passwordController,
                                      validator: (value) {
                                        RegExp password = RegExp(
                                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                        if (value!.isEmpty) {
                                          webAuth.isPasswordError = true;
                                          return 'Please fill the required field.';
                                        } else if (value.length < 8) {
                                          webAuth.isPasswordError = true;

                                          return 'Password must contain a minimum of 8 characters, uppercase, lower case, number and special character.';
                                        } else if (!password.hasMatch(value)) {
                                          webAuth.isPasswordError = true;

                                          return 'Password must contain a minimum of 8 characters, uppercase, lower case, number and special character.';
                                        } else {
                                          webAuth.isPasswordError = false;
                                          return null;
                                        }
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          _text = value;
                                        });
                                      },
                                      onEditingComplete: () =>
                                          FocusScope.of(context).unfocus(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            /////////////
                            ///////////
                            ///////////
                            webAuth.isSignUpComplete == false
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                      webAuth.errorText,
                                      style: const TextStyle(
                                          color: Color(0xFFB3261E)),
                                    ),
                                  )
                                : SizedBox(
                                    height: maxheight * 0.06,
                                  ),
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
                                  key: const Key('signupButton'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                  ),
                                  onPressed: onSubmitSignUp,
                                  child: Text(
                                    'Create your Account',
                                    style: GoogleFonts.notoSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
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
