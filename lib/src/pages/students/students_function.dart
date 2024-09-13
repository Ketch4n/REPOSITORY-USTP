import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:repository_ustp/src/data/server/url.dart';
import 'package:repository_ustp/src/model/user_model.dart';

class StudentFunctions {
  static fetchStudentsList(userStream, int type, int status) async {
    try {
      final response = await http
          .get(Uri.parse("${Servername.host}user?type=$type&status=$status"));

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
      // print("An error occurred while fetching students: $e");
      // return [];
    }
  }
}
