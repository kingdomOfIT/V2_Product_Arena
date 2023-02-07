// ignore_for_file: depend_on_referenced_packages, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:v2_product_arena/constants/global_variables.dart';

class WebFooter extends StatelessWidget {
  const WebFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
          left: deviceWidth * 0.056,
          right: deviceWidth * 0.056,
          top: deviceHeight * 0.002,
          bottom: deviceHeight * 0.038),
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/images/palogo2.png',
            width: deviceWidth * 0.035,
          ),
          SizedBox(
            height: deviceHeight * 0.033,
          ),
          const Divider(
            thickness: 1.0,
            color: Colors.black54,
          ),
          SizedBox(
            height: deviceHeight * 0.023,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: deviceWidth * 0.296,
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
                              width: deviceWidth * 0.022,
                            ),
                            SizedBox(
                              width: deviceWidth * 0.003,
                            ),
                            Flexible(
                              child: Text(
                                'Put Mladih Muslimana 2, City Gardens Residence, 71 000 Sarajevo, Bosnia and Herzegovina14425 Falconhead Blvd, Bee Cave, TX 78738, United States',
                                style: TextStyle(
                                  fontSize: deviceHeight * 0.011,
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
                            width: deviceWidth * 0.022,
                          ),
                          SizedBox(
                            width: deviceWidth * 0.003,
                          ),
                          Text(
                            'hello@tech387.com',
                            style: TextStyle(
                              fontSize: deviceHeight * 0.011,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  width: deviceWidth * 0.296,
                  padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.07),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: GlobalVariables.socialMedia
                            .map(
                              (e) => InkWell(
                                onTap: () async {
                                  await launchUrl(
                                    Uri.parse(e['url'] as String),
                                  );
                                },
                                child: Image.asset(e['image'] as String),
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(
                        height: deviceHeight * 0.014,
                      ),
                      Text(
                        '© Credits, 2023, Product Arena',
                        style: TextStyle(
                          fontSize: deviceHeight * 0.011,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    width: deviceWidth * 0.296,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'Privacy',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: deviceHeight * 0.011,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: deviceWidth * 0.02,
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'Terms',
                            style: TextStyle(
                              color: Colors.black45,
                              fontSize: deviceHeight * 0.011,
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
