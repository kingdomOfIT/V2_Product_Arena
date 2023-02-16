import 'package:flutter/material.dart';
import 'package:v2_product_arena/web/providers/web_ob_answers.dart';
import 'package:v2_product_arena/web/providers/web_ob_error.dart';
import '../../../../mobile/providers/error_message_provider.dart';
import '../web_constansts_ob.dart';
import 'package:provider/provider.dart';

enum Opcija {
  Da,
  Ne,
}

class OptionsTile extends StatefulWidget {
  const OptionsTile({super.key});

  @override
  State<OptionsTile> createState() => _OptionsTileState();
}

class _OptionsTileState extends State<OptionsTile> {
  String errorText = '';
  IconData? errorIcon;
  double errorHeight = 0;
  bool da = false;
  bool ne = false;
  Opcija? _daNe;

  @override
  void initState() {
    setState(() {
      //context.read<WebErrorMessage>().reset();
    });

    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (935 / 1440) * MediaQuery.of(context).size.width,
      height: 300,
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
      padding: const EdgeInsets.only(left: 24, top: 17, right: 56),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomText(
          'Product Arena je full-time tromjesečna praksa, da li spreman/a učenju i radu posvetiti 8 sati svakog radnog dana?',
          14,
          FontWeight.w400,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 11, bottom: 8, left: 14),
          child: RadioListTile(
            key: const Key('onboardingWebQYes'),
            contentPadding: EdgeInsets.zero,
            activeColor: Colors.black,
            tileColor: const Color(0xFFE9E9E9),
            title: const Text('Da'),
            value: Opcija.Da,
            groupValue: _daNe,
            onChanged: ((Opcija? value) => setState(() {
                  da = !ne;
                  context.read<WebAnswerProvider>().removeItem('False');
                  context.read<WebAnswerProvider>().addItem('True');
                  context.read<WebAnswerProvider>().changeFirst(da);
                  _daNe = value!;
                })),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 16, left: 14),
          child: RadioListTile(
            contentPadding: EdgeInsets.zero,
            activeColor: Colors.black,
            tileColor: const Color(0xFFE9E9E9),
            title: const Text('Ne'),
            value: Opcija.Ne,
            groupValue: _daNe,
            onChanged: ((Opcija? value) => setState(() {
                  ne = !da;
                  context.read<WebAnswerProvider>().changeFirst(ne);
                  _daNe = value!;
                })),
          ),
        ),
        Consumer<WebErrorMessage>(
          builder: (context, error, child) {
            return SizedBox(
              height: error.errorHeight,
              child: Row(
                children: <Widget>[
                  Icon(error.errorIcon, size: 20.0, color: Colors.red[700]),
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
      ]),
    );
  }
}
