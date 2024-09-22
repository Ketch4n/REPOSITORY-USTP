import 'package:flutter/material.dart';

class SwitchRoleSignup with ChangeNotifier {
  static int role = 0;

  int get roleNew => role;

  set value(int newValue) {
    role = newValue;

    notifyListeners();
  }
}
