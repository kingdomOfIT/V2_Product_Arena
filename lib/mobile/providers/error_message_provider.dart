import 'package:flutter/material.dart';

class ErrorMessage with ChangeNotifier {
  String errorText = '';
  IconData? errorIcon;
  double errorHeight = 0;

  List selectedRole = [];
  String get text => errorText;
  IconData? get icon => errorIcon;
  double get height => errorHeight;
  void change() {
    errorHeight = 30;
    errorText = 'Molimo vas da popunite polje!';
    errorIcon = Icons.error_rounded;
    notifyListeners();
  }

  void change2() {
    errorHeight = 30;
    errorText = 'Molimo odaberite jednu ili dvije pozicije';
    errorIcon = Icons.error_rounded;
    notifyListeners();
  }

  void reset() {
    errorHeight = 0;
    errorText = '';
    errorIcon = null;
    notifyListeners();
  }
}
