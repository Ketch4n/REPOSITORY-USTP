// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:repository_ustp/src/components/loading.dart';
import 'package:repository_ustp/src/components/snackbar.dart';
import 'package:repository_ustp/src/data/server/url.dart';

class RepositoryFunction {
  static Future postProject(
    BuildContext context,
    String title,
    int type,
    year,
    int semester,
    String gname,
    List<String?> m0,
    String? doc,
    String? img,
    String? clip,
    String? zip,
  ) async {
    try {
      final response =
          await http.post(Uri.parse("${Servername.host}project"), body: {
        'title': title,
        'project_type': type.toString(),
        'year_published': year.toString(),
        'semester': type.toString() == "3" ? semester.toString() : "4",
        'group_name': gname.toString(),
        'manuscript': doc,
        'poster': img,
        'video': clip,
        'zip': zip,
        for (int i = 0; i < m0.length; i++) 'member_$i': m0[i],
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        String message = jsonResponse['message'];
        bool quack = jsonResponse['quack'];
        int dataID = jsonResponse['data']['id'];

        if (quack) {
          return {
            'message': message,
            'dataID': dataID,
          };
        } else {
          return {
            'message': message,
            'dataID': 0,
          };
        }
      } else {
        print("Error: ${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (e) {
      print("An error occurred while fetching projects: $e");
    }
  }

  static Future updateProject(BuildContext context, int id, String title,
      int? projectType, String year, String groupName, List<String?> m0) async {
    circularLoading(context);
    try {
      final response =
          await http.put(Uri.parse("${Servername.host}project/$id"), body: {
        'title': title,
        'project_type': projectType?.toString(),
        'year_published': year.toString(),
        'group_name': groupName.toString(),
        for (int i = 0; i < m0.length; i++) 'member_$i': m0[i],
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        String message = jsonResponse['message'];
        bool quack = jsonResponse['quack'];

        if (quack) {
          // customSnackBar(context, 0, data);
          // return quack;
          return {
            'message': message,
            'quack': quack,
          };
        } else {
          // customSnackBar(context, 1, data);
          // return quack;
          return {
            'message': message,
            'quack': quack,
          };
        }
      } else {
        print("Error: ${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (e) {
      print("An error occurred while updating project: $e");
    } finally {
      Navigator.of(context).pop();
    }
  }

  static Future deleteProject(BuildContext context, int id) async {
    circularLoading(context);
    try {
      final response =
          await http.delete(Uri.parse("${Servername.host}project/$id"));
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
}
