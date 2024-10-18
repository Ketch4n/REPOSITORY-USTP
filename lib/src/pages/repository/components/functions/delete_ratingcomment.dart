import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/loading.dart';
import 'package:repository_ustp/src/components/snackbar.dart';
import 'package:repository_ustp/src/data/server/url.dart';
import 'package:http/http.dart' as http;

Future deleteRatingComment(
    BuildContext context, int id, Function reload, projid) async {
  circularLoading(context);
  try {
    final response =
        await http.delete(Uri.parse("${Servername.host}likecomment/$id"));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      String data = jsonResponse['message'];
      bool quack = jsonResponse['quack'];

      if (quack) {
        customSnackBar(context, 0, data);
        reload(projid);
        // print(dataBack);
      } else {
        customSnackBar(context, 1, data);
        return false;
      }
    } else {
      // print("Error: ${response.statusCode} ${response.reasonPhrase}");
    }
  } catch (e) {
    // print("An error occurred while deleting project: $e");
  } finally {
    Navigator.of(context).pop();
  }
}
