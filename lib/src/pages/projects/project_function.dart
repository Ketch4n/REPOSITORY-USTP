import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:repository_ustp/src/data/server/url.dart';
import 'package:repository_ustp/src/pages/projects/project_model.dart';

class ProjectFunction {
  static Future<void> fetchProjects(
    projectStream,
    int projectType,
    int projectKeyword,
    int projectCollection,
    String? keyword,
  ) async {
    try {
      final response = await http.get(Uri.parse("${Servername.host}project"));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey('data')) {
          final List<dynamic> data = jsonResponse['data'];
          final List<ProjectModel> projects =
              data.map((data) => ProjectModel.fromJson(data)).toList();

          if (keyword == null &&
              projectType == 0 &&
              projectKeyword == 0 &&
              projectCollection == 0) {
            projectStream.add(projects);
          } else {
            final List<ProjectModel> filtered = projects.where((u) {
              final titleMatched = keyword != null && u.title.contains(keyword);
              final titleMatches =
                  projectKeyword == 1 && u.title.contains(keyword!);
              final yearMatches =
                  projectKeyword == 3 && u.year_published == keyword;
              final typeMatches =
                  projectType == 0 || u.project_type == projectType;

              final docCollection = projectCollection == 1 &&
                  (u.manuscript?.contains(keyword!) ?? false);
              final imgCollection = projectCollection == 2 &&
                  (u.poster?.contains(keyword!) ?? false);
              final clipCollection = projectCollection == 3 &&
                  (u.video?.contains(keyword!) ?? false);
              // final keywordMatches =
              //     projectKeyword == 0 || u.title.contains(keyword!);

              return (titleMatches ||
                      titleMatched ||
                      yearMatches ||
                      docCollection ||
                      imgCollection ||
                      clipCollection) &&
                  typeMatches;
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
      print("An error occurred while fetching projects: $e");
    }
  }
}
