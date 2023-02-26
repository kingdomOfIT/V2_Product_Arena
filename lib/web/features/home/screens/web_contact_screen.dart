// ignore_for_file: deprecated_member_use

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:v2_product_arena/constants/global_variables.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_green_profile.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_homepage_sidebar.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_profilepopup.dart';

class WebContactScreen extends StatefulWidget {
  static const routeName = '/web-contact';

  const WebContactScreen({super.key});

  @override
  State<WebContactScreen> createState() => _WebContactScreenState();
}

class _WebContactScreenState extends State<WebContactScreen> {
  final _contactFormKey = GlobalKey<FormState>();
  final contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    double maxheight = MediaQuery.of(context).size.height;

    double maxwidth = MediaQuery.of(context).size.width;
    double maxheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Row(
        children: [
          const WebSideBar(),
          SizedBox(
            width: maxwidth * (1130 / 1440),
          const WebSideBar(),
          SizedBox(
            width: maxwidth * (1130 / 1440),
            child: Column(
              children: [
                const WebProfilePopup(),
                SizedBox(
                  width: maxwidth * (840 / 1440),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              RichText(
                                textAlign: TextAlign.end,
                                text: TextSpan(
                                  text: 'CONTACT US\n',
                                  style: GoogleFonts.notoSans(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w700),
                                  children: [
                                    TextSpan(
                                      text:
                                          'You are more than welcome to leave your\nmessage and we will be in touch shortly.',
                                      style: GoogleFonts.notoSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: maxwidth * (30 / 1440)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: TextFormField(
                              key: const Key('contactField'),
                              controller: contactController,
                              validator: (value) {
                                return value;
                              },
                              maxLines: 8,
                              decoration: InputDecoration(
                                label: Text(
                                  'Your Message',
                                  style: GoogleFonts.notoSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF22E974),
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              style: GoogleFonts.notoSans(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(141, 55)),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: GestureDetector(
                              child: Image.asset(
                                'assets/images/facebook.png',
                              ),
                              onTap: () =>
                                  launch('https://www.facebook.com/tech387'),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: GestureDetector(
                              child: Image.asset(
                                'assets/images/instagram.png',
                              ),
                              onTap: () => launch(
                                  'https://www.instagram.com/tech387/?hl=en'),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: GestureDetector(
                              child: Image.asset(
                                'assets/images/linked.png',
                              ),
                              onTap: () => launch(
                                  'https://www.linkedin.com/company/tech-387/mycompany/'),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: GestureDetector(
                              child: Image.asset(
                                'assets/images/tech.png',
                              ),
                              onTap: () => launch('https://www.tech387.com/'),
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                InkWell(
                                  onTap: () async {
                                    await launchUrl(Uri.parse(
                                        'https://www.google.ba/maps/place/Tech387/@43.8538483,18.4205947,17z/data=!3m1!4b1!4m6!3m5!1s0x4758c903ae6b4fe1:0xa4116c0159094813!8m2!3d43.8538483!4d18.4227834!16s%2Fg%2F11h_6q3_47'));
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/images/pinlocation.png',
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: Text(
                                          'Put Mladih Muslimana 2, City Gardens Residence, 71 000 Sarajevo, Bosnia and Herzegovina\n 14425 Falconhead Blvd, Bee Cave, TX 78738, United States',
                                          style: GoogleFonts.notoSans(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Image.asset(
                                      'assets/images/mail.png',
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'hello@tech387.com',
                                      style: GoogleFonts.notoSans(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
