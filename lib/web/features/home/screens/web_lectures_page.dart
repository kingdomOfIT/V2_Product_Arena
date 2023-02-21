import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/web/features/home/models/lecture.dart';

import '../../../reusable_web_widgets/web_homepage_sidebar.dart';
import '../widgets/web_mock_data_lectures.dart';

class WebLecturesPage extends StatefulWidget {
  static const routeName = '/web-lectures';

  const WebLecturesPage({super.key});

  @override
  State<WebLecturesPage> createState() => _WebLecturesPageState();
}

class _WebLecturesPageState extends State<WebLecturesPage> {
  List<Lecture> lectures = Utils.getMockedLecture();

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    double maxheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Row(
        children: [
          ////////////////////////////////////// SIDEBAR ////////////////////////////////////////

          const WebSideBar(),

          ////////////////////////////////////// LECTURES PART OF SCREEN ////////////////////////////////////////

          Container(
            color: Colors.white,
            width: maxwidth * (1130 / 1440),
            child: Column(
              children: [
                ////////////////////////////////////// PROFILE GREEN ICON////////////////////////////////////////

                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 10, bottom: 10, right: 50),
                    child: SizedBox(
                      width: maxwidth * (50 / 1440),
                      height: 50,
                      child: Image.asset('assets/images/Profileicon.png'),
                    ),
                  ),
                ),

                ////////////////////////////////////// LECTURES CARDS  ////////////////////////////////////////
                Expanded(
                  child: ListView.builder(
                    itemCount: lectures.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return Container(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  lectures[index].name,
                                  style: GoogleFonts.outfit(
                                    fontWeight: FontWeight.w400,
                                    fontSize: maxheight * (32 / 1510),
                                  ),
                                ),
                                Text(
                                  lectures[index].description,
                                  style: GoogleFonts.notoSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: maxheight * (18 / 1510),
                                  ),
                                ),
                              ],
                            ),
///////////////////////////////////////////////// LECTURE IMAGE ///////////////////////////////////////////////////////////////
                            Flexible(
                              child: SizedBox(
                                width: maxwidth * (370 / 1440),
                                height: maxheight * (270 / 1510),
                                child: Image.network(
                                  lectures[index].imageSrc,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
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
