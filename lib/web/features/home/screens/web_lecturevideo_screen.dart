import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: unused_import
import 'package:v2_product_arena/web/reusable_web_widgets/oldsidebar.dart';
// ignore: unused_import
import 'package:v2_product_arena/web/reusable_web_widgets/web_homepage_sidebar.dart';

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
    return Scaffold(
      body: Row(
        children: [
          const Expanded(
            flex: 2,
            child: WebSideBar(),
          ),
          Expanded(
            flex: 8,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 10, bottom: 10, right: 50),
                  child: Container(
                    height: 70,
                    alignment: Alignment.topRight,
                    child: Image.asset('assets/images/Profileicon.png'),
                  ),
                ),
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
                                fontSize: 55,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: title.toString(),
                                  style: GoogleFonts.notoSans(
                                    fontSize: 55,
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
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: _showMore
                            ? MediaQuery.of(context).size.height * 0.65
                            : MediaQuery.of(context).size.height * 0.555,
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
                              const Expanded(
                                child: Text('VideoPlaceholder'),
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
                                          'Show More',
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
