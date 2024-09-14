// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:repository_ustp/src/components/snackbar.dart';
import 'package:repository_ustp/src/data/server/url.dart';
import 'package:repository_ustp/src/model/user_model.dart';

class StudentFunctions {
  static fetchStudentsList(userStream, int type, int status) async {
    try {
      final response = await http.post(
        Uri.parse(
            "${Servername.host}user/showStatus?type=$type&status=$status"),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        bool quack = jsonResponse['quack'];

        if (quack) {
          final List<dynamic> usersJson = jsonResponse['data'];
          List<UserModel> users =
              usersJson.map((json) => UserModel.fromJson(json)).toList();

          userStream.add(users);
        } else {
          throw Exception("Failed to fetch students list.");
        }
      } else {
        throw Exception(
            "Error: ${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (e) {
      print("An error occurred while fetching students: $e");
      return [];
    }
  }

  // static updateStudentDetails(userStream, int id, int status) async {
  //   try {
  //     final response =
  //         await http.put(Uri.parse("${Servername.host}user/$id"), body: {
  //       'status': status,
  //     });

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> jsonResponse = json.decode(response.body);

  //       bool quack = jsonResponse['quack'];
  //       String data = jsonResponse['message'];

  //       if (quack) {
  //         customSnackBar(context, 0, data);
  //         // return quack;
  //         // print(dataBack);
  //       } else {
  //         customSnackBar(context, 1, data);
  //         // return quack;
  //       }
  //     } else {
  //       throw Exception(
  //           "Error: ${response.statusCode} ${response.reasonPhrase}");
  //     }
  //   } catch (e) {
  //     // print("An error occurred while fetching students: $e");
  //     // return [];
  //   }
  // }

  static archiveStudent(BuildContext context, int id, int status) async {
    try {
      final response =
          await http.put(Uri.parse("${Servername.host}user/$id"), body: {
        'status': status.toString(),
      });

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
        print("Error: ${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (e) {
      print("An error occurred while deleting project: $e");
    }
  }

  static Future deleteStudent(BuildContext context, int id) async {
    try {
      final response =
          await http.delete(Uri.parse("${Servername.host}user/$id"));

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
