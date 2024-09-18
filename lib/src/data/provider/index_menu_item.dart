import 'package:flutter/material.dart';
import 'package:repository_ustp/src/data/provider/user_session.dart';

class IndexMenuItem with ChangeNotifier {
  static int quack = UserSession.type == 2 ? 0 : 1;

  int get quackNew => quack;

  set value(int newValue) {
    quack = newValue;

    notifyListeners();
  }
}
