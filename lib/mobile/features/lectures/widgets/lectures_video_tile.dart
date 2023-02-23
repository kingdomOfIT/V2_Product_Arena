import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LecturesVideoTile extends StatelessWidget {
  final String linkImage;
  final String lectureName;
  final int i;
  final PageController pageController;
  const LecturesVideoTile(
      {super.key,
      required this.linkImage,
      required this.lectureName,
      required this.i,
      required this.pageController});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: (90 / 800) * MediaQuery.of(context).size.height,
        width: (296 / 360) * MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: const Color(0xFFCAC4D0)),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            SizedBox(
              height: (90 / 800) * MediaQuery.of(context).size.height,
              width: (100 / 360) * MediaQuery.of(context).size.width,
              child: Image.network(linkImage),
            ),
            RichText(
              text: TextSpan(
                  text: '$i. Tools:',
                  style: GoogleFonts.notoSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: lectureName,
                      style: GoogleFonts.notoSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                  ]),
            ),
          ],
        ),
      ),
      onTap: () {
        pageController.animateToPage(i,
            duration: const Duration(milliseconds: 400), curve: Curves.easeIn);
      },
    );
  }
}
