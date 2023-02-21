import 'package:flutter/material.dart';

class Lecture {
  String title;
  String description;
  String totalTime;
  String remainingTime;
  String status;
  String imageLecture;

  Lecture(
      {required this.title,
      required this.description,
      required this.totalTime,
      required this.remainingTime,
      required this.status,
      required this.imageLecture});
}
