import 'package:flutter/material.dart';
import 'package:repository_ustp/src/pages/projects/project_model.dart';

class ProjectIDClickEvent with ChangeNotifier {
  ProjectModel? _selectedProject;

  ProjectModel? get selectedProject => _selectedProject;

  void selectProject(ProjectModel project) {
    _selectedProject = project;
    notifyListeners();
  }
}
