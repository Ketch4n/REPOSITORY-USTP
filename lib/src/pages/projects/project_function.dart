import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:repository_ustp/src/pages/projects/project_model.dart';

class ProjectFunction {
  static Future fetchProjects(projectStream) async {
    try {
      final response =
          await rootBundle.loadString("assets/json/all_project.json");
      var jsonData = jsonDecode(response) as List<dynamic>;

      final List<ProjectModel> project =
          jsonData.map((data) => ProjectModel.fromJson(data)).toList();

      projectStream.add(project);
    } catch (e) {
      // ignore: use_build_context_synchronously
      // customSnackBar(context, 2, "Error $e");
      // print("Error $e");
    }
  }
}
