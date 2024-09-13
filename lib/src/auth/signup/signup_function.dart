// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:repository_ustp/src/data/server/url.dart';

signupFunction(
  BuildContext context,
  String username,
  String email,
  String password,
  bool type,
) async {
  if (username.isEmpty || password.isEmpty || email.isEmpty) {
    customSnackBar(context, 1, "Fields cannot be Empty !");
  } else {
    try {
      final int value = type == true ? 1 : 2;
      final response = await http.post(
        Uri.parse("${Servername.host}user/register"),
        body: {
          'username': username,
          'email': email,
          'type': value.toString(),
          'password': password,
        },
      );
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      bool quack = jsonResponse['quack'];
      var message = jsonResponse['message'];

      if (quack) {
        Navigator.of(context).pop();
        customSnackBar(context, 0, message);
      } else {}
    } catch (e) {
      customSnackBar(context, 2, e);
    }
  }
}
