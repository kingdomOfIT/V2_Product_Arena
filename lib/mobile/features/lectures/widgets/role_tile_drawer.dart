import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/mobile/features/lectures/screens/welcome_lectures_screen.dart';

class RoleTileLectures extends StatefulWidget {
  final String roleName;
  final String roleImage;

  const RoleTileLectures({
    super.key,
    required this.roleName,
    required this.roleImage,
  });

  @override
  State<RoleTileLectures> createState() => _RoleTileLecturesState();
}

class _RoleTileLecturesState extends State<RoleTileLectures> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        width: (280 / 360) * MediaQuery.of(context).size.width,
        height: 50,
        child: Row(
          children: [
            SizedBox(
              height: (24 / 360) * MediaQuery.of(context).size.width,
              width: (24 / 360) * MediaQuery.of(context).size.width,
              child: Image.asset(widget.roleImage),
            ),
            Text(
              widget.roleName,
              style: GoogleFonts.notoSans(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WelcomeLecturesScreen(
                    role: widget.roleName,
                  )),
        );
      },
    );
  }
}
