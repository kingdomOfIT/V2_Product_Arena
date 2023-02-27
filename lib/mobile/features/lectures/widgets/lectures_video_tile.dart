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
      key: const Key('video_tile'),
      child: Container(
        height: 90,
        width: (296 / 360) * MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: const Color(0xFFCAC4D0)),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 90,
                width: (100 / 360) * MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      bottomLeft: Radius.circular(4)),
                ),
                child: Image.network(
                  linkImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 7,
            ),
            Expanded(
              flex: 2,
              child: Text(
                '$i. $lectureName',
                style: GoogleFonts.notoSans(
                    fontSize: 14, fontWeight: FontWeight.w700),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_right,
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
