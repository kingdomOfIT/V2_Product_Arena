import 'package:flutter/material.dart';

class WebErrorMessage with ChangeNotifier {
  String errorText = '';
  IconData? errorIcon;
  double errorHeight = 0;
  double firstQuestionError = 140;
  double errorPadding = 0;

  String get text => errorText;
  IconData? get icon => errorIcon;
  double get height => errorHeight;
  void change() {
    errorHeight = 20;
    errorText = 'Molimo vas da popunite polje!';
    errorPadding = 34;
    errorIcon = Icons.error_rounded;
    notifyListeners();
  }

  void changeFirstErrorHeight() {
    firstQuestionError = 189;
    notifyListeners();
  }

  void resetFirstErrorHeight() {
    firstQuestionError = 140;
    notifyListeners();
  }

  void reset() {
    errorHeight = 0;
    errorText = '';
    errorIcon = null;
    notifyListeners();
  }
}
