import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/mobile/features/lectures/widgets/video_player.dart';
import 'package:v2_product_arena/mobile/features/lectures/screens/mobile_lectures_screens.dart';
import 'package:v2_product_arena/mobile/providers/mobile_auth_provider.dart';
import 'package:v2_product_arena/mobile/features/lectures/widgets/lectures_indicator.dart';
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/mobile_footer.dart';

class WelcomeLecturesScreen extends StatefulWidget {
  final String role;
  const WelcomeLecturesScreen({super.key, required this.role});

  static const routeName = 'welcome-lectures';
  @override
  State<WelcomeLecturesScreen> createState() => _WelcomeLecturesScreenState();
}

class _WelcomeLecturesScreenState extends State<WelcomeLecturesScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  List listContains = [];
  List roleLectures = [];

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
    final dataProvider = Provider.of<MobileAuth>(context, listen: false);

    if (widget.role == dataProvider.roles[0]) {
      roleLectures = dataProvider.lectureRole1;
    } else {
      roleLectures = dataProvider.lectureRole2;
    }
    int duzina = roleLectures.length;

    final List<Widget> videoPageList = List.generate(
      duzina,
      (i) => VideoPlayPage(
        videoId: roleLectures[i]['contentLink'],
        lectureName: roleLectures[i]['name'],
        pageController: _pageController,
        lectureDecription: roleLectures[i]['description'],
        numb: duzina,
      ),
    );
    videoPageList.insert(
        0,
        MobileLecturesScreen(
          role: widget.role,
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
            // Padding(
            //   padding: EdgeInsets.only(
            //       right: (32 / 360) * MediaQuery.of(context).size.width,
            //       left: (28 / 360) * MediaQuery.of(context).size.width,
            //       top: 55),
            //   child: Visibility(
            //     visible: _currentPage != 0 &&
            //         !dataProvider.isPlayingInFullscr &&
            //         !dataProvider.isSidebarOpened3,
            //     child: LecturesPageIndicator(
            //       currentPage: _currentPage,
            //       totalPages: duzina + 1,
            //       width:
            //           (MediaQuery.of(context).size.width - 108) / (duzina + 1),
            //       height: 3,
            //       indicatorHeight: 23,
            //     ),
            //   ),
            // ),
            Visibility(
              visible: !dataProvider.isPlayingInFullscr,
              child: const Positioned(
                  bottom: 0, left: 0, right: 0, child: MobileFooter()),
            ),
          ],
        ),
      ),
    );
  }
}
