import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../features/home/screens/web_lecturevideo_screen.dart';

class WebLectureCard extends StatefulWidget {
  final String name;
  final String description;
  final int durationInSeconds;
  // final int lastStoppedInSeconds;
  // final String status;
  final String imageSrc;

  const WebLectureCard({
    super.key,
    required this.name,
    required this.description,
    required this.durationInSeconds,
    //required this.lastStoppedInSeconds,
    //required this.status,
    required this.imageSrc,
  });

  @override
  State<WebLectureCard> createState() => _WebLectureCardState();
}

class _WebLectureCardState extends State<WebLectureCard> {
  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    double maxheight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.all(maxwidth * (30 / 1440)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ///////////////////////////////////////////////// LECTURE INFORMATIONS ///////////////////////////////////////////////////////////////

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // lectures[index].name,
                    widget.name,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w400,
                      fontSize: maxheight * (32 / 1510),
                    ),
                  ),
                  SizedBox(
                    height: maxheight * (27 / 1510),
                  ),
                  SizedBox(
                    width: maxwidth * (550 / 1440),
                    child: Text(
                      // lectures[index].description,
                      widget.description,
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w400,
                        fontSize: maxheight * (18 / 1510),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: maxheight * (160 / 1510),
                  ),
                  Text(
                    // 'Total time: ${lectures[index].durationInSeconds}',
                    'Total time: ${widget.durationInSeconds}',
                    style: GoogleFonts.notoSans(
                        fontSize: maxheight * (16 / 1510),
                        fontWeight: FontWeight.w400),
                  ),
                  // Text(
                  //   // 'Remaning time: ${lectures[index].remainingTime}',
                  //   'Remaning time: ${lastStoppedInSeconds}',
                  //   style: GoogleFonts.notoSans(
                  //       fontSize: maxheight * (16 / 1510),
                  //       fontWeight: FontWeight.w400),
                  // ),
                  // Text(
                  //   // 'Status: ${lectures[index].status}',
                  //   'Status: ${status}',
                  //   style: GoogleFonts.notoSans(
                  //       fontSize: maxheight * (16 / 1510),
                  //       fontWeight: FontWeight.w400),
                  // ),
                ],
              ),
              ///////////////////////////////////////////////// LECTURE IMAGE ///////////////////////////////////////////////////////////////
              SizedBox(
                width: maxwidth * (30 / 1440),
              ),
              SizedBox(
                width: maxwidth * (370 / 1440),
                height: maxheight * (270 / 1510),
                child: Image.network(
                  // lectures[index].imageSrc,
                  widget.imageSrc,
                ),
              ),
            ],
          ),
          Divider(
            height: maxheight * (25 / 1510),
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
