// ignore_for_file: depend_on_referenced_packages, body_might_complete_normally_nullable, sort_child_properties_last, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:v2_product_arena/constants/global_variables.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/email_verification_screen.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/mobile_login_screen.dart';
import 'package:v2_product_arena/mobile/providers/mobile_auth_provider.dart';
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/custom_button.dart';
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/mobile_appbar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/mobile_footer.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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

  String text = '';

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
      RegExp(r'^(0[1-9]|[1-2][0-9]|3[0-1])-(0[1-9]|1[0-2])-\d{4}$');

  RegExp email = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  RegExp password = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$%^&+=]).{8,16}$');

  bool isLoading = false;
  String dialCodeDigits = '+387';

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

      birthDateController.text = formattedDate;
    });
  }

  void navigateToEmailVerificationScreen(BuildContext context) {
    Navigator.of(context)
        .pushReplacementNamed(EmailVerificationScreen.routeName);
  }

  void onSubmitSignUp() async {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
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
      // ignore: use_build_context_synchronously
      Provider.of<MobileAuth>(context, listen: false).userEmail =
          emailController.text;
      // ignore: use_build_context_synchronously
      Provider.of<MobileAuth>(context, listen: false).userPassword =
          passwordController.text;
    }
    setState(() {
      isLoading = false;
    });
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
      body: isLoading
          ? const Center(
              child: SpinKitRing(
                color: Color.fromRGBO(34, 233, 116, 1),
                size: 90.0,
                lineWidth: 10.0,
              ),
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
                          Form(
                            key: formKey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  key: const Key('nameTextField'),
                                  controller: nameController,
                                  style: GoogleFonts.notoSans(
                                    color: mobileAuth.isNameError
                                        ? Colors.red
                                        : Colors.black,
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
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    suffixIcon: Icon(
                                      mobileAuth.isNameError
                                          ? Icons.error
                                          : null,
                                      color: Colors.red,
                                      size: deviceHeight * 0.03,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      mobileAuth.isNameError = true;

                                      return 'Please fill the required field.';
                                    } else if (value.length < 4) {
                                      mobileAuth.isNameError = true;

                                      return 'Name must contain a minimum of 4 characters.';
                                    } else {
                                      mobileAuth.isNameError = false;
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
                                    color: mobileAuth.isSurnameError
                                        ? Colors.red
                                        : Colors.black,
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
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    suffixIcon: Icon(
                                      mobileAuth.isSurnameError
                                          ? Icons.error
                                          : null,
                                      color: Colors.red,
                                      size: deviceHeight * 0.03,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      mobileAuth.isSurnameError = true;
                                      return 'Please fill the required field.';
                                    } else if (value.length < 4) {
                                      mobileAuth.isSurnameError = true;
                                      return 'Surname must contain a minimum of 4 characters.';
                                    } else {
                                      mobileAuth.isSurnameError = false;
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
                                    color: mobileAuth.isBirthDateError
                                        ? Colors.red
                                        : Colors.black,
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
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    prefixIcon: InkWell(
                                      key: const Key('datePicker'),
                                      onTap: _selectBirthDate,
                                      child: Icon(
                                        Icons.calendar_month,
                                        size: deviceHeight * 0.03,
                                      ),
                                    ),
                                    suffixIcon: Icon(
                                      mobileAuth.isBirthDateError
                                          ? Icons.error
                                          : null,
                                      color: Colors.red,
                                      size: deviceHeight * 0.03,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      mobileAuth.isBirthDateError = true;
                                      return 'Please fill the required field.';
                                    } else if (!birthDate.hasMatch(value)) {
                                      mobileAuth.isBirthDateError = true;
                                      return 'Invalid birth date format. Valid format: dd-mm-yyyy';
                                    } else {
                                      mobileAuth.isBirthDateError = false;
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
                                    color: mobileAuth.isBirthDateError
                                        ? Colors.red
                                        : Colors.black,
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
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    suffixIcon: Icon(
                                      mobileAuth.isCityError
                                          ? Icons.error
                                          : null,
                                      color: Colors.red,
                                      size: deviceHeight * 0.03,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      mobileAuth.isCityError = true;
                                      return 'Please fill the required field.';
                                    } else {
                                      mobileAuth.isCityError = false;
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
                                    key: const Key('dropDownButton'),
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
                                    color: mobileAuth.isPhoneNumError
                                        ? Colors.red
                                        : Colors.black,
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
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    // prefix: Container(
                                    //   child: SizedBox(
                                    //     width: 120,
                                    //     height: 50,
                                    //     child: CountryCodePicker(
                                    //       key: const Key('countryCodePicker'),
                                    //       onChanged: (country) {
                                    //         setState(() {
                                    //           dialCodeDigits =
                                    //               country.dialCode!;
                                    //         });
                                    //       },
                                    //       initialSelection: "BA",
                                    //       showCountryOnly: false,
                                    //       showOnlyCountryWhenClosed: false,
                                    //       // flagWidth: 20,
                                    //       favorite: const ["+387", "BA"],
                                    //     ),
                                    //   ),
                                    // ),
                                    suffixIcon: Icon(
                                      mobileAuth.isPhoneNumError
                                          ? Icons.error
                                          : null,
                                      color: Colors.red,
                                      size: deviceHeight * 0.03,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      mobileAuth.isPhoneNumError = true;
                                      return 'Please fill the required field.';
                                    } else if (value.length < 9) {
                                      mobileAuth.isPhoneNumError = true;
                                      return 'Phone number must contain a minimum of 9 numbers.';
                                    } else if (!value.startsWith('+')) {
                                      return 'Invalid format. Valid format: +066405798';
                                    } else {
                                      mobileAuth.isPhoneNumError = false;
                                    }
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
                                    color: mobileAuth.isEmailError
                                        ? Colors.red
                                        : Colors.black,
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
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    suffixIcon: Icon(
                                      mobileAuth.isEmailError
                                          ? Icons.error
                                          : null,
                                      color: Colors.red,
                                      size: deviceHeight * 0.03,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      mobileAuth.isEmailError = true;
                                      return 'Please fill the required field.';
                                    } else if (!email.hasMatch(value)) {
                                      mobileAuth.isEmailError = true;
                                      return 'Invalid email format';
                                    } else {
                                      mobileAuth.isEmailError = false;
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
                                  key: const Key('passwordSignUpTextField'),
                                  controller: passwordController,
                                  style: GoogleFonts.notoSans(
                                    color: mobileAuth.isPasswordError
                                        ? Colors.red
                                        : Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  obscureText: isHiddenPassword,
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
                                      vertical: deviceHeight * 0.018,
                                      horizontal: deviceWidth * 0.05,
                                    ),
                                    suffixIcon: text.isNotEmpty
                                        ? InkWell(
                                            key: const Key(
                                                'togglePasswordViewSignup'),
                                            onTap: togglePasswordView,
                                            child: Icon(
                                              isHiddenPassword
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: mobileAuth
                                                      .isLoginPasswordError
                                                  ? Colors.red
                                                  : null,
                                              size: deviceHeight * 0.03,
                                            ),
                                          )
                                        : null,
                                    label: Text(
                                      'Password',
                                      style: GoogleFonts.notoSans(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  focusNode: passwordFocusNode,
                                  onChanged: (value) {
                                    setState(() {
                                      text = value;
                                    });
                                  },
                                  onEditingComplete: () =>
                                      FocusScope.of(context).unfocus(),
                                  validator: (value) {
                                    if (value == null || value == '') {
                                      mobileAuth.isLoginPasswordError = true;
                                      return 'Please fill the required field.';
                                    } else if (!password.hasMatch(value)) {
                                      mobileAuth.isLoginPasswordError = true;
                                      return 'Password must contain a minimum of 8 characters, uppercase, lower case, number and special character.';
                                    } else {
                                      mobileAuth.isLoginPasswordError = false;
                                    }
                                  },
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
                            key: const Key('createYourAccount'),
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
                                  mobileAuth.isEmailError = false;
                                  mobileAuth.isNameError = false;
                                  mobileAuth.isSurnameError = false;
                                  mobileAuth.isBirthDateError = false;
                                  mobileAuth.isCityError = false;
                                  mobileAuth.isPhoneNumError = false;
                                  mobileAuth.isPasswordError = false;
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
