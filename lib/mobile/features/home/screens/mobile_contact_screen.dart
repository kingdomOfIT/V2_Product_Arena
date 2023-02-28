import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:v2_product_arena/mobile/features/lectures/screens/hello_screen.dart';
import 'package:v2_product_arena/mobile/features/lectures/widgets/lectures_appbar.dart';
import 'package:v2_product_arena/mobile/providers/mobile_auth_provider.dart';
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/mobile_footer.dart';

class MobileContactUs extends StatefulWidget {
  static const routeName = '/mobile-contact-us';
  const MobileContactUs({super.key});

  @override
  State<MobileContactUs> createState() => _MobileContactUsState();
}

bool isContactFormSent = false;

class _MobileContactUsState extends State<MobileContactUs> {
  final formKey = GlobalKey<FormState>();
  final contactUsController = TextEditingController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    final dataProvider = Provider.of<MobileAuth>(context);
    dataProvider.scaffoldKey;
    return Scaffold(
      appBar: AppBar(
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
          GestureDetector(
            onTap: () {
              dataProvider.isSidebarOpened3
                  ? _key.currentState!.closeEndDrawer()
                  : _key.currentState!.openEndDrawer();
              dataProvider.changeSidebar3();
            },
            child: dataProvider.isSidebarOpened3
                ? const Icon(Icons.close)
                : const Icon(Icons.menu),
          ),
        ],
      ),
      body: Scaffold(
        key: _key,
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: deviceWidth * (30 / 360),
                  right: deviceWidth * (30 / 360),
                  top: deviceHeight * (24 / 800)),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/contact us.png",
                        height: deviceHeight * (27 / 803),
                        width: deviceWidth * (27 / 360),
                      ),
                      SizedBox(
                        width: deviceWidth * (10 / 360),
                      ),
                      Text(
                        "Contact us!",
                        style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w700,
                          fontSize: deviceHeight * (16 / 803),
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: deviceHeight * (24 / 800),
                  ),
                  SizedBox(
                    width: double.infinity,
                    // height: deviceHeight * (300 / 800),
                    child: Form(
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
                          hintText: 'Leave us a message!',
                          hintStyle: GoogleFonts.notoSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF22E974),
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        style: GoogleFonts.notoSans(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isContactFormSent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Thank you for contacting us! We have received your message and will get back to you as soon as possible.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF22E974),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * (25 / 800),
                  ),
                  Container(
                    height: deviceHeight * (34 / 803),
                    width: deviceWidth * (94 / 360),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black87,
                          side: const BorderSide(
                            color: Color(0xFFFFFFFF),
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(deviceWidth * (3 / 360)),
                          )),
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
                                fontSize: deviceHeight * (14 / 803),
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.normal,
                                color: const Color(0xFFFFFFFF)),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            final restOperation = Amplify.API.post(
                              'api/user/form',
                              apiName: 'sendFormEmailAlfa',
                              body: HttpPayload.json(
                                {
                                  'question':
                                      contactUsController.text.toString(),
                                },
                              ),
                            );
                            final response = await restOperation.response;
                            safePrint('POST call succeeded');
                            safePrint(response.decodeBody());
                          } on ApiException catch (e) {
                            safePrint('POST call failed: ${e.message}');
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * (60 / 800),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: deviceWidth * (5 / 360)),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Image.asset(
                            'assets/images/whitemail.png',
                          ),
                        ),
                        SizedBox(
                          width: deviceWidth * (23 / 800),
                        ),
                        Text(
                          'hello@tech387.com',
                          style: GoogleFonts.notoSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * (10 / 800),
                  ),
                  InkWell(
                    onTap: () async {
                      await launchUrl(Uri.parse(
                          'https://www.google.ba/maps/place/Tech387/@43.8538483,18.4205947,17z/data=!3m1!4b1!4m6!3m5!1s0x4758c903ae6b4fe1:0xa4116c0159094813!8m2!3d43.8538483!4d18.4227834!16s%2Fg%2F11h_6q3_47'));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          'assets/images/whitepin.png',
                          height: deviceHeight * (25 / 800),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Text(
                            'Put Mladih Muslimana 2, City Gardens Residence, 71 000 Sarajevo, Bosnia and Herzegovina\n \n14425 Falconhead Blvd, Bee Cave, TX 78738, United States',
                            style: GoogleFonts.notoSans(
                                fontSize: 14, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const MobileFooter(),
          ],
        ),
      ),
    );
  }
}
