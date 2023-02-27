import 'package:flutter/material.dart';
import 'package:v2_product_arena/mobile/features/lectures/const.dart';
import 'package:v2_product_arena/mobile/features/lectures/widgets/lectures_video_tile.dart';

class MobileLecturesScreen extends StatefulWidget {
  final PageController pageController;
  const MobileLecturesScreen({super.key, required this.pageController});

  @override
  State<MobileLecturesScreen> createState() => _MobileLecturesScreenState();
}

class _MobileLecturesScreenState extends State<MobileLecturesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile lectures'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: (32 / 360) * MediaQuery.of(context).size.width),
          child: ListView.separated(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return LecturesVideoTile(
                linkImage: imageLinks[index],
                lectureName: lectureNames[index],
                i: index + 1,
                pageController: widget.pageController,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: (20 / 800) * MediaQuery.of(context).size.height,
              );
            },
          ),
        ),
      ),
    );
  }
}
