import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:repository_ustp/src/data/server/url.dart';
import 'package:repository_ustp/src/pages/projects/project_model.dart';

class ProjectFunction {
  static Future fetchProjects(projectStream, int projectType) async {
    try {
      final response = await http
          .get(Uri.parse("${Servername.host}project"))
          .timeout(Duration(seconds: 10), onTimeout: () {
        throw Exception("Request to the server timed out.");
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        List<dynamic>? data = jsonResponse['data'];
        if (data == null) {
          print('Error: No project data found');
          return;
        }

        final List<ProjectModel> projects =
            data.map((data) => ProjectModel.fromJson(data)).toList();

        if (projectType == 0) {
          projectStream.add(projects);
        } else {
          final List<ProjectModel> filtered =
              projects.where((u) => u.project_type == projectType).toList();
          projectStream.add(filtered);
        }
      } else {
        print("Error: ${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (e) {
      print("An error occurred while fetching projects: $e");
    }
  }
}
