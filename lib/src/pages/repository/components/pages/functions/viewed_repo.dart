import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:repository_ustp/src/data/server/url.dart';

class ViewedRepo {
  static Future<Map<String, dynamic>?> store(
      int id, int uid, String fileName) async {
    try {
      final response = await http.post(
        Uri.parse("${Servername.host}viewed"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "project_id": id,
          "user_id": uid,
          "file_name": fileName,
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        String message = jsonResponse['message'];
        bool quack = jsonResponse['quack'];
        Map<String, dynamic> data = jsonResponse['data'];

        return {
          'message': message,
          'data': quack ? data : [],
        };
      } else {
        print("Error: ${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (e) {
      print("An error occurred while fetching data: $e");
    }
    return null; // Return null if an error occurred
  }
}
