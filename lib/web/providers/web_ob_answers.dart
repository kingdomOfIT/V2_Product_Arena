import 'package:flutter/material.dart';

class AnswerProvider with ChangeNotifier {
  List<String> _answers = [];
  List<bool> daNeSelected = [false, false];
  String firstAnswer = '';
  int get length => _answers.length;
  List<String> get answ => _answers;
  String get first => firstAnswer;
  void addItem(String item) {
    _answers.add(item);
    notifyListeners();
  }

  void changeFirst(String a) {
    firstAnswer = a;
    notifyListeners();
  }

  void changeSelected(int i) {
    daNeSelected[i] = !daNeSelected[i];
  }
}
