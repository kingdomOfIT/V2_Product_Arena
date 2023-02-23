import 'package:flutter/material.dart';
import 'package:v2_product_arena/mobile/features/lectures/const.dart';
import 'package:v2_product_arena/mobile/features/lectures/widgets/video_player.dart';
import 'package:v2_product_arena/mobile/features/lectures/screens/mobile_lectures_screens.dart';

class WelcomeLecturesScreen extends StatefulWidget {
  const WelcomeLecturesScreen({super.key});
  static const routeName = 'welcome-lectures';
  @override
  State<WelcomeLecturesScreen> createState() => _WelcomeLecturesScreenState();
}

class _WelcomeLecturesScreenState extends State<WelcomeLecturesScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.toInt();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> videoPageList = List.generate(
      imageLinks.length,
      (i) => VideoPlayPage(
          videoId: lectureLinks[i],
          lectureName: lectureNames[i],
          pageController: _pageController,
          lectureDecription: lectureDescriptions[i]),
    );
    videoPageList.insert(
        0,
        MobileLecturesScreen(
          pageController: _pageController,
        ));
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: videoPageList.length,
              itemBuilder: (BuildContext context, int index) {
                return videoPageList[index % videoPageList.length];
              },
            ),
          ],
        ),
      ),
    );
  }
}
