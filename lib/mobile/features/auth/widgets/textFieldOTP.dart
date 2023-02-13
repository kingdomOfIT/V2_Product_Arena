import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/mobile/providers/mobile_auth_provider.dart';

class TextFieldOTP extends StatelessWidget {
  bool first;
  bool last;
  TextEditingController controller;
  FocusNode focusNode;
  TextFieldOTP({
    super.key,
    required this.first,
    required this.last,
    required this.controller,
    required this.focusNode,
  });
  RegExp onlyNum = RegExp(r'^[0-9]+$');

  @override
  Widget build(BuildContext context) {
    final isError = Provider.of<MobileAuth>(context, listen: false).isOTPerror;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      height: 70,
      width: 50,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: GoogleFonts.notoSans(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: deviceHeight * 0.021),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2, color: isError ? Colors.red : Colors.black),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 2, color: isError ? Colors.red : Colors.black),
              borderRadius: BorderRadius.circular(12),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^[0-9]+$')),
          ],
        ),
      ),
    );
  }
}
