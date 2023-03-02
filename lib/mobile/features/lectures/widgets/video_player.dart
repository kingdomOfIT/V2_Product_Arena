import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/mobile/features/lectures/screens/hello_screen.dart';
import 'package:v2_product_arena/mobile/features/lectures/widgets/lectures_appbar.dart';
import 'package:v2_product_arena/mobile/features/lectures/widgets/lectures_indicator.dart';
import 'package:v2_product_arena/mobile/features/lectures/widgets/lectures_sidebar.dart';
import 'package:v2_product_arena/mobile/features/onboarding/widgets/form_button.dart';
import 'package:v2_product_arena/mobile/providers/error_message_provider.dart';
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

  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<MobileAuth>(context);
    return Scaffold(
      appBar: !dataProvider.isPlayingInFullscr
          ? AppBar(
              backgroundColor: const Color(0xFFFFFFFF),
              elevation: 0,
              leading: Container(
                height: 55,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * (10 / 803),
                    bottom: MediaQuery.of(context).size.height * (10 / 803),
                    left: MediaQuery.of(context).size.width * (20 / 360),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      _controller.pause();
                      Provider.of<ErrorMessage>(context, listen: false)
                          .selectedRole
                          .clear();
                      Navigator.of(context).pushNamed(WelcomePage.routeName);
                    },
                    child: Image.asset(
                      "assets/images/PAlogowhite.png",
                      height: MediaQuery.of(context).size.width * (35 / 360),
                      width: MediaQuery.of(context).size.width * (35 / 360),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      right: (32 / 360) * MediaQuery.of(context).size.width),
                  child: GestureDetector(
                    onTap: () {
                      dataProvider.isSidebarOpened2
                          ? _key.currentState!.closeEndDrawer()
                          : _key.currentState!.openEndDrawer();
                      dataProvider.changeSidebar2();
                    },
                    child: dataProvider.isSidebarOpened2
                        ? const Icon(Icons.close)
                        : const Icon(Icons.menu),
                  ),
                ),
              ],
            )
          : null,
      body: Scaffold(
        key: _key,
        appBar: !dataProvider.isPlayingInFullscr
            ? PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 23),
                child: Padding(
                    padding: EdgeInsets.only(
                      right: (32 / 360) * MediaQuery.of(context).size.width,
                      left: (32 / 360) * MediaQuery.of(context).size.width,
                    ),
                    child: LecturesPageIndicator(
                      currentPage: widget.pageController.page!.toInt() - 1,
                      totalPages: widget.numb,
                      width: (MediaQuery.of(context).size.width - 108) /
                          (widget.numb),
                      height: 3,
                      indicatorHeight: 23,
                    )),
              )
            : null,
        endDrawer: Drawer(
            width: MediaQuery.of(context).size.width,
            child: const MobileSidebar()),
        backgroundColor: const Color(0xFFE9E9E9),
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
                  dataProvider.changePlaying(_controller.value.isFullScreen);
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
                            dataProvider.isPlayingInFullscr
                                ? IgnorePointer(child: player)
                                : player,
                            Positioned(
                              left: (83 / 360) *
                                  MediaQuery.of(context).size.width,
                              right: (83 / 360) *
                                  MediaQuery.of(context).size.width,
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.lectureDecription,
                          style: GoogleFonts.notoSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height:
                            (250 / 800) * MediaQuery.of(context).size.height,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: (115 / 800) *
                                MediaQuery.of(context).size.height),
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
                                      duration:
                                          const Duration(milliseconds: 400),
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
      ),
    );
  }
}
