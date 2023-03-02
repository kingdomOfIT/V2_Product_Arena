import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/mobile/features/lectures/screens/hello_screen.dart';
import 'package:v2_product_arena/mobile/features/lectures/widgets/lectures_sidebar.dart';
import 'package:v2_product_arena/mobile/features/lectures/widgets/lectures_video_tile.dart';
import 'package:v2_product_arena/mobile/providers/error_message_provider.dart';
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
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<MobileAuth>(context);
    List roleLectures = [];
    if (widget.role == dataProvider.roles[0]) {
      roleLectures = dataProvider.lectureRole1;
    } else {
      roleLectures = dataProvider.lectureRole2;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        leading: Container(
          height: 55,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * (10 / 803),
              bottom: MediaQuery.of(context).size.height * (10 / 803),
              left: MediaQuery.of(context).size.width * (20 / 360),
            ),
            child: GestureDetector(
              onTap: () {
                Provider.of<ErrorMessage>(context).selectedRole.clear();
                Navigator.of(context).pushNamed(WelcomePage.routeName);
              },
              child: Image.asset(
                "assets/images/PAlogowhite.png",
                height: MediaQuery.of(context).size.width * (35 / 360),
                width: MediaQuery.of(context).size.width * (35 / 360),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                right: (32 / 360) * MediaQuery.of(context).size.width),
            child: GestureDetector(
              onTap: () {
                dataProvider.isSidebarOpened1
                    ? _key.currentState!.closeEndDrawer()
                    : _key.currentState!.openEndDrawer();
                dataProvider.changeSidebar1();
              },
              child: (dataProvider.isSidebarOpened1)
                  ? const Icon(Icons.close)
                  : const Icon(Icons.menu),
            ),
          ),
        ],
      ),
      body: Scaffold(
        key: _key,
        endDrawer: Drawer(
            width: MediaQuery.of(context).size.width,
            child: const MobileSidebar()),
        body: GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) {
            if (details.primaryVelocity! > 0 &&
                _key.currentState?.isEndDrawerOpen == true) {
              dataProvider.changeSidebar1();
              print('otvoren');
            }
          },
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  right: (32 / 360) * MediaQuery.of(context).size.width,
                  left: (32 / 360) * MediaQuery.of(context).size.width,
                  top: 20,
                  bottom: 90),
              child: Column(
                children: [
                  Expanded(
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
                          height:
                              (20 / 800) * MediaQuery.of(context).size.height,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
