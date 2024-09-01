import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:repository_ustp/src/model/user_model.dart';

class StudentFunctions {
  static fetchStudentsList(userStream, int type) async {
    try {
      final response =
          await rootBundle.loadString("assets/json/user_credentials.json");
      var jsonData = jsonDecode(response) as List<dynamic>;

      final List<UserModel> user =
          jsonData.map((data) => UserModel.fromJson(data)).toList();

      final List<UserModel> filteredUsers =
          user.where((u) => u.type == type).toList();

      userStream.add(filteredUsers);
    } catch (e) {
      print("Error $e");
    }
  }
}
