import 'package:flutter/material.dart';
import 'package:v2_product_arena/web/providers/web_ob_answers.dart';
import 'package:provider/provider.dart';
import '../web_constansts_ob.dart';

class LinkTile extends StatelessWidget {
  final TextEditingController controller;

  const LinkTile({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    RegExp videohttp = RegExp(
        r'(?:http:\/\/|https:\/\/)?(?:www\.)?(?:youtube\.com|youtu\.be|vimeo\.com)\/(?:watch\?v=)?([a-zA-Z0-9_-]{11}|[0-9]+)|(?:http:\/\/|https:\/\/)?(?:www\.)?file\.io\/[a-zA-Z0-9]+');
    return Container(
      width: 452,
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
            padding: const EdgeInsets.only(top: 25, bottom: 7),
            child: Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                  'Molimo te da link staviš u box!', 14, FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 404,
            height: 34,
            child: Form(
              key: context.read<WebAnswerProvider>().formKeys[5],
              child: TextFormField(
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
                  if (value!.isEmpty || value.isNotEmpty) return null;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: CustomText('Za učitavanje videa koristi file.io', 10),
            ),
          ),
        ]),
      ),
    );
  }
}
