import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/web/features/home/screens/web_lecturevideo_screen.dart';
import 'package:v2_product_arena/web/providers/web_auth_provider.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_lecture_card.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_profile.dart';
import '../../../reusable_web_widgets/web_homepage_sidebar.dart';

class WebLecturesPage extends StatefulWidget {
  static const routeName = '/lectures';

  const WebLecturesPage({super.key});

  @override
  State<WebLecturesPage> createState() => _WebLecturesPageState();
}

class _WebLecturesPageState extends State<WebLecturesPage> {
  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    final role = ModalRoute.of(context)!.settings.arguments as String;
    final lectures = Provider.of<WebAuth>(context, listen: false).lectures;
    final roleLectures =
        lectures.where((lecture) => lecture['roles'].contains(role)).toList();

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
                Expanded(
                  child: ListView.builder(
                    key: const Key('scrollableListView'),
                    itemCount: roleLectures.length,
                    itemBuilder: (BuildContext ctx, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            WebLectureVideoScreen.routeName,
                            arguments: {
                              'lectureName': roleLectures[index]['name'],
                              'index': index,
                            },
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: maxwidth * (50 / 1440)),
                          child: WebLectureCard(
                            name:
                                '${index + 1}. ${roleLectures[index]['name']}',
                            description: roleLectures[index]['description'],
                            durationInSeconds: roleLectures[index]
                                ['durationInSeconds'],
                            // lastStoppedInSeconds: lectures[index]
                            //     ['lastStoppedInSeconds'],
                            imageSrc: roleLectures[index]['imageSrc'],
                          ),
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
