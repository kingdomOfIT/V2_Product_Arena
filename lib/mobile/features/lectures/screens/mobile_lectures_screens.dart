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
  bool isSideBarOpened = false;
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<MobileAuth>(context, listen: false);
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
                Provider.of<ErrorMessage>(context, listen: false)
                    .selectedRole
                    .clear();
                dataProvider.changeSidebar(false);
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
            // child: Consumer<MobileAuth>(
            //   builder: ((context, value, child) {
            //     return GestureDetector(
            //       onTap: () {
            //         (value.isSidebarOpened1)
            //             ? _key.currentState!.closeEndDrawer()
            //             : _key.currentState!.openEndDrawer();
            //         value.changeSidebar1();
            //       },
            //       child: value.isSidebarOpened1
            //           ? const Icon(Icons.menu)
            //           : const Icon(Icons.close),
            //     );
            //   }),
            // ),
            child: Consumer<MobileAuth>(
              builder: ((context, value, child) {
                return GestureDetector(
                  onTap: () {
                    if (value.isSidebarOpened) {
                      _key.currentState!.closeEndDrawer();
                      value.changeSidebar(false);
                    } else {
                      _key.currentState!.openEndDrawer();
                      value.changeSidebar(true);
                    }
                  },
                  child: !value.isSidebarOpened
                      ? const Icon(Icons.menu)
                      : const Icon(Icons.close),
                );
              }),
            ),
          ),
        ],
      ),
      body: Scaffold(
        key: _key,
        endDrawer: Drawer(
            width: MediaQuery.of(context).size.width,
            child: const MobileSidebar()),
        onEndDrawerChanged: (isOpen) {
          dataProvider.changeSidebar(isOpen);
        },
        body: SafeArea(
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
                        height: (20 / 800) * MediaQuery.of(context).size.height,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
