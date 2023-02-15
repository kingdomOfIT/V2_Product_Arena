import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../web_constansts_ob.dart';

class QATile extends StatefulWidget {
  final double height;
  final String question;
  final TextEditingController controller;
  const QATile({
    super.key,
    required this.height,
    required this.question,
    required this.controller,
  });

  @override
  State<QATile> createState() => _QATileState();
}

class _QATileState extends State<QATile> {
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0, top: 17.0, right: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                widget.question,
                style: GoogleFonts.notoSans(
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: widget.controller,
              style: const TextStyle(
                fontSize: 14,
              ),
              decoration: const InputDecoration(
                isDense: true,
                hintText: 'Vaš odgovor',
                hintStyle: TextStyle(
                    color: Color(0xFF4A4458),
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
                contentPadding: EdgeInsets.only(top: 10, bottom: 10),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: Color(0xFF4A4458),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 17),
              child: Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: 108,
                  height: 19,
                  child: TextButton(
                    onPressed: () {
                      widget.controller.clear();
                    },
                    child: CustomText('Clear section', 14, FontWeight.w700,
                        const Color(0xFF4A4458)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
