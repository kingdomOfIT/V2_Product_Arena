import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:v2_product_arena/main.dart';
import 'package:v2_product_arena/web/providers/web_ob_answers.dart';
import 'package:v2_product_arena/web/providers/web_ob_role.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_ob_appbar.dart';
import '../../../reusable_web_widgets/web_footer.dart';
import '../web_constansts_ob.dart';
import '../widgets/video_tile.dart';
import '../widgets/web_custom_button.dart';
import '../widgets/web_link_tile.dart';
import '../widgets/web_options_tile.dart';
import '../widgets/web_qa_tile.dart';
import '../widgets/web_role_bar.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:v2_product_arena/amplifyconfiguration.dart';
import 'package:provider/provider.dart';

class WebOnboardingView extends StatefulWidget {
  const WebOnboardingView({super.key});
  static const routeName = '/web_onboarding_view';

  @override
  State<WebOnboardingView> createState() => _WebOnboardingViewState();
}

class _WebOnboardingViewState extends State<WebOnboardingView>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    // Add any Amplify plugins you want to use
    final authPlugin = AmplifyAuthCognito();
    final api = AmplifyAPI();
    await Amplify.addPlugins([authPlugin, api]);
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      safePrint(
          'Tried to reconfigure Amplify; this can occur when your app restarts on Android.');
    }
  }

  Future<void> signInUser() async {
    await _configureAmplify();
    try {
      final result = await Amplify.Auth.signIn(
        username: "mkaric@pa.tech387.com", // email of user
        password: "Pass123!",
      );

      print('LOGINOVO SE');
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
            "roles": ['fullstack', 'backend'],
            "answers": {
              // answers are in the same order as questions, null if not answered
              "0": "True",
              "1": "apple",
              "2": "orange",
              "3": "banana",
              "4": null,
              "5": "sample",
              "6": "answer",
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

  late AnimationController _controller;
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
    List<String> s1 = context.read<Role>().selctRole;
    List<String> s2 = context.read<AnswerProvider>().answ;
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
                        height: 11,
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
                      const SizedBox(height: 4),
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
                      const OptionsTile(),
                      const SizedBox(
                        height: 37,
                      ),
                      SizedBox(
                        width: maxWidth * 0.6486,
                        height: 859,
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return QATile(
                                height: tileHeights[index],
                                question: tileQuestions[index],
                                controller: controllers[index],
                                formKey: globalKey[index],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(
                                      height: 34,
                                    ),
                            itemCount: tileHeights.length),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                            // print(s1);
                            // int i;
                            // for (i = 1; i < 7; i++) {
                            //   if (context
                            //       .read<AnswerProvider>()
                            //       .answ[i]
                            //       .isEmpty) {
                            //     consumer[i] = true;
                            //   }
                            // }
                            // submitOnboarding(s1, s2);
                          }),
                          SizedBox(
                            height: 60,
                            width: (190 / 1440) * maxWidth - 1,
                            child: TextButton(
                              onPressed: () {
                                int i;
                                for (i = 0; i < controllers.length; i++) {
                                  controllers[i].clear();
                                }
                              },
                              child: Center(
                                child: Text(
                                  'Clear selection',
                                  style: GoogleFonts.notoSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF000000)),
                                ),
                              ),
                            ),
                          ),
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
