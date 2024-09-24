import 'package:flutter/material.dart';

class ProjectTypeAdd with ChangeNotifier {
  static int? quack;

  int get quackNew => quack!;

  set value(int newValue) {
    quack = newValue;

    notifyListeners();
  }
}
