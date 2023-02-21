import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/web/features/home/models/lecture.dart';
import 'package:v2_product_arena/web/providers/web_auth_provider.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_lecture_card.dart';

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
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: maxwidth * (50 / 1440)),
                        child: Container(
                          padding: EdgeInsets.all(maxwidth * (30 / 1440)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
///////////////////////////////////////////////// LECTURE INFORMATIONS ///////////////////////////////////////////////////////////////

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
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
                                      SizedBox(
                                        height: maxheight * (160 / 1510),
                                      ),
                                      Text(
                                        'Total time: ${lectures[index].durationInSeconds}',
                                        style: GoogleFonts.notoSans(
                                            fontSize: maxheight * (16 / 1510),
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        'Remaning time: ${lectures[index].remainingTime}',
                                        style: GoogleFonts.notoSans(
                                            fontSize: maxheight * (16 / 1510),
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        'Status: ${lectures[index].status}',
                                        style: GoogleFonts.notoSans(
                                            fontSize: maxheight * (16 / 1510),
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
///////////////////////////////////////////////// LECTURE IMAGE ///////////////////////////////////////////////////////////////
                                  SizedBox(
                                    width: maxwidth * (30 / 1440),
                                  ),
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
                              Divider(
                                height: maxheight * (14 / 1510),
                                thickness: 1,
                              ),
                            ],
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
