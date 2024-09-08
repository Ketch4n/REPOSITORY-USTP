import 'package:flutter/material.dart';

class SwitchRoleSignup with ChangeNotifier {
  static bool type = false; // Private variable to hold the state.

  bool get typeNew => type;

  void toggleType() {
    type = !type;
    notifyListeners(); // Notify listeners when the state changes.
  }
}
