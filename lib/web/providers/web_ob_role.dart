import 'package:flutter/material.dart';

class WebRole with ChangeNotifier {
  Map<String, String> name;
  String image;
  Color backgroundColor = const Color(0xFFE9E9E9);
  Color textColor = const Color(0xFF322F37);

  List<String> selectedRoles = [];

  String get img => image;
  int get length => selectedRoles.length;
  Color get bck => backgroundColor;
  Color get txt => textColor;
  List<String> get selctRole => selectedRoles;

  WebRole(this.name, this.image);

  void initialize(String s) {
    image = s;
    backgroundColor = const Color(0xFFE9E9E9);
    textColor = const Color(0xFF322F37);

    notifyListeners();
  }

  void change(String s) {
    backgroundColor = const Color(0xFF322F37);
    textColor = const Color(0xFFFFFFFF);
    image = s;

    notifyListeners();
  }

  void addItem(WebRole role) {
    selectedRoles.add(role.name['forBackend']!);
    notifyListeners();
  }

  void removeItem(WebRole role) {
    selectedRoles.remove(role.name['forBackend']!);
    notifyListeners();
  }

  bool hasRole(WebRole role) {
    return selectedRoles
        .where((element) => element == role.name['forBackend']!)
        .isNotEmpty;
  }
}
