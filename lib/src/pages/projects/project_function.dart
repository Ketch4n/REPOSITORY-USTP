import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:repository_ustp/src/data/provider/search_suggestion.dart';
import 'package:repository_ustp/src/data/server/url.dart';
import 'package:repository_ustp/src/pages/projects/project_model.dart';

class ProjectFunction {
  static Future<void> fetchProjects(
      projectStream,
      int projectType,
      int projectKeyword,
      int projectCollection,
      String? keyword,
      SearchSuggestion searchSuggestion) async {
    try {
      final response = await http.get(Uri.parse("${Servername.host}project"));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        if (jsonResponse.containsKey('data')) {
          final List<dynamic> data = jsonResponse['data'];
          final List<ProjectModel> projects =
              data.map((data) => ProjectModel.fromJson(data)).toList();
          final List<String> projectTitles =
              projects.map((project) => project.title).toList();
          searchSuggestion.addItems(projectTitles);
          if (keyword == null &&
              (projectType == 0 || projectType == 4) &&
              projectKeyword == 0 &&
              projectCollection == 0) {
            projectStream.add(projects);
          } else {
            final String? lowerCaseKeyword = keyword?.toLowerCase();

            final List<ProjectModel> filtered = projects.where((u) {
              final titleMatched = lowerCaseKeyword != null &&
                  u.title.toLowerCase().contains(lowerCaseKeyword);
              // final titleMatches = projectKeyword == 1 &&
              //     u.title.toLowerCase().contains(lowerCaseKeyword!);
              final yearMatches = projectKeyword == 3 &&
                  u.year_published.toLowerCase() == lowerCaseKeyword;
              final typeMatches = (projectType == 0 || projectType == 4) ||
                  u.project_type == projectType;

              final docCollection = projectCollection == 1 &&
                  (u.manuscript?.toLowerCase().contains(lowerCaseKeyword!) ??
                      false);
              final imgCollection = projectCollection == 2 &&
                  (u.poster?.toLowerCase().contains(lowerCaseKeyword!) ??
                      false);
              final clipCollection = projectCollection == 3 &&
                  (u.video?.toLowerCase().contains(lowerCaseKeyword!) ?? false);

              return (titleMatched ||
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
