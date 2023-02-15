import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../providers/web_ob_role.dart';

List<double> tileHeights = [132, 132, 132, 132, 165];
List<double> roleTextWidth = [130, 171, 125, 125, 160];
var tileQuestions = [
  "Šta te motiviše?",
  "Da li imaš ili si imao/la neki hobi ili se baviš nekim sportom?",
  "Postoji li neko interesovanje koje imaš, ali ga trenutno ne možeš ostvariti?",
  "Da li bi vodio/la brigu o kućnom ljubimcu svojih komšija dok su oni na godišnjem odmoru?",
  "Kapetan si piratskog broda, tvoja posada može da glasa kako se dijeli zlato. Ako se manje od polovine pirata složi sa tobom, umrijet ćeš. Kakvu podjelu zlata bi predložio/la tako da dobiješ dobar dio plijena, a ipak preživiš?"
];

var roleText = [
  "QA Engineering",
  "Project Management",
  "Backend",
  "UI/UX Design ",
  "Full Stack Developer"
];

List<Role> listRole = [
  Role(
    {
      'forFrontend': 'QA Engineering',
      'forBackend': 'qa',
    },
    'assets/images/rolevectorblack1.png',
  ),
  Role(
    {
      'forFrontend': 'Project Management',
      'forBackend': 'productManager',
    },
    'assets/images/rolevectorblack2.png',
  ),
  Role(
    {
      'forFrontend': 'Backend',
      'forBackend': 'backend',
    },
    'assets/images/rolevectorblack3.png',
  ),
  Role(
    {
      'forFrontend': 'UI/UX Design',
      'forBackend': 'uiux',
    },
    'assets/images/rolevectorblack4.png',
  ),
  Role(
    {
      'forFrontend': 'Full Stack Developer',
      'forBackend': 'fullstack',
    },
    'assets/images/rolevectorblack5.png',
  )
];
List<Role> listRoleSel = [
  Role(
    {
      'forFrontend': 'QA Engineering',
      'forBackend': 'qa',
    },
    'assets/images/rolevectorwhite1.png',
  ),
  Role(
    {
      'forFrontend': 'Project Management',
      'forBackend': 'productManager',
    },
    'assets/images/rolevectorwhite2.png',
  ),
  Role(
    {
      'forFrontend': 'Backend',
      'forBackend': 'backend',
    },
    'assets/images/rolevectorwhite3.png',
  ),
  Role(
    {
      'forFrontend': 'UI/UX Design',
      'forBackend': 'uiux',
    },
    'assets/images/rolevectorwhite4.png',
  ),
  Role(
    {
      'forFrontend': 'Full Stack Developer',
      'forBackend': 'fullstack',
    },
    'assets/images/rolevectorwhite5.png',
  )
];

Widget CustomText(
  String text,
  double size, [
  FontWeight fontwh = FontWeight.normal,
  Color color = const Color(0xFF000000),
]) {
  return Text(
    text,
    style:
        GoogleFonts.notoSans(fontSize: size, fontWeight: fontwh, color: color),
  );
}
