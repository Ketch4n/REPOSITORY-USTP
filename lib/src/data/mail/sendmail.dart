// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:repository_ustp/src/data/server/url.dart';

class SendMailFunction {
  static Future<void> sendEmail(
    String name,
    String email,
    String message,
  ) async {
    final response = await http.post(
      Uri.parse("${Servername.host}sendmail"),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'message': message,
      }),
    );

    if (response.statusCode == 200) {
      print('Email sent successfully!');
    } else {
      print('Failed to send email: ${response.body}');
    }
  }

  static Future<void> sendEmailTypeStatus(
    String link,
    String title,
    String type,
    String year,
  ) async {
    final response = await http
        .post(Uri.parse("${Servername.host}sendmailTypeStatus"), body: {
      'link': link,
      'title': title,
      'type': type,
      'year': year,
    });

    if (response.statusCode == 200) {
      print('Email sent successfully!');
    } else {
      print('Failed to send email: ${response.body}');
    }
  }
}
