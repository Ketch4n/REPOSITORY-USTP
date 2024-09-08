import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/snackbar.dart';
import 'package:repository_ustp/src/data/server/url.dart';
import 'package:repository_ustp/src/data/provider/user_session.dart';
import 'package:http/http.dart' as http;

class LoginFunctions {
  static Future fetchUserCredentials(
      context, String username, String password) async {
    if (username.isEmpty && password.isEmpty) {
      customSnackBar(context, 1, "Username or Password is Empty !");
    } else {
      try {
        final response = await http.post(
          Uri.parse("${Servername.host}user/login"),
          body: {
            'username': username,
            'password': password,
          },
        );
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        bool quack = jsonResponse['quack'];
        var user = jsonResponse['user'];
        var message = jsonResponse['message'];

        if (response.statusCode == 200 && quack) {
          // UserSession.auth = true;
          UserSession.id = user['id'];
          UserSession.username = user["username"];
          UserSession.email = user["email"];
          UserSession.type = user['type'];
          // const content = "Login Success";
          customSnackBar(context, 0, message);
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/index',
            (route) => false,
          );
        } else {
          // const content = "Username or password invalid";
          customSnackBar(context, 1, message);
        }
      } catch (e) {
        // final content = 'Failed to fetch users: $e';
        customSnackBar(context, 2, e);
      }
    }
  }
}
