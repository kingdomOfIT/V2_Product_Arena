import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/web/features/onboarding/web_constansts_ob.dart';
import 'package:v2_product_arena/web/features/onboarding/widgets/web_vector_tile.dart';

class RoleBox extends StatefulWidget {
  const RoleBox({super.key});

  @override
  State<RoleBox> createState() => _RoleBoxState();
}

class _RoleBoxState extends State<RoleBox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (935 / 1440) * MediaQuery.of(context).size.width,
      child: Column(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Za koju se poziciju prijavljuješ?',
            style: GoogleFonts.notoSans(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF000000)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 20,
            top: 5,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Možeš odabrati jednu ili dvije pozicije!',
              style: GoogleFonts.notoSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF000000)),
            ),
          ),
        ),
        SizedBox(
          height: 160,
          width: (934 / 1440) * MediaQuery.of(context).size.width,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return RoleTile(
                  index: index,
                  role: listRole[index],
                  imageName: listRole[index].image,
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                    width: 28,
                  ),
              itemCount: roleText.length),
        ),
      ]),
    );
  }
}
