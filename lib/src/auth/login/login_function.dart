import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/loading.dart';
import 'package:repository_ustp/src/components/snackbar.dart';
import 'package:repository_ustp/src/data/server/url.dart';
import 'package:repository_ustp/src/data/provider/user_session.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity/connectivity.dart';

class LoginFunctions {
  static Future fetchUserCredentials(
      context, String username, String password) async {
    if (username.isEmpty && password.isEmpty) {
      customSnackBar(context, 1, "Username or Password is Empty !");
    } else {
      circularLoading(context);
      try {
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.none) {
          customSnackBar(context, 1, "No internet connection!");
          Navigator.of(context).pop();
          return;
        }

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
          UserSession.id = user['id'];
          UserSession.username = user["username"];
          UserSession.email = user["email"];
          UserSession.type = user['type'];
          customSnackBar(context, 0, message);
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/index',
            (route) => false,
          );
        } else {
          customSnackBar(context, 1, message);
          Navigator.of(context).pop();
        }
      } catch (e) {
        customSnackBar(context, 2, "Failed to connect to the server!");
        Navigator.of(context).pop();
      }
    }
  }
}
