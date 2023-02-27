import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/web/providers/web_auth_provider.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_green_profile.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_homepage_sidebar.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

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
  bool init = false;

  RegExp exp = RegExp(r'(?<=v=)[^&]+');

  @override
  Widget build(BuildContext context) {
    //final isMuted = _controller.value.volume == 0;
    double maxwidth = MediaQuery.of(context).size.width;
    final webAuth = Provider.of<WebAuth>(context, listen: false);
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final lectureName = args['lectureName'] as String;
    final lectureIndex = args['index'];
    final loadedLecture = webAuth.lectures
        .firstWhere((lecture) => lecture['name'] == lectureName);
    String url = loadedLecture['contentLink'];
    var videoId = exp.stringMatch(url);
    final _controller = YoutubePlayerController.fromVideoId(
      videoId: videoId!,
      autoPlay: false,
      params: const YoutubePlayerParams(showFullscreenButton: true),
    );
    return Scaffold(
      body: Row(
        children: [
          const WebSideBar(),
          SingleChildScrollView(
            child: SizedBox(
              width: maxwidth * (1130 / 1440),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topRight,
                    child: WebProfilePopup(),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 70, right: 70),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: maxwidth * (900 / 1440),
                              child: RichText(
                                text: TextSpan(
                                  text: '${lectureIndex + 1}. ',
                                  style: GoogleFonts.notoSans(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
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
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.75,
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
                                    loadedLecture['description'],
                                    style: GoogleFonts.notoSans(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              (16 / 1024),
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
            ),
          )
        ],
      ),
    );
  }
}
