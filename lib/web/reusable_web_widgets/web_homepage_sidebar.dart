import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/web/features/home/screens/web_home_screen.dart';
import 'package:v2_product_arena/web/features/home/screens/web_lectures_screen.dart';
import 'package:v2_product_arena/web/features/home/screens/web_recent_lectures.dart';

import '../features/home/screens/web_contact_screen.dart';
import '../providers/web_auth_provider.dart';

class WebSideBar extends StatelessWidget {
  const WebSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    final webAuth = Provider.of<WebAuth>(context);
    double maxwidth = MediaQuery.of(context).size.width;
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
                        child: Image.asset(
                          'assets/images/WebSidebarHomescreenWhite.png',
                          height: 20,
                          width: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Homescreen',
                        style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w700,
                          fontSize: maxwidth * (16 / 1440),
                          color: Colors.white,
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
            children: webAuth.roles
                .map(
                  (role) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      key: const Key('roleLecturesScreen'),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(WebLecturesPage.routeName);
                      },
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.resolveWith<Color>(
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
                            child: Image.asset(
                              role == 'backend'
                                  ? 'assets/images/rolevectorwhite3.png'
                                  : role == 'fullstack'
                                      ? 'assets/images/rolevectorwhite5.png'
                                      : role == 'qa'
                                          ? 'assets/images/rolevectorwhite1.png'
                                          : role == 'productManager'
                                              ? 'assets/images/rolevectorwhite2.png'
                                              : 'assets/images/rolevectorblack4.png',
                              height: 20,
                              width: 20,
                            ),
                          ),
                          SizedBox(width: maxwidth * (10 / 1440)),
                          Text(
                            role == 'backend'
                                ? 'Backend'
                                : role == 'fullstack'
                                    ? 'FullStack Developer'
                                    : role == 'qa'
                                        ? 'QA'
                                        : role == 'productManager'
                                            ? 'Project Manager'
                                            : 'UI&UX Designer',
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w700,
                              fontSize: maxwidth * (16 / 1440),
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
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
                      child: Image.asset(
                        'assets/images/WebSidebarRecentWhite.png',
                        height: 20,
                        width: 20,
                      ),
                    ),
                    SizedBox(width: maxwidth * (10 / 1440)),
                    Text(
                      'Recent lectures',
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w700,
                        fontSize: maxwidth * (16 / 1440),
                        color: Colors.white,
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
                  onPressed: () {
                    Navigator.of(context).pushNamed(WebContactScreen.routeName);
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
                        child: Image.asset(
                          'assets/images/WebSidebarContactusWhite.png',
                          height: 20,
                          width: 20,
                        ),
                      ),
                      SizedBox(width: maxwidth * (10 / 1440)),
                      Text(
                        'Contact us!',
                        style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w700,
                          fontSize: maxwidth * (16 / 1440),
                          color: Colors.white,
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
}
