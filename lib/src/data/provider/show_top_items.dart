import 'package:flutter/material.dart';

class ShowTopItems with ChangeNotifier {
  bool isShow = true;

  void show() {
    isShow = true;
    notifyListeners();
  }

  void hide() {
    isShow = false;
    notifyListeners();
  }
}
