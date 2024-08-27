// import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:repository_ustp/src/components/snackbar.dart';
import 'package:repository_ustp/src/data/user_binary_value.dart';

class LoginController {
  static Future fetchUser(context, String username, String password) async {
    try {
      final response =
          await rootBundle.loadString("assets/json/user_credentials.json");
      var jsonData = jsonDecode(response) as List<dynamic>;

      bool isAuthenticated = false;
      int type = UserBinary.defaultValue;

      for (var user in jsonData) {
        final String? userName = user["username"];
        final String? pass = user["password"];
        final int typeString = user['type'];

        if (userName == username && pass == password) {
          isAuthenticated = true;
          type = typeString;
          UserBinary.defaultValue = type;
          break;
        }
      }

      if (isAuthenticated) {
        const content = "Login Success";
        customSnackBar(context, 0, content);
        Navigator.pushNamedAndRemoveUntil(
          context,
          arguments: type,
          '/index',
          (route) => false,
        );
      } else {
        const content = "Username or password invalid";
        customSnackBar(context, 1, content);
      }
    } catch (e) {
      final content = 'Failed to fetch users: $e';
      customSnackBar(context, 2, content);
    }
  }
}
