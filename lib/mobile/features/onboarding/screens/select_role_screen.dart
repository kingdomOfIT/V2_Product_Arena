import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:provider/provider.dart';
import 'package:v2_product_arena/amplifyconfiguration.dart';
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
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/mobile_footer.dart';

class SelectRoleScreen extends StatefulWidget {
  final PageController pageController;
  const SelectRoleScreen({super.key, required this.pageController});

  @override
  State<SelectRoleScreen> createState() => _SelectRoleScreenState();
}

class _SelectRoleScreenState extends State<SelectRoleScreen> {
  List<String> roles = [];

  Future<void> signInUser() async {
    try {
      await Amplify.Auth.signIn(
        username: Provider.of<MobileAuth>(context, listen: false)
            .userEmail, // email of user
        password: Provider.of<MobileAuth>(context, listen: false).userPassword,
      );
      print('loginovo se');
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

  Future<void> signOutUser() async {
    try {
      final res = await Amplify.Auth.signOut();
      print(res);
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
          "date": "Jan2023",
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
      // await restOperation.response;
      // Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());
      // ignore: use_build_context_synchronously
      // final restOperation2 = Amplify.API.get('/api/user/lectures',
      //     apiName: 'getLecturesAlfa',
      //     queryParameters: {
      //       'paDate': 'Feb2023'
      //       // , 'name': 'Flutter widgets'
      //     });
      // final response = await restOperation2.response;
      // Map<String, dynamic> responseMap2 = jsonDecode(response.decodeBody());
      // // mapa1 = responseMap;

      // List temp = [];
      // responseMap2['lectures'].forEach((lecture) {
      //   temp.addAll(lecture['roles']);
      // });
      // Set<String> set = Set<String>.from(temp);
      // List<String> roles = set.toList();
      // print(roles);

      Navigator.of(context)
          .pushReplacementNamed(MobileVerifiedOnboardingScreen.routeName);
      // print(responseMap['lectures']);
    } on ApiException catch (e) {
      safePrint(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  // Future<Map<String, dynamic>> getUserLectures(
  //     Map<String, dynamic> mapa1) async {
  //   await signOutUser();
  //   setState(() {
  //     isLoading = true;
  //   });
  //   await signInUser();

  //   try {
  //     final restOperation = Amplify.API.get('/api/user/lectures',
  //         apiName: 'getLecturesAlfa',
  //         queryParameters: {
  //           'paDate': 'Feb2023'
  //           // , 'name': 'Flutter widgets'
  //         });
  //     final response = await restOperation.response;
  //     Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());
  //     mapa1 = responseMap;
  //     List temp = [];
  //     responseMap['lectures'].forEach((lecture) {
  //       temp.addAll(lecture['roles']);
  //     });
  //     Set<String> set = Set<String>.from(temp);
  //     List<String> roles = set.toList();
  //     //print(roles);
  //     final restOperation2 = Amplify.API.get('/api/lectures/order',
  //         apiName: 'getLecturesOrder',
  //         queryParameters: {
  //           'paDate': 'Feb2023'
  //           // , 'name': 'Flutter widgets'
  //         });
  //     final response2 = await restOperation2.response;
  //     Map<String, dynamic> orders =
  //         jsonDecode(response2.decodeBody())['lectureOrders'];
  //     // print(orders);
  //     Map<String, dynamic> lectures = {};
  //     roles.forEach((role) {
  //       lectures[role] = List<dynamic>.filled(
  //           (orders[role] as Map<String, dynamic>).length, 0);
  //     });
  //     responseMap['lectures'].forEach((lecture) {
  //       lecture['roles'].forEach((role) {
  //         //print(orders[role][lecture['name']]);
  //         lectures[role][orders[role][lecture['name']]] = lecture;
  //       });
  //     });
  //     print(lectures['fullstack']);
  //     // print('GET call succeeded: ${responseMap['lectures']}');
  //   } on ApiException catch (e) {
  //     print('GET call failed: $e');
  //   }
  //   return mapa1;
  // }

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
              key: const Key('testScroll'),
              child: Padding(
                padding: EdgeInsets.only(
                  left: (32 / 360) * MediaQuery.of(context).size.width,
                  right: (32 / 360) * MediaQuery.of(context).size.width,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: (60 / 800) * MediaQuery.of(context).size.height,
                    ),
                    Text(
                      'Za koju poziciju se prijavljuješ?',
                      style: GoogleFonts.notoSans(
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w700,
                          fontSize:
                              (16 / 360) * MediaQuery.of(context).size.width),
                    ),
                    Text(
                      'Možeš odabrati jednu ili dvije pozicije!',
                      style: GoogleFonts.notoSans(
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w400,
                          fontSize:
                              (14 / 360) * MediaQuery.of(context).size.width),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: ListView.separated(
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
                          height: 10,
                        ),
                        itemCount: listRole.length,
                      ),
                    ),
                    Consumer<ErrorMessage>(
                      builder: (context, error, child) {
                        return SizedBox(
                          //padding: EdgeInsets.only(left: 20.0, top: 5.0),
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
                    CustomButton(
                      key: const Key('submitOnboarding'),
                      content: Text(
                        'Submit',
                        style: GoogleFonts.notoSans(
                          fontSize: MediaQuery.of(context).size.height * 0.0175,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      buttonFunction: () {
                        if (context.read<Role>().length > 2) {
                          context.read<ErrorMessage>().change2();
                        } else if (context.read<Role>().length == 0) {
                          context.read<ErrorMessage>().change();
                        } else {
                          submitOnboarding(finalRoles, finalAnswers);
                          Provider.of<MobileAuth>(context, listen: false)
                              .signOutCurrentUser(context);
                        }

                        safePrint(
                            Provider.of<AnswerProvider>(context, listen: false)
                                .answ);
                        safePrint(Provider.of<Role>(context, listen: false)
                            .selctRole);
                      },
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 120,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
