import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_green_profile.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_homepage_sidebar.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_profile.dart';

class WebContactScreen extends StatefulWidget {
  static const routeName = '/contact-us';
  const WebContactScreen({super.key});

  @override
  State<WebContactScreen> createState() => _WebContactScreenState();
}

bool isContactFormSent = false;
bool isEnabled = true;

class _WebContactScreenState extends State<WebContactScreen> {
  final formKey = GlobalKey<FormState>();
  final contactUsController = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Row(
        children: [
          const WebSideBar(),
          Padding(
            padding: EdgeInsets.only(
              left: deviceWidth * (121 / 1440),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const WebProfile(),
                  SizedBox(
                    height: deviceHeight * (130 / 1024),
                  ),
                  Container(
                    height: deviceHeight * 0.78,
                    padding: EdgeInsets.only(
                      right: deviceWidth * (121 / 1440),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  width: deviceWidth * (375 / 1440),
                                  child: RichText(
                                    textAlign: TextAlign.right,
                                    text: TextSpan(
                                      text: 'CONTACT US\n',
                                      style: GoogleFonts.notoSans(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                      ),
                                      children: [
                                        TextSpan(
                                          text:
                                              'You are more than welcome to leave your message and we will be in touch shortly.\n\n\n',
                                          style: GoogleFonts.notoSans(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: deviceHeight * (120 / 1024),
                                ),
                                Row(
                                  children: <Widget>[
                                    InkWell(
                                        onTap: () => launch(
                                            'https://www.facebook.com/tech387'),
                                        child: Image.asset(
                                            'assets/images/facebook.png')),
                                    SizedBox(
                                      width: deviceWidth * (16 / 1440),
                                    ),
                                    InkWell(
                                        onTap: () => launch(
                                            'https://www.instagram.com/tech387/?hl=en'),
                                        child: Image.asset(
                                            'assets/images/instagram.png')),
                                    SizedBox(
                                      width: deviceWidth * (16 / 1440),
                                    ),
                                    InkWell(
                                        onTap: () => launch(
                                            'https://www.linkedin.com/company/tech-387/mycompany/'),
                                        child: Image.asset(
                                            'assets/images/linked.png')),
                                    SizedBox(
                                      width: deviceWidth * (16 / 1440),
                                    ),
                                    InkWell(
                                        onTap: () =>
                                            launch('https://www.tech387.com/'),
                                        child: Image.asset(
                                            'assets/images/tech.png')),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: deviceWidth * (44 / 1440),
                            ),
                            Container(
                              width: deviceWidth * (400 / 1440),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Form(
                                    key: formKey,
                                    child: TextFormField(
                                      key: const Key('mobileContactUs'),
                                      controller: contactUsController,
                                      validator: (value) {
                                        if (value == "" || value == null) {
                                          setState(() {
                                            isContactFormSent = false;
                                          });
                                          return "Please type your message before sending";
                                        } else if (value.length < 10) {
                                          setState(() {
                                            isContactFormSent = false;
                                          });
                                          return "Your message has to contain at least 10 characters";
                                        }
                                        setState(() {
                                          isContactFormSent = true;
                                        });
                                        return null;
                                      },
                                      maxLines: 8,
                                      decoration: InputDecoration(
                                        labelText: 'Your Message',
                                        alignLabelWithHint: true,
                                        labelStyle: GoogleFonts.notoSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
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
                                  Visibility(
                                    visible: isContactFormSent,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: deviceWidth * (350 / 1440),
                                          child: const Text(
                                            'Thank you for contacting us! We have received your message and will get back to you as soon as possible.',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xFF22E974),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: deviceHeight * 0.05,
                                  ),
                                  AbsorbPointer(
                                    absorbing: !isEnabled,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black87,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          top: deviceHeight * (7.5 / 803),
                                          right: deviceWidth * (2 / 360),
                                          bottom: deviceHeight * (7.5 / 803),
                                          left: deviceWidth * (2 / 360),
                                        ),
                                        child: Text(
                                          'Submit',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.notoSans(
                                            textStyle: TextStyle(
                                                fontSize:
                                                    deviceHeight * (14 / 803),
                                                fontWeight: FontWeight.w700,
                                                fontStyle: FontStyle.normal,
                                                color: const Color(0xFFFFFFFF)),
                                          ),
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (!isEnabled) {
                                          return;
                                        } // do nothing if button is disabled
                                        if (formKey.currentState!.validate()) {
                                          try {
                                            isEnabled =
                                                false; // disable the button
                                            Timer(
                                                const Duration(seconds: 100),
                                                () => isEnabled =
                                                    true); // enable the button after 100 seconds
                                            final restOperation =
                                                Amplify.API.post(
                                              'api/user/form',
                                              apiName: 'sendFormEmailAlfa',
                                              body: HttpPayload.json(
                                                {
                                                  'question':
                                                      contactUsController.text
                                                          .toString()
                                                },
                                              ),
                                            );
                                            final response =
                                                await restOperation.response;
                                            safePrint('POST call succeeded');
                                            safePrint(response.decodeBody());
                                          } on ApiException catch (e) {
                                            safePrint(
                                                'POST call failed: ${e.message}');
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: deviceHeight * (53 / 1024),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await launchUrl(Uri.parse(
                                          'https://www.google.ba/maps/place/Tech387/@43.8538483,18.4205947,17z/data=!3m1!4b1!4m6!3m5!1s0x4758c903ae6b4fe1:0xa4116c0159094813!8m2!3d43.8538483!4d18.4227834!16s%2Fg%2F11h_6q3_47'));
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Image.asset(
                                          'assets/images/mail.png',
                                        ),
                                      ),
                                      SizedBox(
                                        width: deviceWidth * (10 / 1440),
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
                        Container(
                          // width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Privacy Policy'),
                              SizedBox(
                                width: deviceWidth * 0.05,
                              ),
                              Text('© Credits, 2023, Product Arena'),
                              SizedBox(
                                width: deviceWidth * 0.05,
                              ),
                              Text('Terms & Conditions'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
