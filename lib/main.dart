// ignore_for_file: depend_on_referenced_packages

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:v2_product_arena/amplifyconfiguration.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/email_verification_screen.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/email_verified_screen.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/mobile_login_screen.dart';
import 'package:v2_product_arena/mobile/features/auth/screens/mobile_signup_screen.dart';
import 'package:v2_product_arena/mobile/features/home/screens/mobile_home_screen.dart';
import 'package:v2_product_arena/mobile/features/onboarding/screens/mobile_onboarding_screen.dart';
import 'package:v2_product_arena/mobile/providers/mobile_auth_provider.dart';
import 'package:v2_product_arena/mobile/providers/mobile_onboarding_provider.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_email_verifed.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_login_screen.dart';
import 'package:provider/provider.dart';
import 'package:v2_product_arena/web/features/auth/screens/web_signup_screen.dart';
import 'package:v2_product_arena/web/features/home/screens/web_home_screen.dart';
import 'package:v2_product_arena/web/features/onboarding/screens/web_onboarding_screen.dart';
import 'package:v2_product_arena/web/providers/web_auth_provider.dart';

import 'web/features/auth/screens/web_verification_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);
      // call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }
  }

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
            ? MobileSignupScreen()
            : const WebLoginScreen(),
        routes: {
          MobileLoginScreen.routeName: (context) => const MobileLoginScreen(),
          MobileSignupScreen.routeName: (context) => const MobileSignupScreen(),
          MobileOnboardingScreen.routeName: (context) =>
              const MobileOnboardingScreen(),
          MobileHomeScreen.routeName: (context) => const MobileHomeScreen(),
          WebLoginScreen.routeName: (context) => const WebLoginScreen(),
          WebSignUpScreen.routeName: (context) => WebSignUpScreen(),
          WebOnboardingScreen.routeName: (context) =>
              const WebOnboardingScreen(),
          WebHomeScreen.routeName: (context) => const WebHomeScreen(),
          SignupConfirmation.routeName: (context) => SignupConfirmation(),
          Verifed.routeName: (context) => Verifed(),
          EmailVerificationScreen.routeName: (context) =>
              EmailVerificationScreen(),
          EmailVerified.routeName: (context) => EmailVerified(),
        },
      ),
    );
  }
}
