import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/mobile/features/lectures/screens/hello_screen.dart';
import 'package:v2_product_arena/mobile/providers/mobile_auth_provider.dart';

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
    final dataProvider = Provider.of<MobileAuth>(context, listen: false);
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
              dataProvider.changeSidebar(false);
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
        Padding(
          padding: EdgeInsets.only(
              right: (32 / 360) * MediaQuery.of(context).size.width),
          child: Consumer<MobileAuth>(
            builder: ((context, value, child) {
              return GestureDetector(
                onTap: () {
                  if (value.isSidebarOpened) {
                    widget.scaffoldKey.currentState!.closeEndDrawer();
                    value.changeSidebar(false);
                  } else {
                    widget.scaffoldKey.currentState!.openEndDrawer();
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
    );
  }
}
