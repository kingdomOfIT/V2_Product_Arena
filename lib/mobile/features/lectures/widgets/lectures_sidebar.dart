// ignore_for_file: prefer_const_literals_to_create_immutables, unused_import, unused_import, duplicate_ignore, prefer_const_declarations, prefer_const_constructors, non_constant_identifier_names, sort_child_properties_last, sized_box_for_whitespace

import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:v2_product_arena/mobile/features/lectures/screens/welcome_lectures_screen.dart';
import 'package:v2_product_arena/mobile/features/lectures/widgets/lectures_sidebar_button.dart';
import 'package:v2_product_arena/mobile/features/lectures/widgets/role_tile_drawer.dart';
import 'package:v2_product_arena/mobile/providers/mobile_auth_provider.dart';
import 'package:v2_product_arena/mobile/providers/role_provider.dart';
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/mobile_footer.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:v2_product_arena/constants/global_variables.dart';

class MobileSidebar extends StatefulWidget {
  const MobileSidebar({Key? key}) : super(key: key);

  @override
  State<MobileSidebar> createState() => _MobileSidebarState();
}

class _MobileSidebarState extends State<MobileSidebar> {
  List<Role> lista = [];
  List<String> roleName = [];

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<MobileAuth>(context, listen: false);
    if (dataProvider.roles.length == 1) {
      for (var role in listRoleMob) {
        if (role.name['forBackend'] == dataProvider.roles[0]) {
          lista.add(role);
          roleName.add(role.name['forFrontend']!);
        }
      }
    } else {
      for (var role in listRoleMob) {
        if (role.name['forBackend'] == dataProvider.roles[0] ||
            role.name['forBackend'] == dataProvider.roles[1]) {
          lista.add(role);
          roleName.add(role.name['forFrontend']!);
        }
      }
    }
    final mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    return Drawer(
      backgroundColor: Color(0xFF000000),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: screenHeight * (90 / 803),
            width: screenWidth * (360 / 360),
            child: DrawerHeader(
              child: Text(
                'John Doe',
                style: GoogleFonts.notoSans(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: screenHeight * (32 / 803),
                    color: Color(0xFF22E974),
                  ),
                ),
              ),
              margin: EdgeInsets.all(screenHeight * (0 / 803)),
            ),
          ),
          ListTile(
            title: Text(
              dataProvider.userEmail,
              style: GoogleFonts.notoSans(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: screenHeight * (16 / 803),
                  color: Colors.white,
                ),
              ),
            ),
            leading: Image.asset(
              "assets/images/user-line.png",
              height: screenHeight * (24 / 803),
              width: screenWidth * (24 / 360),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * (20 / 360)),
            child: Divider(color: Colors.white),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: (20 / 360) * MediaQuery.of(context).size.width),
            child: SizedBox(
              height: dataProvider.roles.length * 56,
              child: ListView.builder(
                itemCount: dataProvider.roles.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: RoleTileLectures(
                      roleName: lista[index].name['forFrontend']!,
                      roleImage: lista[index].image,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomeLecturesScreen(
                                  role: lista[index].name['forBackend']!,
                                )),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          // ListTile(
          //   title: Text(
          //     "UI/UX Design",
          //     style: GoogleFonts.notoSans(
          //       fontWeight: FontWeight.w700,
          //       fontSize: screenHeight * (16 / 803),
          //       color: Colors.white,
          //     ),
          //   ),
          //   leading: Image.asset(
          //     "assets/images/rolevectorwhite4.png",
          //     height: screenHeight * (24 / 803),
          //     width: screenWidth * (24 / 360),
          //   ),
          // ),
          ListTile(
            title: Text(
              "Recent Lessons",
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w700,
                fontSize: screenHeight * (16 / 803),
                color: Colors.white,
              ),
            ),
            leading: Image.asset(
              "assets/images/Recent icon.png",
              height: screenHeight * (24 / 803),
              width: screenWidth * (24 / 360),
            ),
          ),
          ListTile(
            title: Text(
              "Contact us !",
              style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w700,
                fontSize: screenHeight * (16 / 803),
                color: Colors.white,
              ),
            ),
            leading: Image.asset(
              "assets/images/contact us.png",
              height: screenHeight * (24 / 803),
              width: screenWidth * (24 / 360),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(top: screenHeight * (149 / 803)),
              child: SidebarButton(),
            ),
          )
        ],
      ),
    );
  }
}
