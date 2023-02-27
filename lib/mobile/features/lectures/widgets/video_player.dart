import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/mobile/features/lectures/widgets/lectures_appbar.dart';
import 'package:v2_product_arena/mobile/features/onboarding/widgets/form_button.dart';
import 'package:v2_product_arena/mobile/providers/mobile_auth_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayPage extends StatefulWidget {
  final String videoId;
  final String lectureName;
  final String lectureDecription;
  final PageController pageController;
  final int numb;

  const VideoPlayPage(
      {super.key,
      required this.videoId,
      required this.lectureName,
      required this.pageController,
      required this.lectureDecription,
      required this.numb});

  @override
  State<VideoPlayPage> createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  late YoutubePlayerController _controller;
  Timer? _timer;
  bool _buttonsVisible = false;

  String getVideoId(String s) {
    return YoutubePlayer.convertUrlToId(widget.videoId) as String;
  }

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: getVideoId(widget.videoId),
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
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<MobileAuth>(context);
    return Scaffold(
      backgroundColor: const Color(0xFFE9E9E9),
      appBar: WelcomepageAppBar(scaffoldKey: dataProvider.scaffoldKey),
      body: YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: _controller,
            progressColors: const ProgressBarColors(
                playedColor: Color(0xFFFF0000),
                backgroundColor: Color(0xFF605D66),
                handleColor: Color(0xFFFF0000)),
            onReady: () {
              _controller.addListener(() {
                setState(() {});

                if (_controller.value.playerState == PlayerState.paused) {
                  setState(() {
                    _buttonsVisible = true;
                  });
                }
                if (_controller.value.isPlaying) {
                  setState(() {
                    _buttonsVisible = false;
                  });
                }
              });
            },
          ),
          builder: (context, player) {
            return Padding(
              padding: EdgeInsets.only(
                  top: 23,
                  left: (32 / 360) * MediaQuery.of(context).size.width,
                  right: (32 / 360) * MediaQuery.of(context).size.width),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${widget.pageController.page!.toInt()}. Tools: ${widget.lectureName}',
                        style: GoogleFonts.notoSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _buttonsVisible = true;
                        });

                        _timer?.cancel();
                        _timer = Timer(const Duration(seconds: 5), () {
                          setState(() {
                            _buttonsVisible = false;
                          });
                        });
                      },
                      child: Stack(
                        children: [
                          player,
                          Positioned(
                            left:
                                (83 / 360) * MediaQuery.of(context).size.width,
                            right:
                                (83 / 360) * MediaQuery.of(context).size.width,
                            top: 82,
                            child: Visibility(
                              visible: _buttonsVisible,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: (25 / 360) *
                                        MediaQuery.of(context).size.width,
                                    width: (25 / 360) *
                                        MediaQuery.of(context).size.width,
                                    child: GestureDetector(
                                      onTap: () {
                                        _controller.seekTo(Duration(
                                          seconds: _controller
                                                  .value.position.inSeconds -
                                              10,
                                        ));
                                      },
                                      child: Image.asset(
                                          'assets/images/leftskip.png'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: (25 / 360) *
                                        MediaQuery.of(context).size.width,
                                    width: (25 / 360) *
                                        MediaQuery.of(context).size.width,
                                    child: GestureDetector(
                                      onTap: () {
                                        _controller.seekTo(Duration(
                                          seconds: _controller
                                                  .value.position.inSeconds +
                                              10,
                                        ));
                                      },
                                      child: Image.asset(
                                          'assets/images/rightskip.png'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
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
                      padding: const EdgeInsets.only(bottom: 115),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: widget.pageController.page!.toInt() > 1,
                            child: FormButton(
                              key: const Key('back_button_lectures'),
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              text: 'Back',
                              borderColor: Colors.black,
                              onPressed: () {
                                if (widget.pageController.page!.toInt() <
                                    widget.numb) {
                                  widget.pageController.previousPage(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      curve: Curves.easeInBack);
                                } else {
                                  widget.pageController
                                      .jumpToPage(widget.numb - 1);
                                }
                              },
                              buttonWidth: (92 / 360) *
                                  MediaQuery.of(context).size.width,
                              buttonHeight: 40,
                            ),
                          ),
                          Visibility(
                            visible: widget.pageController.page!.toInt() <
                                widget.numb,
                            child: FormButton(
                              key: const Key('next_button_lectures'),
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              text: 'Next',
                              borderColor: Colors.black,
                              onPressed: () {
                                widget.pageController.nextPage(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeIn);
                              },
                              buttonWidth: (92 / 360) *
                                  MediaQuery.of(context).size.width,
                              buttonHeight: 40,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
