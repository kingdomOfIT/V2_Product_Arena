import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/constants/global_variables.dart';

// ignore: must_be_immutable
class MobileSignupForm extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController surnameController;
  final TextEditingController birthDateController;
  final TextEditingController cityController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final FocusNode surnameFocusNode;
  final FocusNode birthDateFocusNode;
  final FocusNode cityFocusNode;
  final FocusNode phoneFocusNode;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;
  final GlobalKey formKey;
  String? selectedValue;

  final TextEditingController passwordController;
  MobileSignupForm({
    super.key,
    required this.nameController,
    required this.surnameController,
    required this.birthDateController,
    required this.cityController,
    required this.emailController,
    required this.passwordController,
    required this.phoneController,
    required this.surnameFocusNode,
    required this.birthDateFocusNode,
    required this.cityFocusNode,
    required this.phoneFocusNode,
    required this.emailFocusNode,
    required this.passwordFocusNode,
    required this.formKey,
    required this.selectedValue,
  });

  @override
  State<MobileSignupForm> createState() => _MobileSignupFormState();
}

class _MobileSignupFormState extends State<MobileSignupForm> {
  RegExp birthDate =
      RegExp(r'^(1[0-2]|0[1-9])/(3[01]|[12][0-9]|0[1-9])/[0-9]{4}$');

  RegExp phoneNumber = RegExp(r'^[0-9]+$');

  RegExp email = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  RegExp password =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Form(
      key: widget.formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            key: const Key('nameTextField'),
            controller: widget.nameController,
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
                    color: Color.fromRGBO(34, 233, 116, 1),
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
              } else {
                return null;
              }
            },
            onEditingComplete: () =>
                FocusScope.of(context).requestFocus(widget.surnameFocusNode),
          ),
          SizedBox(
            height: deviceHeight * 0.032,
          ),
          TextFormField(
            key: const Key('surnameTextField'),
            controller: widget.surnameController,
            focusNode: widget.surnameFocusNode,
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
                    color: Color.fromRGBO(34, 233, 116, 1),
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
              } else {
                return null;
              }
            },
            onEditingComplete: () =>
                FocusScope.of(context).requestFocus(widget.surnameFocusNode),
          ),
          SizedBox(
            height: deviceHeight * 0.032,
          ),
          TextFormField(
            key: const Key('birthDateTextField'),
            controller: widget.birthDateController,
            focusNode: widget.birthDateFocusNode,
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
                    color: Color.fromRGBO(34, 233, 116, 1),
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
              } else {
                return null;
              }
            },
            onEditingComplete: () =>
                FocusScope.of(context).requestFocus(widget.cityFocusNode),
          ),
          SizedBox(
            height: deviceHeight * 0.032,
          ),
          TextFormField(
            key: const Key('cityTextField'),
            controller: widget.cityController,
            focusNode: widget.cityFocusNode,
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
                    color: Color.fromRGBO(34, 233, 116, 1),
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
              } else {
                return null;
              }
            },
            onEditingComplete: () => FocusScope.of(context).unfocus(),
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
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              value: widget.selectedValue,
              onChanged: (value) {
                setState(() {
                  widget.selectedValue = value!;
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
            controller: widget.phoneController,
            focusNode: widget.phoneFocusNode,
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
                    color: Color.fromRGBO(34, 233, 116, 1),
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
              else {
                return null;
              }
            },
            onEditingComplete: () =>
                FocusScope.of(context).requestFocus(widget.emailFocusNode),
          ),
          SizedBox(
            height: deviceHeight * 0.032,
          ),
          TextFormField(
            key: const Key('emailTextField'),
            controller: widget.emailController,
            focusNode: widget.emailFocusNode,
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
                    color: Color.fromRGBO(34, 233, 116, 1),
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
              } else {
                return null;
              }
            },
            onEditingComplete: () =>
                FocusScope.of(context).requestFocus(widget.passwordFocusNode),
          ),
          SizedBox(
            height: deviceHeight * 0.032,
          ),
          TextFormField(
            key: const Key('passwordTextField'),
            controller: widget.passwordController,
            focusNode: widget.passwordFocusNode,
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
                    color: Color.fromRGBO(34, 233, 116, 1),
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
              } else {
                return null;
              }
            },
            onEditingComplete: () => FocusScope.of(context).unfocus(),
          ),
        ],
      ),
    );
  }
}
