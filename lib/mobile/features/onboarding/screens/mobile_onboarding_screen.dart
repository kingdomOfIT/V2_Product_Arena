import 'package:flutter/material.dart';
import 'package:v2_product_arena/constants/global_variables.dart';
import 'package:v2_product_arena/mobile/features/onboarding/screens/first_question_screen.dart';
import 'package:v2_product_arena/mobile/features/onboarding/screens/select_role_screen.dart';
import 'package:v2_product_arena/mobile/features/onboarding/screens/video_screen.dart';
import 'package:v2_product_arena/mobile/features/onboarding/widgets/mobile_onboarding_form.dart';
import 'package:v2_product_arena/mobile/features/onboarding/widgets/screen_indicator.dart';
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/mobile_appbar.dart';
import 'package:v2_product_arena/mobile/reusalbe_mobile_widgets/mobile_footer.dart';

class MobileOnboardingScreen extends StatefulWidget {
  const MobileOnboardingScreen({super.key});
  static const routeName = '/mobile-onboarding';
  @override
  State<MobileOnboardingScreen> createState() => _MobileOnboardingScreenState();
}

class _MobileOnboardingScreenState extends State<MobileOnboardingScreen> {
  List<TextEditingController> controller =
      List.generate(6, (i) => TextEditingController());
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.toInt();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> questions = [
      Question1(
        pageController: _pageController,
      ),
      MobileOnboardingForm(
        controller: controller[0],
        text: textQuestions[0],
        pageController: _pageController,
      ),
      MobileOnboardingForm(
        controller: controller[1],
        text: textQuestions[1],
        pageController: _pageController,
      ),
      MobileOnboardingForm(
        controller: controller[2],
        text: textQuestions[2],
        pageController: _pageController,
      ),
      MobileOnboardingForm(
        controller: controller[3],
        text: textQuestions[3],
        pageController: _pageController,
      ),
      MobileOnboardingForm(
        controller: controller[4],
        text: textQuestions[4],
        pageController: _pageController,
      ),
      LinkVideoScreen(
          controller: controller[5], pageController: _pageController),
      SelectRoleScreen(pageController: _pageController),
    ];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
        child: const MobileAppBar(),
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: questions.length,
            itemBuilder: (BuildContext context, int index) {
              return questions[index % questions.length];
            },
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 37,
              left: (32 / 360) * MediaQuery.of(context).size.width,
              right: (31 / 360) * MediaQuery.of(context).size.width,
            ),
            child: PageIndicator(
              currentPage: _currentPage + 1,
              totalPages: 8,
              width: (30 / 360) * MediaQuery.of(context).size.width,
              height: 5,
              indicatorHeight: 40,
            ),
          ),
          //  const Positioned(bottom: 0, right: 0, left: 0, child: MobileFooter())
        ],
      ),
    );
  }
}
