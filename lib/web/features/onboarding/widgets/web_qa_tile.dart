import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/web/providers/web_ob_answers.dart';
import 'package:provider/provider.dart';
import '../../../../mobile/providers/error_message_provider.dart';
import '../web_constansts_ob.dart';

class QATile extends StatefulWidget {
  final double height;
  final String question;
  final TextEditingController controller;
  final Key formKey;
  final int i;
  const QATile({
    super.key,
    required this.i,
    required this.height,
    required this.question,
    required this.controller,
    required this.formKey,
  });

  @override
  State<QATile> createState() => _QATileState();
}

class _QATileState extends State<QATile> {
  String errorText = '';
  IconData? errorIcon;
  double errorHeight = 0;
  @override
  void initState() {
    setState(() {
      // context.read<ErrorMessage>().reset();
    });

    super.initState();
  }

  @override
  void didUpdateWidget(QATile oldWidget) {
    super.didUpdateWidget(oldWidget);
    // context.read<ErrorMessage>().reset();
  }

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
            Form(
              key: context.read<WebAnswerProvider>().formKeys[widget.i],
              child: TextFormField(
                controller: widget.controller,
                onFieldSubmitted: (value) {
                  context.read<WebAnswerProvider>().addItem(value);
                },
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
                validator: (value) {
                  context
                      .read<WebAnswerProvider>()
                      .addItem(widget.controller.text);
                  if (value!.isEmpty) {
                    setState(() {
                      errorHeight = 30;
                      errorIcon = Icons.error_rounded;
                      errorText = 'Molimo unesite odgovor!';
                    });
                    return '';
                  } else {
                    setState(() {
                      errorHeight = 0;
                      errorIcon = null;
                      errorText = '';
                    });
                    return null;
                  }
                },
              ),
            ),
            SizedBox(
              height: errorHeight,
              child: Row(
                children: <Widget>[
                  Icon(errorIcon, size: 20.0, color: Colors.red[700]),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      errorText,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.red[700],
                      ),
                    ),
                  )
                ],
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
                      context
                          .read<WebAnswerProvider>()
                          .removeItem(widget.controller.text);
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
