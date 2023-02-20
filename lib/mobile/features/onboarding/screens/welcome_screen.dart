import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/mobile/features/onboarding/screens/mobile_onboarding_screen.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});
  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 278, bottom: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Dobrodošli!',
                  style: GoogleFonts.notoSans(
                      fontSize: (32 / 360) * maxWidth,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFFFFFFF)),
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Pred Vama je mali upitnik, koji je\n',
                    style: GoogleFonts.notoSans(
                        fontSize: (16 / 360) * maxWidth,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFFFFFFFF)),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'neophodno popuniti kako bi\n',
                        style: GoogleFonts.notoSans(
                            fontSize: (16 / 360) * maxWidth,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFFFFFFFF)),
                      ),
                      TextSpan(
                        text: ' nastavili dalje.',
                        style: GoogleFonts.notoSans(
                            fontSize: (16 / 360) * maxWidth,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFFFFFFFF)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 232,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: (70 / 360) * maxWidth,
                      right: (36 / 360) * maxWidth),
                  child: Row(
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text:
                              'Ne zaboravite da odvojite vrijeme i pažljivo\n',
                          style: GoogleFonts.notoSans(
                              fontSize: (10 / 360) * maxWidth,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFFFFFFFF)),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'pročitajte svako pitanje. Sretno!',
                              style: GoogleFonts.notoSans(
                                  fontSize: (10 / 360) * maxWidth,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFFFFFFFF)),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        key: const Key('onboardingFormRed'),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(MobileOnboardingScreen.routeName);
                        },
                        icon: Icon(Icons.arrow_forward,
                            size: (20 / 360) * maxWidth,
                            color: const Color(0xFF22E974)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
