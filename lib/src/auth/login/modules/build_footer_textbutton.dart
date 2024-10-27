import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:repository_ustp/src/components/snackbar.dart';
import 'package:repository_ustp/src/components/textbutton.dart';
import 'package:repository_ustp/src/data/server/url.dart';
import 'package:repository_ustp/src/utils/text.dart';

resetPass(context) async {
  try {
    final response = await http.post(
      Uri.parse("${Servername.host}password-request"),
      body: {
        'to': "+639635612465",
        'email': "ustp.repository@gmail.com",
      },
    );
    Map<String, dynamic> jsonResponse = json.decode(response.body);

    bool quack = jsonResponse['quack'];
    var message = jsonResponse['message'];

    if (quack) {
      Navigator.of(context).pop();
      customSnackBar(context, 0, message);
    }
  } catch (e) {
    customSnackBar(context, 2, e);
  }
}

Widget buildFooterTextButton(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Create new account?",
              style: CustomTextStyle.subtext,
            ),
            CustomTextButton(
                text: "Sign Up",
                callback: () {
                  Navigator.pushNamed(context, '/signup');
                })
          ],
        ),
        CustomTextButton(
          text: "Forgot Password",
          callback: () {
            resetPass(context);
          },
        )
      ],
    ),
  );
}
