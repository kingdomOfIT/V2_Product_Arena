import 'package:flutter/material.dart';
import 'package:v2_product_arena/mobile/providers/mobile_auth_provider.dart';
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/mobile_appbar.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailVerificationScreen extends StatelessWidget {
  static const routeName = '/email-verification';
  EmailVerificationScreen({super.key});
  final confirmCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
        child: const MobileAppBar(),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: deviceHeight * 0.053,
          right: deviceWidth * 0.091,
          left: deviceWidth * 0.091,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Just to be sure...',
                style: GoogleFonts.notoSans(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: deviceHeight * 0.037,
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.027,
              ),
              Text(
                'We’ve sent a 6-digit code to your e-mail',
                style: GoogleFonts.notoSans(
                  color: Colors.black54,
                  fontWeight: FontWeight.w400,
                  fontSize: deviceHeight * 0.016,
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.093,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Container(
                  //   width: deviceWidth * 0.13,
                  //   height: deviceHeight * 0.065,
                  //   alignment: Alignment.center,
                  //   decoration: BoxDecoration(
                  //     border: Border.all(
                  //       color: const Color(0xFF605D66),
                  //       width: 1.5,
                  //     ),
                  //     borderRadius: BorderRadius.circular(8.0),
                  //   ),
                  //   child: const TextField(
                  //     cursorColor: Color(0xFF22E974),
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(
                  //         color: Colors.black,
                  //         fontFamily: 'Noto Sans',
                  //         fontSize: 32,
                  //         fontWeight: FontWeight.w900),
                  //     keyboardType: TextInputType.number,
                  //     maxLength: 1,
                  //     decoration: InputDecoration(
                  //       border: InputBorder.none,
                  //       counterText: '',
                  //     ),
                  //   ),
                  // ),
                  _textFieldOTP(first: true, last: false),
                  _textFieldOTP(first: false, last: false),
                  _textFieldOTP(first: false, last: false),
                  _textFieldOTP(first: false, last: false),
                  _textFieldOTP(first: false, last: false),
                  _textFieldOTP(first: false, last: true),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFieldOTP({first, last, BuildContext? context}) {
    return Container(
      height: 70,
      width: 50,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context!).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context!).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
