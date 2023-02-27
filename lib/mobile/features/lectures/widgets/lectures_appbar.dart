import 'package:flutter/material.dart';
import 'package:v2_product_arena/mobile/features/lectures/widgets/lectures_sidebar.dart';
import 'package:v2_product_arena/mobile/features/lectures/screens/hello_screen.dart';

class WelcomepageAppBar extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const WelcomepageAppBar({super.key, required this.scaffoldKey});

  @override
  State<WelcomepageAppBar> createState() => _WelcomepageAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(55.0);

  Size get PreferredSize => Size.fromWidth(360.0);
}

class _WelcomepageAppBarState extends State<WelcomepageAppBar> {
  bool isSidebarOpen = false;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    return AppBar(
      backgroundColor: const Color(0xFFFFFFFF),
      elevation: 0,
      leading: Container(
        height: 55,
        width: screenWidth,
        child: Padding(
          padding: EdgeInsets.only(
            top: screenHeight * (10 / 803),
            bottom: screenHeight * (10 / 803),
            left: screenWidth * (20 / 360),
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(WelcomePage.routeName);
            },
            child: Image.asset(
              "assets/images/PAlogowhite.png",
              height: screenWidth * (35 / 360),
              width: screenWidth * (35 / 360),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      actions: <Widget>[
        if (!isSidebarOpen)
          IconButton(
            onPressed: () {
              widget.scaffoldKey.currentState!.openEndDrawer();
              setState(() {
                isSidebarOpen = true;
              });
            },
            icon: const Icon(Icons.menu),
            color: Color(0xFF212529),
          ),
        if (isSidebarOpen)
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                isSidebarOpen = false;
              });
            },
            icon: const Icon(Icons.close),
            color: Color(0xFF000000),
          )
      ],
    );
  }
}
