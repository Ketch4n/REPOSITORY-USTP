import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

class UserSession with ChangeNotifier {
  // static bool auth = false;
  static int id = 0;
  static String username = "Undefined User";
  static String email = "email.undefined@gmail.com";
  static int type = 4;

  // bool get authValue => auth;
  int? get idValue => id;
  String? get usernameValue => username;
  String? get emailValue => email;

  set value(dynamic newValue) {
    // auth = newValue;
    id = newValue;
    username = newValue;
    email = newValue;

    notifyListeners();
  }
}
