import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/constants/global_variables.dart';
import 'package:v2_product_arena/mobile/features/onboarding/widgets/form_button.dart';
import 'package:v2_product_arena/mobile/providers/answer_provider.dart';
import 'package:v2_product_arena/mobile/providers/error_message_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkVideoScreen extends StatefulWidget {
  final TextEditingController controller;
  final PageController pageController;
  const LinkVideoScreen(
      {super.key, required this.controller, required this.pageController});

  @override
  State<LinkVideoScreen> createState() => _LinkVideoScreenState();
}

class _LinkVideoScreenState extends State<LinkVideoScreen> {
  final _formKey = GlobalKey<FormState>();

  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId:
          '2_uX7GxPzDI', // https://www.youtube.com/watch?v=Tb9k9_Bo-G4
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        isLive: false,
      ),
    );
  }

  RegExp videohttp = RegExp(
      r'^(?:(?:http:\/\/|https:\/\/)?(?:www\.)?(?:youtube\.com|youtu\.be|vimeo\.com)\/(?:watch\?v=)?([a-zA-Z0-9_-]{11}|[0-9]+)|(?:http:\/\/|https:\/\/)?(?:www\.)?file\.io\/[a-zA-Z0-9]+)?$');

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller!,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.red,
          progressColors: const ProgressBarColors(
            playedColor: Colors.red,
            handleColor: Colors.black38,
          ),
        ),
        builder: (context, player) {
          return Scaffold(
              backgroundColor: const Color.fromRGBO(233, 233, 233, 1),
              appBar: MyHeader(),
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: (32 / 360) * MediaQuery.of(context).size.width,
                    right: (32 / 360) * MediaQuery.of(context).size.width,
                  ),
                  child: SingleChildScrollView(
                    key: const Key('videoScroll'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: (50 / 800) * deviceHeight,
                        ),
                        Text(
                          'Pogledajte video snimak Amera i poslušajte njegovu poruku.',
                          style: GoogleFonts.notoSans(
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w700,
                            fontSize:
                                (16 / 360) * MediaQuery.of(context).size.width,
                          ),
                        ),
                        SizedBox(
                          height: (20 / 800) * deviceHeight,
                        ),
                        player,
                        SizedBox(
                          height: (35 / 800) * deviceHeight,
                        ),
                        Text(
                          'Snimi video i predstavi se! Recite nam nešto zanimljivo o sebi ili o nečemu što vas zanima.',
                          style: GoogleFonts.notoSans(
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.w700,
                              fontSize: (16 / 360) *
                                  MediaQuery.of(context).size.width),
                        ),
                        SizedBox(
                          height: (15 / 800) * deviceHeight,
                        ),
                        Text(
                          'Molimo te da link staviš u box!',
                          style: GoogleFonts.notoSans(
                            fontSize: deviceHeight * 0.013,
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: TextFormField(
                            key: const Key('vasOdgovorTextField'),
                            controller: widget.controller,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: deviceHeight * 0.0187,
                              fontWeight: FontWeight.w700,
                            ),
                            decoration: InputDecoration(
                              isDense: true,
                              labelStyle: const TextStyle(fontSize: 20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                    color: Color.fromRGBO(34, 233, 116, 1),
                                  )),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                    color: Colors.black,
                                  )),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: deviceHeight * 0.013,
                                horizontal: deviceWidth * 0.05,
                              ),
                              hintText: 'https://',
                              hintStyle: GoogleFonts.notoSans(
                                fontSize: deviceHeight * (14 / 800),
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            validator: (value) {
                              if (!videohttp.hasMatch(value!)) {
                                return 'Invalid format';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Za učitavanje videa koristi ',
                              style: GoogleFonts.notoSans(
                                fontSize: deviceHeight * 0.013,
                                color: Colors.black54,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                await launchUrl(
                                  Uri.parse('https://www.file.io/'),
                                );
                              },
                              child: Text(
                                'file.io',
                                style: GoogleFonts.notoSans(
                                  decoration: TextDecoration.underline,
                                  fontSize: deviceHeight * 0.013,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Consumer<ErrorMessage>(
                          builder: (context, error, child) {
                            return Container(
                              padding:
                                  const EdgeInsets.only(left: 20.0, top: 5.0),
                              height: error.errorHeight,
                              child: Row(
                                children: <Widget>[
                                  Icon(error.errorIcon,
                                      size: 20.0, color: Colors.red[700]),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      error.errorText,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.red[700],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: (65 / 800) * deviceHeight,
                        ),
                        Row(
                          children: [
                            FormButton(
                              backgroundColor: Colors.white,
                              text: 'Back',
                              buttonWidth: (90 / 360) *
                                  MediaQuery.of(context).size.width,
                              buttonHeight: 40,
                              textColor: Colors.black,
                              borderColor: Colors.black,
                              onPressed: () {
                                widget.pageController.previousPage(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.easeInBack);
                              },
                            ),
                            SizedBox(
                              width: (116 / 360) *
                                  MediaQuery.of(context).size.width,
                            ),
                            FormButton(
                                key: const Key('nextButtonVideo'),
                                backgroundColor: Colors.black,
                                text: 'Next',
                                buttonWidth: (90 / 360) *
                                    MediaQuery.of(context).size.width,
                                buttonHeight: 40,
                                textColor: Colors.white,
                                borderColor: Colors.black,
                                onPressed: () {
                                  if (_formKey.currentState!.validate() ==
                                      true) {
                                    context
                                        .read<AnswerProvider>()
                                        .addItem(widget.controller.text);
                                    context.read<ErrorMessage>().reset();
                                    widget.pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 400),
                                        curve: Curves.easeIn);
                                  } else {
                                    context.read<ErrorMessage>().change();
                                  }
                                }),
                          ],
                        ),
                        const SizedBox(
                          height: 120,
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }
}
