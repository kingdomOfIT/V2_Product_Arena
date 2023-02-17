// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:v2_product_arena/web/features/onboarding/screens/web_congratulations_screen.dart';
import 'package:v2_product_arena/web/providers/web_ob_answers.dart';
import 'package:v2_product_arena/web/providers/web_ob_role.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_ob_appbar.dart';
import '../../../providers/web_auth_provider.dart';
import '../../../providers/web_ob_error.dart';
import '../../../reusable_web_widgets/web_footer.dart';
import '../web_constansts_ob.dart';
import '../widgets/video_tile.dart';
import '../widgets/web_custom_button.dart';
import '../widgets/web_link_tile.dart';
import '../widgets/web_options_tile.dart';
import '../widgets/web_qa_tile.dart';
import '../widgets/web_role_bar.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:provider/provider.dart';

class WebOnboardingView extends StatefulWidget {
  const WebOnboardingView({super.key});
  static const routeName = '/web-onboarding-view';

  @override
  State<WebOnboardingView> createState() => _WebOnboardingViewState();
}

class _WebOnboardingViewState extends State<WebOnboardingView>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
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
        username: Provider.of<WebAuth>(context, listen: false)
            .userEmail, // email of user
        password: Provider.of<WebAuth>(context, listen: false).userPassword,
      );
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
    //final isValid = _formKey.currentState!.validate();
    await signInUser();

    try {
      final restOperation = Amplify.API.post("/api/onboarding/submit",
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
          apiName: "userDataInitAlfa");
      final response = await restOperation.response;
      Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());
      print('POST call succeeded');
      print(responseMap['lectures']);
    } on ApiException catch (e) {
      print('POST call failed: $e');
    }
  }

  TextEditingController linkController = TextEditingController();
  List<TextEditingController> controllers =
      List.generate(6, (i) => TextEditingController());
  static const List<Key> globalKey = [
    Key('prvi'),
    Key('drugi'),
    Key('treci'),
    Key('cetvrti'),
    Key('peti'),
    Key('sesti')
  ];

  void sendData() {
    setState(() {
      Navigator.of(context).pushNamed(WebOnboardingView.routeName);
    });
  }

/*
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
*/
  @override
  Widget build(BuildContext context) {
    List<String> s1 = context.read<WebRole>().selctRole;
    List<String> s2 = context.read<WebAnswerProvider>().answ;

    double maxWidth = MediaQuery.of(context).size.width;
    double maxHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // List<String> finalRoles=context.read<Role>().selctdRoles;
      backgroundColor: const Color(0xFFE9E9E9),
      appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
          child: WebOBAppBar(text: 'Tech387')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: 72, left: (252 / 1440) * maxWidth),
                width: maxWidth,
                height: 160,
                decoration: const BoxDecoration(
                  color: Color(0xFF000000),
                ),
                child: SizedBox(
                  width: maxWidth * 0.1902,
                  height: 65,
                  child: CustomText('Dobrodošli!', 48, FontWeight.w700,
                      const Color(0xFFFFFFFF)),
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: maxWidth * 0.1757,
                      right: 0.1757 * maxWidth,
                      bottom: 202),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 54,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: 44,
                          child: CustomText('Upitnik', 32, FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: 22,
                          child: CustomText(
                              'Ne zaboravite da odvojite vrijeme i pažljivo pročitajte svako pitanje. Sretno!',
                              16,
                              FontWeight.w700),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: 22,
                          child: CustomText(
                              'Molimo vas da popunite dole potrebne podatke:',
                              16,
                              FontWeight.w400),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const OptionsTile(),
                      const SizedBox(
                        height: 37,
                      ),
                      SizedBox(
                        width: maxWidth * 0.6486,
                        // height:
                        //     (859 / 1080) * MediaQuery.of(context).size.width,
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return QATile(
                                height: tileHeights[index],
                                question: tileQuestions[index],
                                controller: controllers[index],
                                formKey: globalKey[index],
                                i: index,
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                                      height: 34,
                                    ),
                            itemCount: tileHeights.length),
                      ),
                      const SizedBox(
                        height: 34,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 1,
                            child: VideoTile(),
                          ),
                          SizedBox(
                            width: (24 / 1440) * maxWidth,
                          ),
                          Flexible(
                            flex: 1,
                            child: LinkTile(
                              controller: linkController,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 45,
                      ),
                      const RoleBox(),
                      const SizedBox(height: 35),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomButton(onPressed: () {
                            int i, j;
                            int count = 0;

                            for (i = 0; i < 6; i++) {
                              if (context
                                  .read<WebAnswerProvider>()
                                  .formKeys[i]
                                  .currentState!
                                  .validate()) {
                                if (i != 5) {
                                  count++;
                                }
                              }
                            }
                            // print(s1);

                            // print(s2);
                            // print(s2.length);
                            // print(count);
                            // print(context.read<WebRole>().length);
                            // print(context.read<WebAnswerProvider>().da);
                            // print(context.read<WebAnswerProvider>().ne);

                            if (count == 5 &&
                                (context.read<WebRole>().length == 2 ||
                                    context.read<WebRole>().length == 1) &&
                                (context.read<WebAnswerProvider>().da == true ||
                                    context.read<WebAnswerProvider>().ne ==
                                        true)) {
                              submitOnboarding(s1, s2);
                              Navigator.of(context).pushNamed(
                                  WebCongratulationsScreen.routeName);
                            }
                            if (!(context.read<WebAnswerProvider>().da ==
                                    true ||
                                context.read<WebAnswerProvider>().ne == true)) {
                              context
                                  .read<WebErrorMessage>()
                                  .changeFirstErrorHeight();
                              context.read<WebErrorMessage>().change();
                            } else {
                              context
                                  .read<WebErrorMessage>()
                                  .resetFirstErrorHeight();
                              context.read<WebErrorMessage>().reset();
                            }
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const WebFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
