import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_login_screen.dart';
import 'package:v2_product_arena/web/providers/web_auth_provider.dart';

class WebProfile extends StatelessWidget {
  const WebProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final webAuth = Provider.of<WebAuth>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, right: 50),
      child: Container(
        height: MediaQuery.of(context).size.height * (100 / 1094),
        alignment: Alignment.topRight,
        child: PopupMenuButton<int>(
          icon: Image.asset('assets/images/Profileicon.png'),
          iconSize: 50,
          itemBuilder: (context) => [
            PopupMenuItem(
              enabled: true,
              //value: 1,
              padding: const EdgeInsets.all(0),
              onTap: () {},
              child: SizedBox(
                height: deviceHeight * (500 / 1024),
                child: Column(
                  children: [
                    SizedBox(
                      height: deviceHeight * (120 / 1024),
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/prodarena.png',
                          ),
                          Positioned(
                            top: deviceHeight * 0.03,
                            left: deviceWidth * 0.067,
                            child: Image.asset(
                              'assets/images/blackProfile.png',
                              height: deviceHeight * (100 / 1024),
                            ),
                          ),
                          // Row(
                          //   children: const [
                          //     Icon(Icons.logout),
                          //     SizedBox(
                          //       width: 10,
                          //     ),
                          //     Text("Logout"),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                    Text(
                      '${webAuth.userName} ${webAuth.userSurname}',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w400,
                        fontSize: deviceHeight * (30 / 1024),
                      ),
                    ),
                    Text(
                      webAuth.emailUser,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.notoSans(
                        fontWeight: FontWeight.w400,
                        fontSize: deviceHeight * (16 / 1024),
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * (13 / 1024),
                    ),
                    const Divider(
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: deviceWidth * (17 / 1440),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/profileUser.png',
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'My interests:',
                            style: GoogleFonts.notoSans(
                              fontWeight: FontWeight.w400,
                              fontSize: deviceHeight * (17 / 1024),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: deviceHeight * (14 / 1024),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: deviceWidth * (10 / 1440),
                      ),
                      child: Column(
                        children: webAuth.roles
                            .map((role) => Container(
                                  padding: EdgeInsets.only(
                                    bottom: deviceHeight * (14 / 1024),
                                  ),
                                  child: role == webAuth.firstRole
                                      ? Row(
                                          children: [
                                            Image.asset(
                                              height:
                                                  deviceHeight * (30 / 1094),
                                              width: deviceWidth * (30 / 1440),
                                              webAuth.firstRole == 'backend'
                                                  ? 'assets/images/rolevectorblack3.png'
                                                  : webAuth.firstRole ==
                                                          'fullstack'
                                                      ? 'assets/images/rolevectorblack5.png'
                                                      : webAuth.firstRole ==
                                                              'qa'
                                                          ? 'assets/images/rolevectorblack1.png'
                                                          : webAuth.firstRole ==
                                                                  'productManager'
                                                              ? 'assets/images/rolevectorblack2.png'
                                                              : 'assets/images/rolevectorblack4.png',
                                            ),
                                            SizedBox(
                                                width:
                                                    deviceWidth * (5 / 1440)),
                                            Text(
                                              webAuth.firstRole == 'backend'
                                                  ? 'Backend Development'
                                                  : webAuth.firstRole ==
                                                          'fullstack'
                                                      ? 'Fullstack Development'
                                                      : webAuth.firstRole ==
                                                              'qa'
                                                          ? 'Quality Assurance'
                                                          : webAuth.firstRole ==
                                                                  'productManager'
                                                              ? 'Project Management'
                                                              : 'UI/UX Design',
                                              style: GoogleFonts.notoSans(
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    deviceWidth * (14 / 1440),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Flexible(
                                              child: Image.asset(
                                                height:
                                                    deviceHeight * (30 / 1094),
                                                width:
                                                    deviceWidth * (30 / 1440),
                                                webAuth.secondRole == 'backend'
                                                    ? 'assets/images/rolevectorblack3.png'
                                                    : webAuth.secondRole ==
                                                            'fullstack'
                                                        ? 'assets/images/rolevectorblack5.png'
                                                        : webAuth.secondRole ==
                                                                'qa'
                                                            ? 'assets/images/rolevectorblack1.png'
                                                            : webAuth.secondRole ==
                                                                    'productManager'
                                                                ? 'assets/images/rolevectorblack2.png'
                                                                : 'assets/images/rolevectorblack4.png',
                                              ),
                                            ),
                                            SizedBox(
                                                width:
                                                    deviceWidth * (5 / 1440)),
                                            Text(
                                              webAuth.secondRole == 'backend'
                                                  ? 'Backend Development'
                                                  : webAuth.secondRole ==
                                                          'fullstack'
                                                      ? 'Fullstack Development'
                                                      : webAuth.secondRole ==
                                                              'qa'
                                                          ? 'Quality Assurance'
                                                          : webAuth.secondRole ==
                                                                  'productManager'
                                                              ? 'Project Management'
                                                              : 'UI/UX Design',
                                              style: GoogleFonts.notoSans(
                                                fontWeight: FontWeight.w700,
                                                fontSize:
                                                    deviceWidth * (16 / 1440),
                                              ),
                                            ),
                                          ],
                                        ),
                                ))
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),
            ),
            PopupMenuItem(
              enabled: false,
              child: Center(
                child: Container(
                  height: deviceHeight * (45 / 1024),
                  width: deviceWidth * (105 / 1440),
                  margin: EdgeInsets.only(bottom: deviceHeight * (45 / 1024)),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        )),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: deviceHeight * (7.5 / 803),
                        right: deviceWidth * (2 / 360),
                        bottom: deviceHeight * (7.5 / 803),
                        left: deviceWidth * (2 / 360),
                      ),
                      child: Text(
                        'Log out',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.notoSans(
                          textStyle: TextStyle(
                            fontSize: deviceHeight * (14 / 803),
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        final res = await Amplify.Auth.signOut();
                        safePrint(res);
                        // ignore: use_build_context_synchronously
                        Navigator.of(context)
                            .pushReplacementNamed(WebLoginScreen.routeName);
                      } on AuthException catch (e) {
                        safePrint(e.message);
                      }
                    },
                  ),
                ),
              ),
            )
          ],
          offset: const Offset(-50, 65),
          color: Colors.white,
        ),
      ),
    );
  }
}
