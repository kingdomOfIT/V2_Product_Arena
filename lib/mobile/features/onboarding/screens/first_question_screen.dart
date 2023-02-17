import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/constants/global_variables.dart';
import 'package:v2_product_arena/mobile/features/onboarding/widgets/form_button.dart';
import 'package:v2_product_arena/mobile/providers/answer_provider.dart';
import 'package:v2_product_arena/mobile/providers/error_message_provider.dart';

enum Opcija {
  // ignore: constant_identifier_names
  Da,
  // ignore: constant_identifier_names
  Ne,
}

class Question1 extends StatefulWidget {
  final PageController pageController;
  const Question1({super.key, required this.pageController});

  @override
  State<Question1> createState() => _Question1State();
}

class _Question1State extends State<Question1> {
  bool da = false;
  bool ne = false;
  Opcija? _daNe;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9E9E9),
      appBar: MyHeader(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: (32 / 360) * MediaQuery.of(context).size.width,
                right: (32 / 360) * MediaQuery.of(context).size.width),
            child: Column(
              children: [
                const SizedBox(
                  height: 57,
                ),
                Text(
                  'Product Arena je full-time tromjesečna praksa, da li spreman/a učenju i radu posvetiti 8 sati svakog radnog dana?',
                  style: GoogleFonts.notoSans(
                      color: const Color(0xFF000000),
                      fontWeight: FontWeight.w400,
                      fontSize: (14 / 360) * MediaQuery.of(context).size.width),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RadioListTile(
                    key: const Key('onboardingQYes'),
                    activeColor: Colors.black,
                    tileColor: const Color(0xFFE9E9E9),
                    contentPadding: EdgeInsets.zero,
                    toggleable: true,
                    title: const Text('Da'),
                    value: Opcija.Da,
                    groupValue: _daNe,
                    onChanged: ((Opcija? value) => setState(() {
                          da = !ne;
                          _daNe = value!;
                          context.read<AnswerProvider>().removeItem('False');
                          context.read<AnswerProvider>().addItem('True');
                        })),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: RadioListTile(
                    key: const Key('onboardingQNo'),
                    contentPadding: EdgeInsets.zero,
                    activeColor: Colors.black,
                    tileColor: const Color(0xFFE9E9E9),
                    toggleable: true,
                    title: const Text('Ne'),
                    value: Opcija.Ne,
                    groupValue: _daNe,
                    onChanged: ((Opcija? value) => setState(() {
                          ne = !da;
                          _daNe = value!;
                        })),
                  ),
                ),
                Consumer<ErrorMessage>(
                  builder: (context, error, child) {
                    return SizedBox(
                      height: error.errorHeight,
                      child: Row(
                        children: <Widget>[
                          Icon(error.errorIcon,
                              size: 20.0, color: Colors.red[700]),
                          Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(error.errorText,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.red[700])))
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: (268 / 690) * MediaQuery.of(context).size.height,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: (238 / 360) * MediaQuery.of(context).size.width,
                      bottom: (65 / 775) * MediaQuery.of(context).size.height),
                  child: FormButton(
                      key: const Key('nextButtonFQ'),
                      buttonWidth:
                          (90 / 360) * MediaQuery.of(context).size.width,
                      buttonHeight: 40,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                      borderColor: Colors.black,
                      text: 'Next',
                      onPressed: () {
                        if (!da && !ne) {
                          context.read<ErrorMessage>().change();
                        } else {
                          context.read<ErrorMessage>().reset();
                          widget.pageController.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeIn);
                        }
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
