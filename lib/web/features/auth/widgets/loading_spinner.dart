// ignore_for_file: use_key_in_widget_constructors, depend_on_referenced_packages, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class Loader extends StatelessWidget {
  var spinkit = SpinKitRing(
    color: Color(0xFF22E974),
    size: 80,
    duration: const Duration(seconds: 1),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            spinkit,
            SizedBox(
              height: 30,
            ),
            SizedBox(
              child: Text(
                'Loading...',
                style: GoogleFonts.notoSans(
                    fontSize: 30, fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }
}
