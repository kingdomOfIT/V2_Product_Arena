import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../web_constansts_ob.dart';

class VideoTile extends StatelessWidget {
  VideoTile({super.key});

  final _controller = YoutubePlayerController.fromVideoId(
    videoId: 'd2lPRffORYQ',
    autoPlay: false,
    params: const YoutubePlayerParams(showFullscreenButton: true),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 372,
      width: 455,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        border: Border.all(
          width: 1,
          color: const Color(
            0xFF79747E,
          ),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.only(top: 26),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 26, right: 26),
                child: CustomText(
                    'Pogledajte video snimak Amera i poslušajte njegovu poruku',
                    14,
                    FontWeight.w700)),
            Container(
              height: 280,
              width: 465,
              padding: const EdgeInsets.all(23),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
              child: YoutubePlayer(
                controller: _controller,
                aspectRatio: 16 / 9,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
