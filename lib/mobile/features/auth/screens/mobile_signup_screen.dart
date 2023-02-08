// ignore_for_file: depend_on_referenced_packages, body_might_complete_normally_nullable, sort_child_properties_last, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:v2_product_arena/constants/global_variables.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/email_verification_screen.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/mobile_login_screen.dart';
import 'package:v2_product_arena/mobile/features/auth/widgets/mobile_signup_form.dart';
import 'package:v2_product_arena/mobile/providers/mobile_auth_provider.dart';
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/custom_button.dart';
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/mobile_appbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/mobile_footer.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:provider/provider.dart';

class MobileSignupScreen extends StatefulWidget {
  static const routeName = '/mobile-signup';

  const MobileSignupScreen({super.key});

  @override
  State<MobileSignupScreen> createState() => _MobileSignupScreenState();
}

class _MobileSignupScreenState extends State<MobileSignupScreen> {
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final birthDateController = TextEditingController();
  final cityController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final surnameFocusNode = FocusNode();
  final birthDateFocusNode = FocusNode();
  final cityFocusNode = FocusNode();
  final phoneFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  void dispose() {
    nameController.dispose();
    surnameController.dispose();
    birthDateController.dispose();
    cityController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();

    surnameFocusNode.dispose();
    birthDateFocusNode.dispose();
    cityFocusNode.dispose();
    phoneFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  String? selectedValue;
  bool isHiddenPassword = true;

  RegExp birthDate =
      RegExp(r'^(1[0-2]|0[1-9])/(3[01]|[12][0-9]|0[1-9])/[0-9]{4}$');

  RegExp phoneNumber = RegExp(r'^[0-9]+$');

  RegExp email = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  RegExp password =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  bool isLoading = false;

  void onSubmitSignUp() async {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      formKey.currentState!.save();
      //  Provider.of<MobileAuth>(context, listen: false).isLoading = true;
      // setState(() {
      //   isLoading = true;
      // });
      await Provider.of<MobileAuth>(context, listen: false).signUpUser(
        nameController.text,
        surnameController.text,
        birthDateController.text,
        cityController.text,
        selectedValue!,
        phoneController.text,
        emailController.text,
        passwordController.text,
        context,
        EmailVerificationScreen.routeName,
      );
      Provider.of<MobileAuth>(context, listen: false).userEmail =
          emailController.text;
      //Provider.of<MobileAuth>(context, listen: false).isLoading = false;
    }
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
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
      body: Provider.of<MobileAuth>(context, listen: false).isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        left: deviceWidth * 0.089,
                        right: deviceWidth * 0.089,
                        top: deviceHeight * 0.053,
                      ),
                      child: Column(
                        children: <Widget>[
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
                            height: deviceHeight * 0.05,
                          ),
                          // MobileSignupForm(
                          //   nameController: nameController,
                          //   surnameController: surnameController,
                          //   birthDateController: birthDateController,
                          //   cityController: cityController,
                          //   emailController: emailController,
                          //   passwordController: passwordController,
                          //   phoneController: phoneController,
                          //   surnameFocusNode: surnameFocusNode,
                          //   birthDateFocusNode: birthDateFocusNode,
                          //   cityFocusNode: cityFocusNode,
                          //   phoneFocusNode: phoneFocusNode,
                          //   emailFocusNode: emailFocusNode,
                          //   passwordFocusNode: passwordFocusNode,
                          //   formKey: formKey,
                          //   selectedValue: selectedValue,
                          // ),
                          Form(
                            key: formKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  key: const Key('nameTextField'),
                                  controller: nameController,
                                  style: GoogleFonts.notoSans(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelStyle: const TextStyle(fontSize: 20),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(34, 233, 116, 1),
                                        )),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        )),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: deviceHeight * 0.02,
                                      horizontal: deviceWidth * 0.05,
                                    ),
                                    label: Text(
                                      'Name',
                                      style: GoogleFonts.notoSans(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please fill the required field.';
                                    }
                                    if (value.length < 4) {
                                      return 'Name must contain a minimum of 4 characters.';
                                    }
                                  },
                                  onEditingComplete: () =>
                                      FocusScope.of(context)
                                          .requestFocus(surnameFocusNode),
                                ),
                                SizedBox(
                                  height: deviceHeight * 0.032,
                                ),
                                TextFormField(
                                  key: const Key('surnameTextField'),
                                  controller: surnameController,
                                  focusNode: surnameFocusNode,
                                  style: GoogleFonts.notoSans(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelStyle: const TextStyle(fontSize: 20),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(34, 233, 116, 1),
                                        )),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        )),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: deviceHeight * 0.02,
                                      horizontal: deviceWidth * 0.05,
                                    ),
                                    label: Text(
                                      'Surname',
                                      style: GoogleFonts.notoSans(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please fill the required field.';
                                    }
                                    if (value.length < 4) {
                                      return 'Surname must contain a minimum of 4 characters.';
                                    }
                                  },
                                  onEditingComplete: () =>
                                      FocusScope.of(context)
                                          .requestFocus(surnameFocusNode),
                                ),
                                SizedBox(
                                  height: deviceHeight * 0.032,
                                ),
                                TextFormField(
                                  key: const Key('birthDateTextField'),
                                  controller: birthDateController,
                                  focusNode: birthDateFocusNode,
                                  style: GoogleFonts.notoSans(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelStyle: const TextStyle(fontSize: 20),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(34, 233, 116, 1),
                                        )),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        )),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: deviceHeight * 0.02,
                                      horizontal: deviceWidth * 0.05,
                                    ),
                                    label: Text(
                                      'Birth Date',
                                      style: GoogleFonts.notoSans(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please fill the required field.';
                                    }
                                    if (value.length < 10) {
                                      return 'Invalid birth date format';
                                    }
                                  },
                                  onEditingComplete: () =>
                                      FocusScope.of(context)
                                          .requestFocus(cityFocusNode),
                                ),
                                SizedBox(
                                  height: deviceHeight * 0.032,
                                ),
                                TextFormField(
                                  key: const Key('cityTextField'),
                                  controller: cityController,
                                  focusNode: cityFocusNode,
                                  style: GoogleFonts.notoSans(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelStyle: const TextStyle(fontSize: 20),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(34, 233, 116, 1),
                                        )),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        )),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: deviceHeight * 0.02,
                                      horizontal: deviceWidth * 0.05,
                                    ),
                                    label: Text(
                                      'City',
                                      style: GoogleFonts.notoSans(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please fill the required field.';
                                    }
                                  },
                                  onEditingComplete: () =>
                                      FocusScope.of(context).unfocus(),
                                ),
                                SizedBox(
                                  height: deviceHeight * 0.032,
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                    top: deviceWidth * 0.0115,
                                    bottom: deviceWidth * 0.0115,
                                    left: deviceWidth * 0.035,
                                    right: deviceWidth * 0.02,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: DropdownButton<String>(
                                    items: GlobalVariables.status
                                        .map((e) => DropdownMenuItem(
                                              child: Text(e),
                                              value: e,
                                            ))
                                        .toList(),
                                    value: selectedValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedValue = value!;
                                      });
                                    },
                                    hint: Text(
                                      'Status',
                                      style: GoogleFonts.notoSans(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w700,
                                        fontSize: deviceHeight * 0.02,
                                      ),
                                    ),
                                    isExpanded: true,
                                    style: GoogleFonts.notoSans(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700,
                                      fontSize: deviceHeight * 0.02,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: deviceHeight * 0.032,
                                ),
                                TextFormField(
                                  key: const Key('phoneTextField'),
                                  controller: phoneController,
                                  focusNode: phoneFocusNode,
                                  style: GoogleFonts.notoSans(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelStyle: const TextStyle(fontSize: 20),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(34, 233, 116, 1),
                                        )),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        )),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: deviceHeight * 0.02,
                                      horizontal: deviceWidth * 0.05,
                                    ),
                                    label: Text(
                                      'Phone',
                                      style: GoogleFonts.notoSans(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please fill the required field.';
                                    }
                                    // if (!phoneNumber.hasMatch(value)) {
                                    //   return 'Enter a valid number';
                                    // }
                                  },
                                  onEditingComplete: () =>
                                      FocusScope.of(context)
                                          .requestFocus(emailFocusNode),
                                ),
                                SizedBox(
                                  height: deviceHeight * 0.032,
                                ),
                                TextFormField(
                                  key: const Key('emailTextField'),
                                  controller: emailController,
                                  focusNode: emailFocusNode,
                                  style: GoogleFonts.notoSans(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelStyle: const TextStyle(fontSize: 20),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(34, 233, 116, 1),
                                        )),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        )),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: deviceHeight * 0.02,
                                      horizontal: deviceWidth * 0.05,
                                    ),
                                    label: Text(
                                      'Email',
                                      style: GoogleFonts.notoSans(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please fill the required field.';
                                    }
                                    if (!email.hasMatch(value)) {
                                      return 'Invalid email format';
                                    }
                                  },
                                  onEditingComplete: () =>
                                      FocusScope.of(context)
                                          .requestFocus(passwordFocusNode),
                                ),
                                SizedBox(
                                  height: deviceHeight * 0.032,
                                ),
                                TextFormField(
                                  key: const Key('passwordTextField'),
                                  controller: passwordController,
                                  focusNode: passwordFocusNode,
                                  obscureText: isHiddenPassword,
                                  style: GoogleFonts.notoSans(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    suffixIcon: InkWell(
                                        onTap: togglePasswordView,
                                        child: Icon(
                                          isHiddenPassword
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          size: deviceHeight * 0.027,
                                        )),
                                    isDense: true,
                                    labelStyle: const TextStyle(fontSize: 20),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color:
                                              Color.fromRGBO(34, 233, 116, 1),
                                        )),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(
                                          color: Colors.black,
                                        )),
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: deviceHeight * 0.02,
                                      horizontal: deviceWidth * 0.05,
                                    ),
                                    label: Text(
                                      'Password',
                                      style: GoogleFonts.notoSans(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    errorMaxLines: 2,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please fill the required field.';
                                    }
                                    if (value.length < 8) {
                                      return 'Password must contain a minimum of 8 characters, uppercase, lower case, number and special character.';
                                    }
                                    if (!password.hasMatch(value)) {
                                      return 'Password must contain a minimum of 8 characters, uppercase, lower case, number and special character.';
                                    }
                                  },
                                  onEditingComplete: () =>
                                      FocusScope.of(context).unfocus(),
                                ),
                                mobileAuth.isSignUpComplete == false
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Text(
                                          mobileAuth.errorText,
                                          style: const TextStyle(
                                              color: Colors.red),
                                        ),
                                      )
                                    : SizedBox(
                                        height: deviceHeight * 0.06,
                                      ),
                              ],
                            ),
                          ),
                          // mobileAuth.isSignUpComplete == false
                          //     ? Padding(
                          //         padding: const EdgeInsets.symmetric(vertical: 10),
                          //         child: Text(
                          //           mobileAuth.errorText,
                          //           style: const TextStyle(color: Colors.red),
                          //         ),
                          //       )
                          //     : SizedBox(
                          //         height: deviceHeight * 0.06,
                          //       ),
                          SizedBox(
                            height: deviceHeight * 0.04,
                          ),
                          Text(
                            'By creating an account, you agree to our  Terms and have read and acknowledge the Global Privacy Statement.',
                            style: GoogleFonts.notoSans(
                              fontSize: deviceHeight * 0.013,
                              color: Colors.black54,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.left,
                            softWrap: true,
                          ),
                          SizedBox(
                            height: deviceHeight * 0.032,
                          ),
                          CustomButton(
                            content: Text(
                              'Create Your Account',
                              style: GoogleFonts.notoSans(
                                fontSize: deviceHeight * 0.0187,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            buttonFunction: onSubmitSignUp,
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
                            height: deviceHeight * 0.076,
                          ),
                          Container(
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
                    SizedBox(
                      height: deviceHeight * 0.03,
                    ),
                    const MobileFooter(),
                  ],
                ),
              ),
            ),
    );
  }
}
