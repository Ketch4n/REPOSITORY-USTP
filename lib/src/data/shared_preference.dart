// // ignore_for_file: camel_case_types

// import 'package:shared_preferences/shared_preferences.dart';

// addPrefData(String key, dynamic value) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (value == int) {
//     return prefs.setInt(key, value);
//   } else if (value == double) {
//     return prefs.setDouble(key, value);
//   } else if (value == bool) {
//     return prefs.setBool(key, value);
//   } else if (value == String) {
//     return prefs.setString(key, value);
//   } else {
//     throw ArgumentError('Unsupported data type');
//   }
// }

// loadPrefData(dynamic value) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (value == int) {
//     return prefs.getInt(value);
//   } else if (value == double) {
//     return prefs.getDouble(value);
//   } else if (value == bool) {
//     return prefs.getBool(value);
//   } else if (value == String) {
//     return prefs.getString(value);
//   } else {
//     throw ArgumentError('Unsupported data type');
//   }
// }

// removeSpecificPrefData(dynamic value) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.remove(value);
// }

// clearAllPrefData() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.clear();
// }
