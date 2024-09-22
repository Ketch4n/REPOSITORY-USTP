import 'package:flutter/material.dart';

class IndexMenuItem with ChangeNotifier {
  static int quack = 1;

  int get quackNew => quack;

  set value(int newValue) {
    quack = newValue;

    notifyListeners();
  }
}
