import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:repository_ustp/src/data/server/url.dart';
import 'package:repository_ustp/src/pages/repository/components/model/download_model.dart';

class DownloadFunction {
  static Future<List<Download>> fetchDownloads(int id) async {
    final response = await http.post(
      Uri.parse("${Servername.host}countDownloads"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "project_id": id,
      }),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Download.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load downloads');
    }
  }
}
