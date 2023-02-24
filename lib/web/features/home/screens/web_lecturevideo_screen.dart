import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/web/providers/web_auth_provider.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_homepage_sidebar.dart';

import '../../../../constants/global_variables.dart';

class WebLectureVideoScreen extends StatefulWidget {
  static const routeName = '/web-video';

  const WebLectureVideoScreen({super.key});

  @override
  State<WebLectureVideoScreen> createState() => _WebLectureVideoScreenState();
}

class _WebLectureVideoScreenState extends State<WebLectureVideoScreen> {
  final title = 'Tools: Basics';
  final numeration = '1';
  bool _showMore = false;
  final description =
      'In this video you will learn the basics of Figma. A tool with the help of which you will realize your ideas and create prototypes. Want to get started in design, but don’t know where to begin? These lessons and exercises will help you start designing immediately. Figma is a collaborative web application for interface design, with additional offline features enabled by desktop applications for macOS and Windows. The Figma mobile app for Android and iOS allows viewing and interacting with Figma prototypes in real-time on mobile and tablet devices.';

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Row(
        children: [
          const WebSideBar(),
          SizedBox(
            width: maxwidth * (1130 / 1440),
          const WebSideBar(),
          SizedBox(
            width: maxwidth * (1130 / 1440),
            child: Column(
              children: [
                const GreenProfileIcon(),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 70, right: 70),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: '$numeration. ',
                              style: GoogleFonts.notoSans(
                                fontSize: MediaQuery.of(context).size.height *
                                    (60 / 1024),
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: loadedLecture['name'],
                                  style: GoogleFonts.notoSans(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            (60 / 1024),
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: maxwidth * (1440 / 1440),
                        height: _showMore
                            ? MediaQuery.of(context).size.height * 0.75
                            : MediaQuery.of(context).size.height * 0.7,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F3F9),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: const Color(0xFFF3F3F9),
                          ),
                          boxShadow: const [
                            BoxShadow(
                                color: Color.fromARGB(200, 180, 180, 180),
                                blurRadius: 1,
                                spreadRadius: 1.5,
                                offset: Offset(0, 2)),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.57,
                                child: YoutubePlayer(
                                  controller: _controller,
                                  //aspectRatio: double.infinity / 9,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: 'Status: ',
                                      style: GoogleFonts.notoSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Ongoing',
                                          style: GoogleFonts.notoSans(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _showMore = !_showMore;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          'show more',
                                          style: GoogleFonts.notoSans(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Icon(
                                          _showMore
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Visibility(
                                visible: _showMore,
                                child: Text(
                                  description,
                                  style: GoogleFonts.notoSans(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
