import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/constants/global_variables.dart';
import 'package:v2_product_arena/mobile/features/onboarding/widgets/form_button.dart';
import 'package:v2_product_arena/mobile/providers/answer_provider.dart';
import 'package:v2_product_arena/mobile/providers/error_message_provider.dart';

class MobileOnboardingForm extends StatefulWidget {
  final TextEditingController controller;
  final String text;
  final PageController pageController;

  const MobileOnboardingForm({
    super.key,
    required this.controller,
    required this.text,
    required this.pageController,
  });
  @override
  State<MobileOnboardingForm> createState() => _MobileOnboardingFormState();
}

class _MobileOnboardingFormState extends State<MobileOnboardingForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9E9E9),
      appBar: MyHeader(),
      body: SafeArea(
        child: SingleChildScrollView(
          key: const Key('scroll'),
          child: Padding(
            padding: EdgeInsets.only(
                left: (32 / 360) * MediaQuery.of(context).size.width,
                right: (32 / 360) * MediaQuery.of(context).size.width),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.text,
                    style: GoogleFonts.notoSans(
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w700,
                        fontSize:
                            (16 / 360) * MediaQuery.of(context).size.width),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    key: const Key('onboardingQAnsw'),
                    controller: widget.controller,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 2,
                    decoration: InputDecoration(
                        isDense: true,
                        hintText: 'Vaš odgovor',
                        hintStyle: TextStyle(
                            color: const Color(0xFF4A4458),
                            fontWeight: FontWeight.w400,
                            fontSize:
                                (14 / 360) * MediaQuery.of(context).size.width),
                        contentPadding: const EdgeInsets.only(
                          top: 10,
                          bottom: 5,
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xFF4A4458),
                          ),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 1,
                            color: Colors.black,
                          ),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                Consumer<ErrorMessage>(
                  builder: (context, error, child) {
                    return SizedBox(
                      // padding: EdgeInsets.only(left: 20.0, top: 5.0),
                      height: error.errorHeight,
                      child: Row(
                        children: <Widget>[
                          Icon(error.errorIcon,
                              size: 20.0, color: Colors.red[700]),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              error.errorText,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.red[700],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
                TextButton(
                  onPressed: () {
                    widget.controller.clear();
                  },
                  child: Text(
                    'Clear section',
                    style: GoogleFonts.notoSans(
                        color: const Color(0xFF4A4458),
                        fontWeight: FontWeight.w700,
                        fontSize:
                            (10 / 360) * MediaQuery.of(context).size.width),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.43,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 65),
                  child: Row(
                    children: [
                      FormButton(
                        backgroundColor: Colors.white,
                        text: 'Back',
                        buttonWidth:
                            (90 / 360) * MediaQuery.of(context).size.width,
                        buttonHeight: 40,
                        textColor: Colors.black,
                        borderColor: Colors.black,
                        onPressed: () {
                          widget.pageController.previousPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInBack);
                        },
                      ),
                      SizedBox(
                        width: (116 / 360) * MediaQuery.of(context).size.width,
                      ),
                      FormButton(
                          key: const Key('nextButtonForm'),
                          backgroundColor: Colors.black,
                          text: 'Next',
                          buttonWidth:
                              (90 / 360) * MediaQuery.of(context).size.width,
                          buttonHeight: 40,
                          textColor: Colors.white,
                          borderColor: Colors.black,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate() == true) {
                              context
                                  .read<AnswerProvider>()
                                  .addItem(widget.controller.text);
                              context.read<ErrorMessage>().reset();
                              widget.pageController.nextPage(
                                  duration: const Duration(milliseconds: 400),
                                  curve: Curves.easeIn);
                            } else {
                              context.read<ErrorMessage>().change();
                            }
                          }),
                    ],
                  ),
                ),
                SizedBox(
                  height: (120 / 800) * MediaQuery.of(context).size.height,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
