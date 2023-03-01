import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/mobile/providers/role_provider.dart';

class GlobalVariables {
  static const myColor = Color(0xFF22E974);

  static const List<Map<String, String>> socialMedia = [
    {
      'image': 'assets/images/facebook.png',
      'url': 'https://www.facebook.com/tech387',
    },
    {
      'image': 'assets/images/instagram.png',
      'url': 'https://www.instagram.com/tech387/?hl=en',
    },
    {
      'image': 'assets/images/linked.png',
      'url': 'https://www.linkedin.com/company/tech-387/mycompany/',
    },
    {
      'image': 'assets/images/tech.png',
      'url': 'https://www.tech387.com/',
    },
  ];

  static const List<String> status = [
    'Student',
    'Employed',
    'Unemployed',
  ];
}

var textQuestions = [
  "Šta te motiviše?",
  "Da li imaš ili si imao/la neki hobi ili se baviš nekim sportom?",
  "Postoji li neko interesovanje koje imaš, ali ga trenutno ne možeš ostvariti?",
  "Da li bi vodio/la brigu o kućnom ljubimcu svojih komšija dok su oni na godišnjem odmoru?",
  "Kapetan si piratskog broda, tvoja posada može da glasa kako se dijeli zlato. Ako se manje od polovine pirata složi sa tobom, umrijet ćeš.\n\nKakvu podjelu zlata bi predložio/la tako da dobiješ dobar dio plijena, a ipak preživiš?"
];

Widget errorContainer(
    String errorText, IconData? errorIcon, double errorContainerHeight) {
  return Container(
      padding: const EdgeInsets.only(left: 20.0, top: 5.0),
      height: errorContainerHeight,
      child: Row(
        children: <Widget>[
          Icon(errorIcon, size: 20.0, color: Colors.red[700]),
          Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: Text(
              errorText,
              style: TextStyle(fontSize: 16.0, color: Colors.red[700]),
            ),
          ),
        ],
      ));
}

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
List<Role> listRoleMob = [
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
    'assets/images/rolevectorwhite5.png',
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

List<Role> listRoleMobSel = [
  Role(
    {
      'forFrontend': 'QA Engineering',
      'forBackend': 'qa',
    },
    'assets/images/qa_icon_green.png',
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
    'assets/images/backend_green.png',
  ),
  Role(
    {
      'forFrontend': 'UI/UX Design',
      'forBackend': 'uiux',
    },
    'assets/images/uiux_green.png',
  ),
  Role(
    {
      'forFrontend': 'Full Stack Developer',
      'forBackend': 'fullstack',
    },
    'assets/images/rolevectorwhite5.png',
  )
];

class UsersRole {
  final String name;
  final String icon;

  UsersRole({
    required this.name,
    required this.icon,
  });
}

List<UsersRole> usersRole = [
  UsersRole(
    name: 'Fullstack',
    icon: 'assets/images/rolevectorwhite5.png',
  ),
  UsersRole(
    name: 'Backend',
    icon: 'assets/images/rolevectorwhite3.png',
  ),
];
// ignore: non_constant_identifier_names
PreferredSizeWidget? MyHeader() {
  return AppBar(
    backgroundColor: const Color(0xFFE9E9E9),
    automaticallyImplyLeading: false,
    toolbarHeight: 37,
    elevation: 0,
    centerTitle: true,
    title: Text(
      'Onboarding Form',
      style: GoogleFonts.notoSans(
          fontSize: 17, fontWeight: FontWeight.w700, color: Colors.black),
    ),
  );
}

class name extends StatelessWidget {
  const name({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class GreenProfileIcon extends StatelessWidget {
  const GreenProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 50),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * (50 / 1440),
          height: 50,
          child: Image.asset('assets/images/Profileicon.png'),
        ),
      ),
    );
  }
}
