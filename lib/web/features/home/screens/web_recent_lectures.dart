import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/web/features/home/models/lecture.dart';
import 'package:v2_product_arena/web/features/home/widgets/web_mock_data_recent_lectures.dart';
import 'package:v2_product_arena/web/providers/web_auth_provider.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_green_profile.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_lecture_card.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_profilepopup.dart';
import '../../../reusable_web_widgets/web_homepage_sidebar.dart';

class WebRecentLecturesPage extends StatefulWidget {
  static const routeName = '/web-recent';

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

                const WebProfilePopup(),
                ////////////////////////////////////// LECTURES CARDS  ////////////////////////////////////////
                Expanded(
                  child: ListView.builder(
                    itemCount: lectures.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: maxwidth * (50 / 1440)),
                        child: WebLectureCard(
                          // name: lectures[index].name,
                          name: lectures[index]['name'],
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
