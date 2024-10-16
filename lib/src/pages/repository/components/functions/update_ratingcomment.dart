import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/loading.dart';
import 'package:repository_ustp/src/components/snackbar.dart';
import 'package:repository_ustp/src/data/server/url.dart';

Future updateRatingComment(
  BuildContext context,
  int projid,
  int id,
  reload,
  int rating,
  String comment,
) async {
  if (rating == 0 || comment.isEmpty) {
    customSnackBar(context, 1, "Rating or Comment cannot be Empty !");
    Navigator.of(context).pop();
    return;
  }
  circularLoading(context);

  try {
    final response = await http
        .post(Uri.parse("${Servername.host}likecomment/$id/update"), body: {
      'rating': rating.toString(),
      'comment': comment,
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
