import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/mobile/providers/role_provider.dart';

class RoleTile extends StatefulWidget {
  Role role;

  final int index;
  final String imageName;
  RoleTile({
    super.key,
    required this.role,
    required this.index,
    required this.imageName,
  });

  @override
  State<RoleTile> createState() => _RoleTileState();
}

class _RoleTileState extends State<RoleTile> {
  // void didUpdateWidget(RoleTile oldWidget) {
  //   int i = widget.index + 1;
  //   super.didUpdateWidget(oldWidget);
  //   context.read<Role>().initialize('assets/images/rolevectorblack$i.png');
  // }

  //dodat consumer za error
  @override
  Widget build(BuildContext context) {
    int i = widget.index + 1;
    return Column(
      children: [
        InkWell(
          onTap: () {
            if (context.read<Role>().hasRole(widget.role)) {
              context.read<Role>().removeItem(widget.role);
              setState(() {
                context
                    .read<Role>()
                    .initialize('assets/images/rolevectorblack$i.png');
              });
            } else {
              context.read<Role>().addItem(widget.role);
              setState(() {
                context
                    .read<Role>()
                    .change('assets/images/rolevectorwhite$i.png');
              });
            }
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 15),
            width: (296 / 360) * MediaQuery.of(context).size.width,
            height: 56,
            decoration: BoxDecoration(
              color: context.read<Role>().bck,
              border: Border.all(width: 1, color: const Color(0xFF322F37)),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Row(
                children: [
                  SizedBox(
                    height: (25 / 360) * MediaQuery.of(context).size.width,
                    width: (25 / 360) * MediaQuery.of(context).size.width,
                    child: context.read<Role>().hasRole(widget.role)
                        ? Image.asset(context.read<Role>().img)
                        : Image.asset(widget.imageName),
                  ),
                  SizedBox(
                    width: (15 / 360) * MediaQuery.of(context).size.width,
                  ),
                  Center(
                    child: Text(
                      widget.role.name['forFrontend']!,
                      style: GoogleFonts.notoSans(
                          fontSize:
                              (20 / 690) * MediaQuery.of(context).size.width,
                          fontWeight: FontWeight.w500,
                          color: context.read<Role>().txt),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
