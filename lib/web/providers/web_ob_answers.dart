import 'package:flutter/material.dart';

class WebAnswerProvider with ChangeNotifier {
  final List<String> _answers = ['False'];
  final formKeys = List.generate(6, (i) => GlobalKey<FormState>());

  bool da = false, ne = false;
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

  void changeFirst(bool a) {
    da = a;
    ne = !da;
    notifyListeners();
  }
}
