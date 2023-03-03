import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/web/features/home/screens/web_home_screen.dart';
import 'package:v2_product_arena/web/features/home/screens/web_lectures_screen.dart';
import 'package:v2_product_arena/web/features/home/screens/web_recent_lectures.dart';
import 'package:v2_product_arena/web/providers/web_sidebar_provider.dart';

import '../features/home/screens/web_contact_screen.dart';
import '../providers/web_auth_provider.dart';

class WebSideBar extends StatelessWidget {
  const WebSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    final webAuth = Provider.of<WebAuth>(context);
    final sideBarProvider = Provider.of<SideBar>(context, listen: false);
    double maxwidth = MediaQuery.of(context).size.width;
    double maxheigt = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.black,
      width: maxwidth * (310 / 1440),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(70),
            child: SizedBox(
              width: maxwidth * (170 / 1440),
              child: Image.asset('assets/images/LogoPAblackbackground.png'),
            ),
          ),

          ///////////////////HOME BUTTON/////////////////////
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  key: const Key('homescreenButton'),
                  onPressed: () {
                    Navigator.of(context).pushNamed(WebHomeScreen.routeName);
                    sideBarProvider.isHome = true;
                    sideBarProvider.isCurrentRole = false;
                    sideBarProvider.isRecentLectuers = false;
                    sideBarProvider.isContactUs = false;
                  },
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors.green;
                      }
                      return Colors.white;
                    }),
                  ),
                  child: Row(
                    children: [
                      Flexible(
                          child: sideBarProvider.isHome
                              ? buildImage(
                                  'assets/images/WebSidebarHomescreenGreen.png',
                                  maxheigt,
                                  maxwidth,
                                )
                              : buildImage(
                                  'assets/images/WebSidebarHomescreenWhite.png',
                                  maxheigt,
                                  maxwidth,
                                )),
                      const SizedBox(width: 10),
                      Text(
                        'Homescreen',
                        style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w700,
                          fontSize: maxwidth * (16 / 1440),
                          color: sideBarProvider.isHome
                              ? const Color.fromRGBO(34, 233, 116, 1)
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          ///////////////////ROLE SCREEN/////////////////////
          Column(
            children: webAuth.roles.map((role) {
              final key = Key(role); // assign a unique key to each TextButton
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    key: key,
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        WebLecturesPage.routeName,
                        arguments: role,
                      );
                      sideBarProvider.isHome = false;
                      if (role == webAuth.secondRole) {
                        sideBarProvider.isCurrentRole = false;
                      } else {
                        sideBarProvider.isCurrentRole = true;
                      }

                      sideBarProvider.isRecentLectuers = false;
                      sideBarProvider.isContactUs = false;
                    },
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.hovered)) {
                          return Colors.green;
                        }
                        return Colors.white;
                      }),
                    ),
                    child: role == webAuth.firstRole
                        ? Row(
                            children: [
                              Flexible(
                                child: sideBarProvider.isCurrentRole
                                    ? Image.asset(
                                        height: maxheigt * (30 / 1094),
                                        width: maxwidth * (30 / 1440),
                                        webAuth.firstRole == 'backend'
                                            ? 'assets/images/backend_green.png'
                                            : webAuth.firstRole == 'fullstack'
                                                ? 'assets/images/fs_green.png'
                                                : webAuth.firstRole == 'qa'
                                                    ? 'assets/images/qa_icon_green.png'
                                                    : webAuth.firstRole ==
                                                            'productManager'
                                                        ? 'assets/images/pm_green.png'
                                                        : 'assets/images/uiux_green.png',
                                      )
                                    : Image.asset(
                                        height: maxheigt * (30 / 1094),
                                        width: maxwidth * (30 / 1440),
                                        webAuth.firstRole == 'backend'
                                            ? 'assets/images/rolevectorwhite3.png'
                                            : webAuth.firstRole == 'fullstack'
                                                ? 'assets/images/rolevectorwhite5.png'
                                                : webAuth.firstRole == 'qa'
                                                    ? 'assets/images/rolevectorwhite1.png'
                                                    : webAuth.firstRole ==
                                                            'productManager'
                                                        ? 'assets/images/rolevectorwhite2.png'
                                                        : 'assets/images/rolevectorwhite4.png',
                                      ),
                              ),
                              SizedBox(width: maxwidth * (10 / 1440)),
                              Text(
                                webAuth.firstRole == 'backend'
                                    ? 'Backend Development'
                                    : webAuth.firstRole == 'fullstack'
                                        ? 'Fullstack Development'
                                        : webAuth.firstRole == 'qa'
                                            ? 'Quality Assurance'
                                            : webAuth.firstRole ==
                                                    'productManager'
                                                ? 'Project Management'
                                                : 'UI/UX Design',
                                style: GoogleFonts.notoSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: maxwidth * (16 / 1440),
                                  color: sideBarProvider.isCurrentRole
                                      ? const Color.fromRGBO(34, 233, 116, 1)
                                      : Colors.white,
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Flexible(
                                child: sideBarProvider.isHome == false &&
                                        sideBarProvider.isCurrentRole ==
                                            false &&
                                        sideBarProvider.isRecentLectuers ==
                                            false &&
                                        sideBarProvider.isContactUs == false
                                    ? Image.asset(
                                        height: maxheigt * (30 / 1094),
                                        width: maxwidth * (30 / 1440),
                                        webAuth.secondRole == 'backend'
                                            ? 'assets/images/backend_green.png'
                                            : webAuth.secondRole == 'fullstack'
                                                ? 'assets/images/fs_green.png'
                                                : webAuth.secondRole == 'qa'
                                                    ? 'assets/images/qa_icon_green.png'
                                                    : webAuth.secondRole ==
                                                            'productManager'
                                                        ? 'assets/images/pm_green.png'
                                                        : 'assets/images/uiux_green.png',
                                      )
                                    : Image.asset(
                                        height: maxheigt * (30 / 1094),
                                        width: maxwidth * (30 / 1440),
                                        webAuth.secondRole == 'backend'
                                            ? 'assets/images/rolevectorwhite3.png'
                                            : webAuth.secondRole == 'fullstack'
                                                ? 'assets/images/rolevectorwhite5.png'
                                                : webAuth.secondRole == 'qa'
                                                    ? 'assets/images/rolevectorwhite1.png'
                                                    : webAuth.secondRole ==
                                                            'productManager'
                                                        ? 'assets/images/rolevectorwhite2.png'
                                                        : 'assets/images/rolevectorwhite4.png',
                                      ),
                              ),
                              SizedBox(width: maxwidth * (10 / 1440)),
                              Text(
                                webAuth.secondRole == 'backend'
                                    ? 'Backend Development'
                                    : webAuth.secondRole == 'fullstack'
                                        ? 'Fullstack Development'
                                        : webAuth.secondRole == 'qa'
                                            ? 'Quality Assurance'
                                            : webAuth.secondRole ==
                                                    'productManager'
                                                ? 'Project Management'
                                                : 'UI/UX Design',
                                style: GoogleFonts.notoSans(
                                  fontWeight: FontWeight.w700,
                                  fontSize: maxwidth * (16 / 1440),
                                  color: sideBarProvider.isHome == false &&
                                          sideBarProvider.isCurrentRole ==
                                              false &&
                                          sideBarProvider.isRecentLectuers ==
                                              false &&
                                          sideBarProvider.isContactUs == false
                                      ? const Color.fromRGBO(34, 233, 116, 1)
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                  ));
            }).toList(),
          ),

          ///////////////////RECENT LECTURES/////////////////////

          Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                key: const Key('recentLecturesButton'),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(WebRecentLecturesPage.routeName);
                  sideBarProvider.isHome = false;
                  sideBarProvider.isCurrentRole = false;
                  sideBarProvider.isRecentLectuers = true;
                  sideBarProvider.isContactUs = false;
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered)) {
                      return Colors.green;
                    }
                    return Colors.white;
                  }),
                ),
                child: Row(
                  children: [
                    Flexible(
                        child: sideBarProvider.isRecentLectuers
                            ? buildImage(
                                'assets/images/recent_icon_green.png',
                                maxheigt,
                                maxwidth,
                              )
                            : buildImage(
                                'assets/images/WebSidebarRecentWhite.png',
                                maxheigt,
                                maxwidth,
                              )),
                    SizedBox(width: maxwidth * (10 / 1440)),
                    Text(
                      'Recent lectures',
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w700,
                        fontSize: maxwidth * (16 / 1440),
                        color: sideBarProvider.isRecentLectuers
                            ? const Color.fromRGBO(34, 233, 116, 1)
                            : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),

          ///////////////////CONTACT US/////////////////////
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  key: const Key('contactFormButton'),
                  onPressed: () {
                    Navigator.of(context).pushNamed(WebContactScreen.routeName);
                    sideBarProvider.isHome = false;
                    sideBarProvider.isCurrentRole = false;
                    sideBarProvider.isRecentLectuers = false;
                    sideBarProvider.isContactUs = true;
                  },
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.hovered)) {
                        return Colors.green;
                      }
                      return Colors.white;
                    }),
                  ),
                  child: Row(
                    children: [
                      Flexible(
                          child: sideBarProvider.isContactUs
                              ? buildImage(
                                  'assets/images/contactus_green.png',
                                  maxheigt,
                                  maxwidth,
                                )
                              : buildImage(
                                  'assets/images/WebSidebarContactusWhite.png',
                                  maxheigt,
                                  maxwidth,
                                )),
                      SizedBox(width: maxwidth * (10 / 1440)),
                      Text(
                        'Contact us!',
                        style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w700,
                          fontSize: maxwidth * (16 / 1440),
                          color: sideBarProvider.isContactUs
                              ? const Color.fromRGBO(34, 233, 116, 1)
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildImage(String name, double maxheigt, double maxwidth) {
    return Image.asset(
      name,
      height: maxheigt * (30 / 1094),
      width: maxwidth * (30 / 1440),
    );
  }
}
