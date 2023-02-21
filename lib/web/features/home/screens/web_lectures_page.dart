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
    return Row(
      children: [
////////////////////////////////////// SIDEBAR ////////////////////////////////////////

        const WebSideBar(),

////////////////////////////////////// LECTURES PART OF SCREEN ////////////////////////////////////////

        Container(
            color: Colors.white,
            width: maxwidth * (1130 / 1440),
            child: Column(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    color: Colors.cyan,
                    height: maxheight * (70 / 1510),
                  ),
                )
              ],
            )),
      ],
    );
  }
}
