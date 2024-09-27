import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:repository_ustp/src/data/server/url.dart';

class ViewedRepo {
  static store(int projectID, int userID, String fileName) async {
    try {
      final response = await http.post(
        Uri.parse("${Servername.host}viewed"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "project_id": projectID,
          "user_id": userID,
          "file_name": fileName,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        String message = jsonResponse['message'];
        bool quack = jsonResponse['quack'];
        Map<String, dynamic> data = jsonResponse['data'];

        if (quack) {
          return {
            'message': message,
            'data': data,
          };
        } else {
          return {
            'message': message,
            'data': [],
          };
        }
      } else {
        print("Error: ${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (e) {
      print("An error occurred while fetching data: $e");
    }
  }
}
