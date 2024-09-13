// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:repository_ustp/src/components/snackbar.dart';
import 'package:repository_ustp/src/data/server/url.dart';

class RepositoryFunction {
  static Future postProject(BuildContext context, String title, int type,
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
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        String data = jsonResponse['message'];
        bool quack = jsonResponse['quack'];

        if (quack) {
          customSnackBar(context, 0, data);
          return quack;
          // print(dataBack);
        } else {
          customSnackBar(context, 1, data);
          return quack;
        }
      } else {
        // print("Error: ${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (e) {
      // print("An error occurred while fetching projects: $e");
    }
  }

  static Future updateProject(BuildContext context, int id, String title,
      int? projectType, String year, int privacy) async {
    try {
      final response =
          await http.put(Uri.parse("${Servername.host}project/$id"), body: {
        'title': title,
        'project_type': projectType?.toString(),
        'year_published': year.toString(),
        'privacy': privacy.toString(),
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        String data = jsonResponse['message'];
        bool quack = jsonResponse['quack'];

        if (quack) {
          customSnackBar(context, 0, data);
          // return quack;
        } else {
          customSnackBar(context, 1, data);
          // return quack;
        }
      } else {
        // print("Error: ${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (e) {
      // print("An error occurred while updating project: $e");
    }
  }

  static Future deleteProject(BuildContext context, int id) async {
    try {
      final response =
          await http.delete(Uri.parse("${Servername.host}project/$id"));
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        String data = jsonResponse['message'];
        bool quack = jsonResponse['quack'];

        if (quack) {
          customSnackBar(context, 0, data);
          // return quack;
          // print(dataBack);
        } else {
          customSnackBar(context, 1, data);
          // return quack;
        }
      } else {
        // print("Error: ${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (e) {
      // print("An error occurred while deleting project: $e");
    }
  }
}
