import 'package:flutter/material.dart';

class LecturesPageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final double height;
  final double width;
  final double indicatorHeight;
  const LecturesPageIndicator({
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(totalPages, (index) {
          return Visibility(
            visible: index != 0,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  color: index == currentPage
                      ? Colors.grey[600]
                      : Colors.grey[500],
                  borderRadius: const BorderRadius.all(Radius.circular(2.0))),
            ),
          );
        }),
      ),
    );
  }
}
