import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

class AddingRepo with ChangeNotifier {
  // static bool auth = false;
  static String capstoneTitle = "";
  static int projectType = 0;
  static String yearPublished = "";
  static String groupName = "";
  static List<String> authors = [];

  // bool get authValue => auth;
  String get capstoneTitleValue => capstoneTitle;
  int get projectTypeeValue => projectType;
  String get yearPublishedValue => yearPublished;
  String get groupNameValue => groupName;
  List<String> get authorsValue => authors;

  set value(dynamic newValue) {
    // auth = newValue;
    capstoneTitle = newValue;
    projectType = newValue;
    yearPublished = newValue;
    groupName = newValue;
    authors = newValue;

    notifyListeners();
  }
}
