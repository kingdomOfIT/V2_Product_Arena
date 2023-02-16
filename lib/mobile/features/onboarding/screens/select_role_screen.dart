import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:provider/provider.dart';
import 'package:v2_product_arena/constants/global_variables.dart';
import 'package:v2_product_arena/mobile/features/onboarding/screens/mobile_verified_onboarding_screen.dart';
import 'package:v2_product_arena/mobile/features/onboarding/widgets/role_tile.dart';
import 'package:v2_product_arena/mobile/providers/answer_provider.dart';
import 'package:v2_product_arena/mobile/providers/error_message_provider.dart';
import 'package:v2_product_arena/mobile/providers/mobile_auth_provider.dart';
import 'package:v2_product_arena/mobile/providers/role_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/custom_button.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:provider/provider.dart';

class SelectRoleScreen extends StatefulWidget {
  final PageController pageController;
  const SelectRoleScreen({super.key, required this.pageController});

  @override
  State<SelectRoleScreen> createState() => _SelectRoleScreenState();
}

class _SelectRoleScreenState extends State<SelectRoleScreen> {
  @override
  void initState() {
    super.initState();
    // _configureAmplify();
  }

  // Future<void> _configureAmplify() async {
  //   // Add any Amplify plugins you want to use
  //   final authPlugin = AmplifyAuthCognito();
  //   final api = AmplifyAPI();
  //   await Amplify.addPlugins([authPlugin, api]);
  //   try {
  //     await Amplify.configure(amplifyconfig);
  //   } on AmplifyAlreadyConfiguredException {
  //     safePrint(
  //         'Tried to reconfigure Amplify; this can occur when your app restarts on Android.');
  //   }
  // }

  Future<void> signInUser() async {
    // await _configureAmplify();
    try {
      final result = await Amplify.Auth.signIn(
        username: Provider.of<MobileAuth>(context, listen: false)
            .userEmail, // email of user
        password: Provider.of<MobileAuth>(context, listen: false).userPassword,
      );

      print('LOGINOVO SE');
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

  Future<void> submitOnboarding(List<String> s1, List<String> s2) async {
    await signInUser();
    setState(() {
      isLoading = true;
    });
    try {
      final restOperation = Amplify.API.post(
        "/api/onboarding/submit",
        body: HttpPayload.json({
          "date": "Feb2023",
          "roles": s1,
          "answers": {
            // answers are in the same order as questions, null if not answered
            "0": s2[0],
            "1": s2[1],
            "2": s2[2],
            "3": s2[3],
            "4": s2[4],
            "5": s2[5],
            "6": s2[6],
          },
        }),
        apiName: "userDataInitAlfa",
      );
      final response = await restOperation.response;
      Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());
      print('POST call succeeded');
      Navigator.of(context)
          .pushReplacementNamed(MobileVerifiedOnboardingScreen.routeName);
      print(responseMap['lectures']);
    } on ApiException catch (e) {
      print('POST call failed: $e');
    }
    setState(() {
      isLoading = false;
    });
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    List<String> finalRoles = context.read<Role>().selctRole;

    List<String> finalAnswers = context.read<AnswerProvider>().answ;

    return Scaffold(
      appBar: MyHeader(),
      backgroundColor: const Color(0xFFE9E9E9),
      body: isLoading
          ? const Center(
              child: SpinKitRing(
                color: Color.fromRGBO(34, 233, 116, 1),
                size: 90.0,
                lineWidth: 10.0,
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    left: (32 / 360) * MediaQuery.of(context).size.width,
                    right: (32 / 360) * MediaQuery.of(context).size.width),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    Text(
                      'Za koju poziciju se prijavljuješ?',
                      style: GoogleFonts.notoSans(
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.w700,
                          fontSize:
                              (16 / 360) * MediaQuery.of(context).size.width),
                    ),
                    Text(
                      'Možeš odabrati jednu ili dvije pozicije!',
                      style: GoogleFonts.notoSans(
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.w400,
                          fontSize:
                              (14 / 360) * MediaQuery.of(context).size.width),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      height: 500,
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return RoleTile(
                            index: index,
                            role: listRole[index],
                            imageName: listRole[index].image,
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          height: 10,
                        ),
                        itemCount: listRole.length,
                      ),
                    ),
                    Consumer<ErrorMessage>(
                      builder: (context, error, child) {
                        return Container(
                          //padding: EdgeInsets.only(left: 20.0, top: 5.0),
                          height: error.errorHeight,
                          child: Row(
                            children: <Widget>[
                              Icon(error.errorIcon,
                                  size: 20.0, color: Colors.red[700]),
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
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
                    CustomButton(
                      content: Text(
                        'Submit',
                        style: GoogleFonts.notoSans(
                          fontSize: MediaQuery.of(context).size.height * 0.0175,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      buttonFunction: () {
                        if (context.read<Role>().length > 2 ||
                            context.read<Role>().length == 0) {
                          context.read<ErrorMessage>().change();
                        } else {
                          submitOnboarding(finalRoles, finalAnswers);
                        }

                        print(
                            Provider.of<AnswerProvider>(context, listen: false)
                                .answ);
                        print(Provider.of<Role>(context, listen: false)
                            .selctRole);
                      },
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
