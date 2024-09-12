import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:repository_ustp/src/data/server/url.dart';
import 'package:repository_ustp/src/pages/projects/project_model.dart';

class ProjectFunction {
  static Future<void> fetchProjects(
    projectStream,
    int projectType,
    int projectKeyword,
    String? keyword,
  ) async {
    try {
      final response =
          await http.get(Uri.parse("${Servername.host}project")).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw Exception("Request to the server timed out.");
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey('data')) {
          final List<dynamic> data = jsonResponse['data'];
          final List<ProjectModel> projects =
              data.map((data) => ProjectModel.fromJson(data)).toList();

          if (keyword == null && projectType == 0 && projectKeyword == 0) {
            projectStream.add(projects);
          } else {
            final List<ProjectModel> filtered = projects.where((u) {
              final titleMatches = keyword != null && u.title.contains(keyword);
              final yearMatches =
                  keyword != null && u.year_published == keyword;
              final typeMatches =
                  projectType == 0 || u.project_type == projectType;
              // final keywordMatches =
              //     projectKeyword == 0 || u.title.contains(keyword!);

              return (titleMatches || yearMatches) && typeMatches;
            }).toList();

            projectStream.add(filtered);
          }
        } else {
          throw Exception("Unexpected response format: 'data' key missing.");
        }
      } else {
        throw Exception(
            "Error: ${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (e) {
      // Log the error for debugging purposes
      print("An error occurred while fetching projects: $e");
    }
  }
}
