import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/mobile/features/lectures/screens/hello_screen.dart';
import 'package:v2_product_arena/mobile/features/lectures/widgets/lectures_sidebar.dart';
import 'package:v2_product_arena/mobile/providers/error_message_provider.dart';
import 'package:v2_product_arena/mobile/providers/mobile_auth_provider.dart';

class RecentLectures extends StatelessWidget {
  static const routeName = 'recent-lectures';
  RecentLectures({super.key});
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<MobileAuth>(context);
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
                (dataProvider.isSidebarOpened1)
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
        body: SafeArea(
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset('assets/images/LogoPAwhitebackground.png'),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Coming soon!',
                style: GoogleFonts.notoSans(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
