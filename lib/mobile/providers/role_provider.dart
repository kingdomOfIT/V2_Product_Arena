import 'package:flutter/material.dart';

class Role with ChangeNotifier {
  String name;
  String image;
  Color backgroundColor = const Color(0xFFE9E9E9);
  Color textColor = const Color(0xFF322F37);

  List<String> selectedRoles = [];

  List<String> get selctRole => selectedRoles;

  String get img => image;
  int get length => selectedRoles.length;
  Color get bck => backgroundColor;
  Color get txt => textColor;

  Role(this.name, this.image);

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

  void addItem(Role role) {
    selectedRoles.add(role.name.toLowerCase());
    notifyListeners();
  }

  void removeItem(Role role) {
    selectedRoles.remove(role.name);
    notifyListeners();
  }

  bool hasRole(Role role) {
    return selectedRoles.where((element) => element == role.name).isNotEmpty;
  }
}
