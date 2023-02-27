import 'package:flutter/material.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_green_profile.dart';
import 'package:v2_product_arena/web/reusable_web_widgets/web_homepage_sidebar.dart';

class WebHomeScreen extends StatelessWidget {
  static const routeName = '/web-home';

  const WebHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double maxwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          const WebSideBar(),
          Container(
            alignment: Alignment.center,
            width: maxwidth * (900 / 1440),
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/Homescreenbody.png'),
                  fit: BoxFit.cover),
            ),
            child: const Text(''),
          ),
          const Align(
            alignment: Alignment.topRight,
            child: WebProfilePopup(),
          )
        ],
      ),
    );
  }
}
