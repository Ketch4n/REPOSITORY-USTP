import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/loading.dart';
import 'package:repository_ustp/src/components/snackbar.dart';
import 'package:repository_ustp/src/data/server/url.dart';
import 'package:http/http.dart' as http;

postRatingComment(BuildContext context, int uid, int projid, int ratingIndex,
    String commentValue, reload) async {
  if (uid == 0 || ratingIndex == 0 || projid == 0 || commentValue.isEmpty) {
    customSnackBar(context, 1, "Rating or Comment Empty !");
    Navigator.of(context).pop();
    return;
  }
  circularLoading(context);

  try {
    final response =
        await http.post(Uri.parse("${Servername.host}likecomment"), body: {
      'user_id': uid.toString(),
      'project_id': projid.toString(),
      'rating': ratingIndex.toString(),
      'comment': commentValue,
    });

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);

      String message = jsonResponse['message'];
      bool quack = jsonResponse['quack'];
      if (quack) {
        customSnackBar(context, 0, message);
      } else {
        customSnackBar(context, 1, message);
      }
    } else {
      print("Error: ${response.statusCode} ${response.reasonPhrase}");
    }
  } catch (e) {
    print("An error occurred while fetching ratings and comments: $e");
  } finally {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    reload();
  }
}
