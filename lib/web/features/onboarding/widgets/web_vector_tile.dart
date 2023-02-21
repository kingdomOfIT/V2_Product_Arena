import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/web/features/onboarding/web_constansts_ob.dart';

import '../../../providers/web_ob_role.dart';

// ignore: must_be_immutable
class RoleTile extends StatefulWidget {
  WebRole role;

  final int index;
  final String imageName;
  RoleTile(
      {super.key,
      required this.role,
      required this.index,
      required this.imageName});

  @override
  State<RoleTile> createState() => _RoleTileState();
}

class _RoleTileState extends State<RoleTile> {
  //dodat consumer za error
  @override
  Widget build(BuildContext context) {
    int i = widget.index + 1;
    return GestureDetector(
      onTap: () {
        if (context.read<WebRole>().hasRole(widget.role)) {
          context.read<WebRole>().removeItem(widget.role);

          setState(() {
            context
                .read<WebRole>()
                .initialize('assets/images/rolevectorblack$i.png');
          });
        } else {
          context.read<WebRole>().addItem(widget.role);

          setState(() {
            context
                .read<WebRole>()
                .change('assets/images/rolevectorwhite$i.png');
          });
        }
      },
      child: Container(
        width: (160 / 1440) * MediaQuery.of(context).size.width,
        height: (160 / 1440) * MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: context.read<WebRole>().bck,
          border:
              Border.all(width: 1, color: const Color.fromRGBO(50, 47, 55, 1)),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 50, left: 12, right: 12, bottom: 10),
              child: SizedBox(
                height: (35 / 1440) * MediaQuery.of(context).size.width,
                width: (35 / 140) * MediaQuery.of(context).size.width,
                child: context.read<WebRole>().hasRole(widget.role)
                    ? Image.asset(listRoleSel[widget.index].image)
                    : Image.asset(widget.imageName),
              ),
            ),
            Center(
              child: Text(
                widget.role.name['forFrontend']!,
                style: GoogleFonts.notoSans(
                    fontSize: (14 / 1440) * MediaQuery.of(context).size.width,
                    fontWeight: FontWeight.w700,
                    color: context.read<WebRole>().txt),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
