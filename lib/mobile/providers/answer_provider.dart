import 'package:flutter/material.dart';

class AnswerProvider with ChangeNotifier {
  final List<String> _answers = ['False'];
  String firstAnswer = '';
  int get length => _answers.length;
  List<String> get answ => _answers;
  String get first => firstAnswer;

  void addItem(String item) {
    _answers.add(item);
    notifyListeners();
  }

  void removeItem(String item) {
    _answers.remove(item);
    notifyListeners();
  }

  void changeFirst(String a) {
    firstAnswer = a;
    notifyListeners();
  }
}
