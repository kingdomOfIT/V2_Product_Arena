import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/constants/global_variables.dart';
import 'package:v2_product_arena/web/features/home/screens/web_contact_screen.dart';
import 'package:v2_product_arena/web/features/home/screens/web_home_screen.dart';
import 'package:v2_product_arena/web/features/home/screens/web_lecturevideo_screen.dart';

enum _CurrentPage {
  home,
  design,
  recent,
  contact,
}

var currentPage = _CurrentPage.home;

class WebHomeSideBar extends StatefulWidget {
  const WebHomeSideBar({super.key});

  @override
  State<WebHomeSideBar> createState() => _WebHomeSideBarState();
}

class _WebHomeSideBarState extends State<WebHomeSideBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 310,
      color: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/LogoPAblackbackground.png"),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.home,
                  color: currentPage == _CurrentPage.home
                      ? const Color(0xFF22E974)
                      : Colors.white,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Homescreen',
                  style: GoogleFonts.notoSans(
                    color: currentPage == _CurrentPage.home
                        ? const Color(0xFF22E974)
                        : Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            onTap: () {
              setState(() {
                currentPage = _CurrentPage.home;
              });
              Navigator.of(context)
                  .pushReplacementNamed(WebHomeScreen.routeName);
            },
          ),
          Column(
            children: usersRole
                .map((e) => ListTile(
                      title: Row(
                        children: [
                          Image.asset(
                            e.icon,
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            e.name,
                            style: GoogleFonts.notoSans(
                              color: currentPage == _CurrentPage.design
                                  ? const Color(0xFF22E974)
                                  : Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        setState(() {
                          currentPage = _CurrentPage.design;
                        });
                        Navigator.of(context).pushReplacementNamed(
                            WebLectureVideoScreen.routeName);
                      },
                    ))
                .toList(),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.auto_fix_high,
                  color: currentPage == _CurrentPage.design
                      ? const Color(0xFF22E974)
                      : Colors.white,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'UI/UX Design',
                  style: GoogleFonts.notoSans(
                    color: currentPage == _CurrentPage.design
                        ? const Color(0xFF22E974)
                        : Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            onTap: () {
              setState(() {
                currentPage = _CurrentPage.design;
              });
              Navigator.of(context)
                  .pushReplacementNamed(WebLectureVideoScreen.routeName);
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.bookmark,
                  color: currentPage == _CurrentPage.recent
                      ? const Color(0xFF22E974)
                      : Colors.white,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Recent lectures',
                  style: GoogleFonts.notoSans(
                    color: currentPage == _CurrentPage.recent
                        ? const Color(0xFF22E974)
                        : Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            onTap: () {
              setState(() {
                currentPage = _CurrentPage.recent;
              });
            },
          ),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.contact_page,
                  color: currentPage == _CurrentPage.contact
                      ? const Color(0xFF22E974)
                      : Colors.white,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Contact us!',
                  style: GoogleFonts.notoSans(
                    color: currentPage == _CurrentPage.contact
                        ? const Color(0xFF22E974)
                        : Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            onTap: () {
              setState(() {
                currentPage = _CurrentPage.contact;
              });
              Navigator.of(context)
                  .pushReplacementNamed(WebContactScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
