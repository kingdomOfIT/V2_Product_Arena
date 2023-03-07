import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/web/features/home/models/lecture.dart';
import 'package:v2_product_arena/web/features/home/widgets/web_mock_data_recent_lectures.dart';
import 'package:v2_product_arena/web/providers/web_auth_provider.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_lecture_card.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_profile.dart';
import '../../../reusable_web_widgets/web_homepage_sidebar.dart';
import 'package:google_fonts/google_fonts.dart';

class WebRecentLecturesPage extends StatefulWidget {
  static const routeName = '/recent-lectures';

  const WebRecentLecturesPage({super.key});

  @override
  State<WebRecentLecturesPage> createState() => _WebRecentLecturesPageState();
}

class _WebRecentLecturesPageState extends State<WebRecentLecturesPage> {
  List<Lecture> lectures = UtilsRecent.getMockedRecentLecture();

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    final lectures = Provider.of<WebAuth>(context, listen: false).lectures;

    return Scaffold(
      body: Row(
        children: [
          ////////////////////////////////////// SIDEBAR ////////////////////////////////////////

          const WebSideBar(),

          ////////////////////////////////////// LECTURES ////////////////////////////////////////

          Container(
            color: Colors.white,
            width: maxwidth * (1130 / 1440),
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                ////////////////////////////////////// PROFILE GREEN ICON////////////////////////////////////////

                const Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 25),
                    child: WebProfile(),
                  ),
                ),
                ////////////////////////////////////// LECTURES CARDS  ////////////////////////////////////////
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * (240 / 1094)),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: MediaQuery.of(context).size.height *
                                    (20 / 1094)),
                            child: Image.asset(
                                "assets/images/LogoPAwhitebackground.png"),
                          ),
                          Text(
                            "Coming soon !",
                            style: GoogleFonts.notoSans(
                              textStyle: TextStyle(
                                fontSize: MediaQuery.of(context).size.height *
                                    (64 / 1094),
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
