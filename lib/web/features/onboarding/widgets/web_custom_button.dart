import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const CustomButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (190 / 1440) * MediaQuery.of(context).size.width,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
          width: 1,
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          'Pošalji',
          style: GoogleFonts.notoSans(color: Color(0xFFFFFFFF)),
        ),
      ),
    );
  }
}
