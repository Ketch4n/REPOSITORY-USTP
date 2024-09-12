import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:repository_ustp/src/components/snackbar.dart';
import 'package:repository_ustp/src/data/server/url.dart';

class RepositoryFunction {
  static Future postProjects(BuildContext context, String title, int type,
      int privacy, year, String gname, List<String?> m0) async {
    try {
      final response =
          await http.post(Uri.parse("${Servername.host}project"), body: {
        'title': title,
        'project_type': type.toString(),
        'privacy': privacy.toString(),
        'year_published': year.toString(),
        'group_name': gname.toString(),
        'member_0': m0[0],
        'member_1': m0[1],
        'member_2': m0[2],
        'member_3': m0[3],
      }).timeout(const Duration(seconds: 10), onTimeout: () {
        throw Exception("Request to the server timed out.");
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        String data = jsonResponse['message'];
        String status = jsonResponse['status'];
        bool quack = jsonResponse['quack'];
        // int dataBack = jsonResponse['data']['id'];

        if (quack) {
          customSnackBar(context, 0, data);
          // print(dataBack);
        } else {
          customSnackBar(context, 1, status);
          return;
        }
      } else {
        print("Error: ${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (e) {
      print("An error occurred while fetching projects: $e");
    }
  }
}
