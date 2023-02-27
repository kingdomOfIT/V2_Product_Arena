import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final double height;
  final double width;
  final double indicatorHeight;
  const PageIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.height,
    required this.width,
    required this.indicatorHeight,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: indicatorHeight,
      width: double.infinity,
      //padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: const BoxDecoration(
        color: Color(0xFFE9E9E9),
        borderRadius: BorderRadius.all(Radius.zero),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.topLeft,
            child: Text(
              '$currentPage/$totalPages',
              style: GoogleFonts.notoSans(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(totalPages, (index) {
              return Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    color: index < currentPage
                        ? Colors.grey[600]
                        : Colors.grey[500],
                    borderRadius:
                        const BorderRadius.all(Radius.circular(14.0))),
              );
            }),
          ),
        ],
      ),
    );
  }
}
