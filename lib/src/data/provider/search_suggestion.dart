import 'package:flutter/foundation.dart';

class SearchSuggestion with ChangeNotifier {
  static List<String> allItems = [];

  List<String> get items => List.from(allItems);

  void addItems(List<String> newItems) {
    allItems.clear();
    allItems = newItems.toList();
    notifyListeners();
  }
}
