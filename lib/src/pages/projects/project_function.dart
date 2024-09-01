import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:repository_ustp/src/pages/projects/project_model.dart';

class ProjectFunction {
  static Future fetchProjects(projectStream, int type) async {
    try {
      final response =
          await rootBundle.loadString("assets/json/all_project.json");
      var jsonData = jsonDecode(response) as List<dynamic>;

      if (type == 0) {
        final List<ProjectModel> project =
            jsonData.map((data) => ProjectModel.fromJson(data)).toList();
        projectStream.add(project);
      } else {
        final List<ProjectModel> project =
            jsonData.map((data) => ProjectModel.fromJson(data)).toList();
        final List<ProjectModel> filtered =
            project.where((u) => u.project_type == type).toList();
        projectStream.add(filtered);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      // customSnackBar(context, 2, "Error $e");
      // print("Error $e");
    }
  }
}
