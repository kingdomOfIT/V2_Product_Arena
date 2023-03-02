import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/mobile/providers/error_message_provider.dart';

class RoleTileLectures extends StatefulWidget {
  final String roleName;
  final String roleImage;
  final Color color;

  const RoleTileLectures({
    super.key,
    required this.roleName,
    required this.roleImage,
    required this.color,
  });

  @override
  State<RoleTileLectures> createState() => _RoleTileLecturesState();
}

class _RoleTileLecturesState extends State<RoleTileLectures> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ErrorMessage>(
      builder: ((context, value, child) {
        return SizedBox(
          width: (280 / 360) * MediaQuery.of(context).size.width,
          height: 56,
          child: Row(
            children: [
              SizedBox(
                height: (24 / 803) * MediaQuery.of(context).size.height,
                width: (24 / 360) * MediaQuery.of(context).size.width,
                child: Image.asset(widget.roleImage),
              ),
              SizedBox(
                width: (8 / 360) * MediaQuery.of(context).size.width,
              ),
              Text(
                widget.roleName,
                style: GoogleFonts.notoSans(
                  color: widget.color,
                  fontSize: (16 / 803) * MediaQuery.of(context).size.height,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
