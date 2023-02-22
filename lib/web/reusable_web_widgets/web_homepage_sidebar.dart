import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/constants/global_variables.dart';
import 'package:v2_product_arena/web/features/home/screens/web_home_screen.dart';
import 'package:v2_product_arena/web/features/home/screens/web_lectures_page.dart';
import 'package:v2_product_arena/web/features/home/screens/web_recent_lectures.dart';

import '../providers/web_auth_provider.dart';

class WebSideBar extends StatelessWidget {
  const WebSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    final webAuth = Provider.of<WebAuth>(context, listen: false);
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
                  onPressed: () {
                    webAuth.getLectureOrder();
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
                      Image.asset(
                        'assets/images/WebSidebarHomescreenWhite.png',
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Homescreen',
                        style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
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
            children: usersRole
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
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
                          Image.asset(
                            e.icon,
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            e.name,
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
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
                    Image.asset(
                      'assets/images/WebSidebarRecentWhite.png',
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Recent lectures',
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),

          ///////////////////CONTACT US/////////////////////
          Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  // Navigator.of(context)
                  //     .pushNamed(WebRecentLecturesPage.routeName);
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
                    Image.asset(
                      'assets/images/WebSidebarContactusWhite.png',
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Contact us!',
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
