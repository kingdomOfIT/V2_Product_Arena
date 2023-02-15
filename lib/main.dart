// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:v2_product_arena/constants/global_variables.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/email_verification_screen.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/email_verified_screen.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/mobile_login_screen.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/mobile_signup_screen.dart';
import 'package:v2_product_arena/mobile/features/home/screens/mobile_home_screen.dart';
import 'package:v2_product_arena/mobile/features/onboarding/screens/mobile_onboarding_screen.dart';
import 'package:v2_product_arena/mobile/features/onboarding/screens/mobile_verified_onboarding_screen.dart';
import 'package:v2_product_arena/mobile/providers/answer_provider.dart';
import 'package:v2_product_arena/mobile/providers/error_message_provider.dart';
import 'package:v2_product_arena/mobile/providers/mobile_auth_provider.dart';
import 'package:v2_product_arena/mobile/providers/mobile_onboarding_provider.dart';
import 'package:v2_product_arena/mobile/providers/role_provider.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_login_screen.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_signup_screen.dart';
import 'package:v2_product_arena/web/features/home/screens/web_home_screen.dart';
import 'package:v2_product_arena/web/features/onboarding/screens/web_onboarding_screen.dart';
import 'package:v2_product_arena/web/providers/web_auth_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MobileAuth>(
          create: (context) => MobileAuth(),
        ),
        ChangeNotifierProvider<WebAuth>(
          create: (context) => WebAuth(),
        ),
        ChangeNotifierProvider<MobileOnboarding>(
          create: (context) => MobileOnboarding(),
        ),
        ChangeNotifierProvider<ErrorMessage>(
          create: (context) => ErrorMessage(),
        ),
        ChangeNotifierProvider<AnswerProvider>(
          create: (context) => AnswerProvider(),
        ),
        ChangeNotifierProvider<Role>(
          create: (context) => Role({}, ''),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Product Arena V2',
        theme: ThemeData(
          // primaryColor: GlobalVariables.myColor,
          primarySwatch: MaterialColor(0xff22E974, {
            50: Color(0xff22E974),
            100: Color(0xff22E974),
            200: Color(0xff22E974),
            300: Color(0xff22E974),
            400: Color(0xff22E974),
            500: Color(0xff22E974),
            600: Color(0xff22E974),
            700: Color(0xff22E974),
            800: Color(0xff22E974),
            900: Color(0xff22E974),
          }),
        ),
        home: defaultTargetPlatform == TargetPlatform.android ||
                defaultTargetPlatform == TargetPlatform.iOS
            ? const MobileLoginScreen()
            : const WebLoginScreen(),
        routes: {
          MobileLoginScreen.routeName: (context) => const MobileLoginScreen(),
          MobileSignupScreen.routeName: (context) => const MobileSignupScreen(),
          MobileOnboardingScreen.routeName: (context) =>
              const MobileOnboardingScreen(),
          MobileHomeScreen.routeName: (context) => const MobileHomeScreen(),
          WebLoginScreen.routeName: (context) => const WebLoginScreen(),
          WebSignUpScreen.routeName: (context) => const WebSignUpScreen(),
          WebOnboardingScreen.routeName: (context) =>
              const WebOnboardingScreen(),
          WebHomeScreen.routeName: (context) => const WebHomeScreen(),
          EmailVerificationScreen.routeName: (context) =>
              EmailVerificationScreen(),
          EmailVerified.routeName: (context) => const EmailVerified(),
          MobileVerifiedOnboardingScreen.routeName: (context) =>
              const MobileVerifiedOnboardingScreen(),
        },
      ),
    );
  }
}
