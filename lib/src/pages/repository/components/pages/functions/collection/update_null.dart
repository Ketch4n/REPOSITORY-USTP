import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/loading.dart';
import 'package:repository_ustp/src/components/snackbar.dart';
import 'package:repository_ustp/src/data/server/url.dart';

Future updateCollectionNULL(
  BuildContext context,
  dynamic projid,
  int type,
) async {
  circularLoading(context);

  try {
    final response = await http.post(
        Uri.parse("${Servername.host}collection-null/$projid/update"),
        body: {
          'filetype': type.toString(),
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
    print("An error occurred while fetching collection: $e");
  } finally {
    Navigator.of(context).pop();
  }
}
