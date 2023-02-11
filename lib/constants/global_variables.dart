import 'package:flutter/material.dart';

class GlobalVariables {
  static const myColor = Color(0xFF22E974);

  static const List<Map<String, String>> socialMedia = [
    {
      'image': 'assets/images/facebook.png',
      'url': 'https://www.facebook.com/tech387',
    },
    {
      'image': 'assets/images/instagram.png',
      'url': 'https://www.instagram.com/tech387/?hl=en',
    },
    {
      'image': 'assets/images/linked.png',
      'url': 'https://www.linkedin.com/company/tech-387/mycompany/',
    },
    {
      'image': 'assets/images/tech.png',
      'url': 'https://www.tech387.com/',
    },
  ];

  static const List<String> status = [
    'Student',
    'Employed',
    'Unemployed',
  ];
}
