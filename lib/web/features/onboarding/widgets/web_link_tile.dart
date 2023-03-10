import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:v2_product_arena/web/providers/web_ob_answers.dart';
import 'package:provider/provider.dart';
import '../web_constansts_ob.dart';

class LinkTile extends StatelessWidget {
  final TextEditingController controller;

  const LinkTile({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (452 / 1440) * MediaQuery.of(context).size.width,
      height: 214,
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
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(children: [
          CustomText(
              'Pritisnite dugme za snimanje i predstavite se! Recite nam nešto zanimljivo o sebi ili nečemu što vas zanima.',
              14,
              FontWeight.w700),
          Padding(
            padding: const EdgeInsets.only(top: 29),
            child: Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                  'Molimo te da link staviš u box!', 14, FontWeight.bold),
            ),
          ),
          SizedBox(
            width: (404 / 1440) * MediaQuery.of(context).size.width,
            height: 34,
            child: Form(
              key: context.read<WebAnswerProvider>().formKeys[5],
              child: TextFormField(
                key: const Key('onboardingVideoTextField'),
                controller: controller,
                style: const TextStyle(
                  fontSize: 14,
                ),
                decoration: const InputDecoration(
                  hintText: 'https://',
                  hintStyle: TextStyle(color: Color(0xFF4A4458)),
                  contentPadding: EdgeInsets.only(top: 12, bottom: 5, left: 11),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF79747E), width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xFF79747E), width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                ),
                validator: (value) {
                  context.read<WebAnswerProvider>().addItem(controller.text);
                  if (value!.isEmpty) {
                    return null;
                  } else {
                    return null;
                  }
                },
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: CustomText('Za učitavanje videa koristi file.io', 10),
          // ),
          Row(
            children: [
              Text(
                'Za učitavanje videa koristi ',
                style: GoogleFonts.notoSans(
                  fontSize: (10 / 800) * MediaQuery.of(context).size.height,
                  color: const Color(0xFF605D66),
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
                    //decoration: TextDecoration.underline,
                    fontSize: (10 / 800) * MediaQuery.of(context).size.height,
                    color: const Color(0xFF605D66),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
