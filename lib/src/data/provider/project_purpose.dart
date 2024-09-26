import 'package:flutter/material.dart';

class ProjectPurpose with ChangeNotifier {
  static int? quack;

  int get quackNew => quack!;

  set value(int newValue) {
    quack = newValue;

    notifyListeners();
  }
}
