import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  const PageIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: double.infinity,
      //padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: const BoxDecoration(
        color: const Color(0xFFE9E9E9),
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
                width: (30 / 360) * MediaQuery.of(context).size.width,
                height: 5.0,
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
