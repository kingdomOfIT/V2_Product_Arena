import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/mobile/features/lectures/const.dart';
import 'package:v2_product_arena/mobile/features/onboarding/widgets/form_button.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayPage extends StatefulWidget {
  final String videoId;
  final String lectureName;
  final String lectureDecription;
  final PageController pageController;

  const VideoPlayPage(
      {super.key,
      required this.videoId,
      required this.lectureName,
      required this.pageController,
      required this.lectureDecription});

  @override
  State<VideoPlayPage> createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
    );
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
          ),
          builder: (context, player) {
            return Column(
              children: [
                Row(
                  children: [
                    Text(
                      '${widget.pageController.page!.toInt()}. Tools: ',
                      style: GoogleFonts.notoSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    Text(
                      widget.lectureName,
                      style: GoogleFonts.notoSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ],
                ),
                player,
                Text(
                  widget.lectureDecription,
                  style: GoogleFonts.notoSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                SizedBox(
                  height: (250 / 800) * MediaQuery.of(context).size.height,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal:
                          (32 / 360) * MediaQuery.of(context).size.width),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (widget.pageController.page!.toInt() > 1 &&
                          widget.pageController.page!.toInt() <
                              lectureLinks.length) ...[
                        FormButton(
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          text: 'Back',
                          borderColor: Colors.black,
                          onPressed: () {
                            widget.pageController.previousPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInBack);
                          },
                          buttonWidth:
                              (92 / 360) * MediaQuery.of(context).size.width,
                          buttonHeight:
                              (40 / 800) * MediaQuery.of(context).size.height,
                        ),
                        FormButton(
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          text: 'Next',
                          borderColor: Colors.black,
                          onPressed: () {
                            widget.pageController.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeIn);
                          },
                          buttonWidth:
                              (92 / 360) * MediaQuery.of(context).size.width,
                          buttonHeight:
                              (40 / 800) * MediaQuery.of(context).size.height,
                        ),
                      ] else if (widget.pageController.page!.toInt() == 1) ...[
                        SizedBox(
                          width:
                              (202 / 360) * MediaQuery.of(context).size.width,
                        ),
                        FormButton(
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          text: 'Next',
                          borderColor: Colors.black,
                          onPressed: () {
                            widget.pageController.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeIn);
                          },
                          buttonWidth:
                              (92 / 360) * MediaQuery.of(context).size.width,
                          buttonHeight:
                              (40 / 800) * MediaQuery.of(context).size.height,
                        ),
                      ] else if (widget.pageController.page!.toInt() ==
                          lectureLinks.length) ...[
                        FormButton(
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          text: 'Back',
                          borderColor: Colors.black,
                          onPressed: () {
                            //radi sa jumpToPage
                            //mozda duzina ne odgovara kod previousa
                            // widget.pageController
                            //     .jumpToPage(lectureLinks.length - 1);
                            widget.pageController.previousPage(
                                duration: const Duration(milliseconds: 1000),
                                curve: Curves.easeInBack);
                          },
                          buttonWidth:
                              (92 / 360) * MediaQuery.of(context).size.width,
                          buttonHeight:
                              (40 / 800) * MediaQuery.of(context).size.height,
                        ),
                        // SizedBox(
                        //   width:
                        //       (202 / 360) * MediaQuery.of(context).size.width,
                        // ),
                      ]
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
