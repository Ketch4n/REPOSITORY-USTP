import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

class UserSession with ChangeNotifier {
  static bool auth = false;
  static int? id;
  static String? username;
  static String? email;
  static int? type;

  bool get authValue => auth;
  int? get idValue => id;
  String? get usernameValue => username;
  String? get emailValue => email;

  set value(dynamic newValue) {
    auth = newValue;
    id = newValue;
    username = newValue;
    email = newValue;

    notifyListeners();
  }
}

class UserBinary {
  static int defaultValue = 3;
  static String username = "Undefined User";
  static String email = "email.undefined@gmail.com";
}

class CardTypeClick with ChangeNotifier {
  static int quack = 0;

  int get quackNew => quack;

  set value(int newValue) {
    quack = newValue;

    notifyListeners();
  }
}
