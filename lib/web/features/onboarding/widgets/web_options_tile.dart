import 'package:flutter/material.dart';
import 'package:v2_product_arena/web/providers/web_ob_answers.dart';
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
  bool da = true;
  bool ne = false;
  Opcija _daNe = Opcija.Da;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Container(
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
            child: Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Radio(
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return const Color(0xFF000000);
                      }
                      return const Color(0xFF000000);
                    }),
                    value: Opcija.Da,
                    groupValue: _daNe,
                    onChanged: ((Opcija? value) => setState(() {
                          da = !ne;
                          context.read<AnswerProvider>().removeItem('False');
                          context.read<AnswerProvider>().addItem('True');

                          _daNe = value!;
                        })),
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                CustomText(
                  'Da',
                  14,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 16, left: 14),
            child: Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Radio(
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return const Color(0xFF000000);
                      }
                      return const Color(0xFF000000);
                    }),
                    value: Opcija.Ne,
                    groupValue: _daNe,
                    onChanged: ((Opcija? value) => setState(() {
                          ne = !da;

                          _daNe = value!;
                        })),
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                CustomText(
                  'Ne',
                  14,
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
