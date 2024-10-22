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

          // Add project titles for search suggestions
          final List<String> projectTitles =
              projects.map((project) => project.title).toList();
          searchSuggestion.addItems(projectTitles);

          // Filter projects based on criteria
          List<ProjectModel> filteredProjects = _filterProjects(
            projects,
            projectType,
            projectKeyword,
            projectCollection,
            keyword,
          );

          // Add filtered projects to the stream
          projectStream.add(filteredProjects);
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

  static List<ProjectModel> _filterProjects(
    List<ProjectModel> projects,
    int projectType,
    int projectKeyword,
    int projectCollection,
    String? keyword,
  ) {
    if (keyword == null &&
        (projectType == 0 || projectType == 4) &&
        projectKeyword == 0 &&
        projectCollection == 0) {
      return projects; // No filtering needed
    }

    final String? lowerCaseKeyword = keyword?.toLowerCase();

    return projects.where((project) {
      final titleMatched = lowerCaseKeyword != null &&
          projectCollection == 0 &&
          project.title.toLowerCase().contains(lowerCaseKeyword);

      final yearMatches = projectKeyword == 3 &&
          projectCollection == 0 &&
          project.year_published.toLowerCase() == lowerCaseKeyword;

      final typeMatches = (projectType == 0 || projectType == 4) ||
          project.project_type == projectType;

      final docCollection = projectCollection == 1 &&
          (project.manuscript != null &&
              project.title.toLowerCase().contains(lowerCaseKeyword!) &&
              project.manuscript!.toLowerCase().endsWith('.pdf'));

      final imgCollection = projectCollection == 2 &&
          (project.poster != null &&
              project.title.toLowerCase().contains(lowerCaseKeyword!) &&
              (project.poster!.toLowerCase().endsWith('.jpg') ||
                  project.poster!.toLowerCase().endsWith('.png') ||
                  project.poster!.toLowerCase().endsWith('.jpeg')));

      final clipCollection = projectCollection == 3 &&
          (project.video != null &&
              project.title.toLowerCase().contains(lowerCaseKeyword!) &&
              project.video!.toLowerCase().endsWith('.mp4'));

      final zipCollection = projectCollection == 4 &&
          (project.zip != null &&
              project.title.toLowerCase().contains(lowerCaseKeyword!) &&
              project.zip!.toLowerCase().endsWith('.zip'));

      return (titleMatched ||
              yearMatches ||
              docCollection ||
              imgCollection ||
              clipCollection ||
              zipCollection) &&
          typeMatches;
    }).toList();
  }
}
