import 'package:flutter/material.dart';
import 'package:v2_product_arena/mobile/features/lectures/screens/hello_screen.dart';

class WelcomepageAppBar extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const WelcomepageAppBar({super.key, required this.scaffoldKey});

  @override
  State<WelcomepageAppBar> createState() => _WelcomepageAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(55.0);

  Size get PreferredSize => const Size.fromWidth(360.0);
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
      leading: SizedBox(
        height: 55,
        width: screenWidth,
        child: Padding(
          padding: EdgeInsets.only(
            top: screenHeight * (10 / 803),
            bottom: screenHeight * (10 / 803),
            left: screenWidth * (20 / 360),
          ),
          child: GestureDetector(
            key: const Key('appbarLogo'),
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
            key: const Key('drawerButton'),
            onPressed: () {
              widget.scaffoldKey.currentState!.openEndDrawer();
              setState(() {
                isSidebarOpen = true;
              });
            },
            icon: const Icon(Icons.menu),
            color: const Color(0xFF212529),
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
            color: const Color(0xFF000000),
          )
      ],
    );
  }
}
