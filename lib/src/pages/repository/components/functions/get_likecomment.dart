import 'dart:convert';

import 'package:repository_ustp/src/data/server/url.dart';
import 'package:http/http.dart' as http;
import 'package:repository_ustp/src/pages/repository/components/model/likecomment_model.dart';

Future getLikeComment(likecommentStream, id) async {
  try {
    final response = await http
        .post(Uri.parse("${Servername.host}likecomment/rating"), body: {
      "project_id": id.toString(),
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      final List<dynamic> usersJson = jsonResponse['data'];
      List<LikecommentModel> ratingcomment =
          usersJson.map((json) => LikecommentModel.fromJson(json)).toList();

      likecommentStream.add(ratingcomment);
    } else {
      throw Exception("Error: ${response.statusCode} ${response.reasonPhrase}");
    }
  } catch (e) {
    print("An error occurred while fetching rating and comments: $e");
    return [];
  }
}
