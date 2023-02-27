import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/mobile/features/lectures/widgets/lectures_video_tile.dart';
import 'package:v2_product_arena/mobile/providers/mobile_auth_provider.dart';

class MobileLecturesScreen extends StatefulWidget {
  final PageController pageController;
  final String role;
  const MobileLecturesScreen(
      {super.key, required this.pageController, required this.role});

  @override
  State<MobileLecturesScreen> createState() => _MobileLecturesScreenState();
}

class _MobileLecturesScreenState extends State<MobileLecturesScreen> {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<MobileAuth>(context);
    List listContains = [];
    List roleLectures = [];
    if (widget.role == dataProvider.roles[0]) {
      roleLectures = dataProvider.lectureRole1;
    } else {
      roleLectures = dataProvider.lectureRole2;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile lectures'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: (32 / 360) * MediaQuery.of(context).size.width),
          child: ListView.separated(
            itemCount: roleLectures.length,
            itemBuilder: (BuildContext context, int index) {
              return LecturesVideoTile(
                linkImage: roleLectures[index]['imageSrc'],
                lectureName: roleLectures[index]['name'],
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
