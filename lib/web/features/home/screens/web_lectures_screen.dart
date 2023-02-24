import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/web/features/home/models/lecture.dart';
import 'package:v2_product_arena/web/providers/web_auth_provider.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_lecture_card.dart';

import '../../../../constants/global_variables.dart';
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
    final lectures = Provider.of<WebAuth>(context, listen: false).lectures;
    return Scaffold(
      body: Row(
        children: [
          ////////////////////////////////////// SIDEBAR ////////////////////////////////////////

          const WebSideBar(),

          ////////////////////////////////////// LECTURES ////////////////////////////////////////
          ////////////////////////////////////// LECTURES ////////////////////////////////////////

          Container(
            color: Colors.white,
            width: maxwidth * (1130 / 1440),
            child: Column(
              children: [
                ////////////////////////////////////// PROFILE GREEN ICON////////////////////////////////////////

                const GreenProfileIcon(),

                ////////////////////////////////////// LECTURES CARDS  ////////////////////////////////////////
                Expanded(
                  child: ListView.builder(
                    itemCount: lectures.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: maxwidth * (50 / 1440)),
                        child: WebLectureCard(
                          name: '${index + 1}. ${lectures[index]['name']}',
                          description: lectures[index]['description'],
                          durationInSeconds: lectures[index]
                              ['durationInSeconds'],
                          // lastStoppedInSeconds: lectures[index]
                          //     ['lastStoppedInSeconds'],
                          imageSrc: lectures[index]['imageSrc'],
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
