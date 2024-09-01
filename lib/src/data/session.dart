import 'package:flutter/material.dart';

class UserSession {
  static bool auth = false;
  static int? id;
  static String username = "";
  static String email = "";
}

class CardTypeClick with ChangeNotifier {
  static int quack = 0;

  int get quackNew => quack;

  set value(int newValue) {
    quack = newValue;

    notifyListeners();
  }
}
