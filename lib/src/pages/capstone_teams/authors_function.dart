import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:repository_ustp/src/data/server/url.dart';
import 'package:repository_ustp/src/pages/capstone_teams/authors_model.dart';

class AuthorsFunction {
  static Future<void> fetchAuthors(authorStream) async {
    try {
      final response = await http.get(Uri.parse("${Servername.host}author"));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        List<dynamic>? data = jsonResponse['data'];
        if (data == null) {
          // print('Error: No author data found');
          return;
        }

        final List<AuthorsModel> authors =
            data.map((data) => AuthorsModel.fromJson(data)).toList();

        authorStream.add(authors);
      } else {
        // print("Error: ${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (e) {
      // print("An error occurred while fetching authors: $e");
    }
  }
}
