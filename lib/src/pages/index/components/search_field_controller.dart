// controllers.dart
import 'package:flutter/material.dart';

class SearchFieldController {
  // Singleton pattern to ensure a single instance
  static final SearchFieldController _instance =
      SearchFieldController._internal();

  factory SearchFieldController() => _instance;

  SearchFieldController._internal();

  // Publicly accessible TextEditingController
  TextEditingController search = TextEditingController();

  // Dispose method to clean up resources
  void dispose() {
    search.dispose();
  }
}
