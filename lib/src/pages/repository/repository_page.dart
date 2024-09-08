import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repository_ustp/src/components/show_dialog.dart';
import 'package:repository_ustp/src/data/index/privacy_icon_value.dart';
import 'package:repository_ustp/src/data/index/project_index_value.dart';
import 'package:repository_ustp/src/data/provider/card_click_event.dart';
import 'package:repository_ustp/src/pages/projects/components/text_content.dart';
import 'package:repository_ustp/src/pages/projects/project_function.dart';
import 'package:repository_ustp/src/pages/projects/project_model.dart';
import 'package:repository_ustp/src/pages/repository/components/repository_add.dart';

class RepositoryPage extends StatefulWidget {
  const RepositoryPage({super.key, required this.projectType});

  final int projectType;

  @override
  State<RepositoryPage> createState() => _RepositoryPageState();
}

class _RepositoryPageState extends State<RepositoryPage> {
  final StreamController<List<ProjectModel>> _projectStream =
      StreamController<List<ProjectModel>>();

  @override
  void initState() {
    super.initState();
    _fetchProjects();
  }

  @override
  void dispose() {
    _projectStream.close();
    super.dispose();
  }

  // Method to fetch projects and reload
  void _fetchProjects() {
    ProjectFunction.fetchProjects(_projectStream, widget.projectType);
  }

  // Method to reload the data
  void reload() {
    setState(() {
      _fetchProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Consumer<CardClickEvent>(builder: (context, value, child) {
              return Text(projectTypeBinaryValue(value.quackNew));
            }),
            actions: [
              IconButton(
                icon: const Icon(Icons.sort),
                onPressed: reload,
              ),
            ],
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Align(
              alignment: Alignment.center,
              child: StreamBuilder<List<ProjectModel>>(
                  stream: _projectStream.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<ProjectModel?> projectList = snapshot.data!;

                      if (projectList.isEmpty) {
                        return const Center(
                            child: Text('No projects available.'));
                      }
                      return Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          runSpacing: 10.0,
                          spacing: 10.0,
                          children: List.generate(
                            projectList.length,
                            (index) => _buildBody(index, projectList, context),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Error: ${snapshot.error}"),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton.icon(
                onPressed: () {
                  // widget.callback(4);
                  // Navigator.pushNamed(context, '/repository/add');
                  showCustomDialog(context, const RepositoryAdd());
                },
                icon: const Icon(Icons.add),
                label: const Text("Add New Repository")),
          ),
        ),
      ],
    );
  }
}

Widget _buildBody(index, projectList, context) {
  final ProjectModel project = projectList[index];

  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: SizedBox(
      height: 130,
      width: 140,
      child: InkWell(
        onTap: () {},
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              "assets/folder.png",
            ),
            Align(
              alignment: Alignment.topRight,
              child: projectPrivacyValue(project.privacy, context),
            ),
            TextContent(
                alignment: Alignment.topLeft,
                title: project.year_published,
                size: 10),
            TextContent(
              alignment: Alignment.center,
              title: project.title,
              color: Colors.black,
              size: 14,
            ),
            TextContent(
                alignment: Alignment.bottomCenter,
                title: project.group_name,
                color: Colors.black,
                size: 10),
          ],
        ),
      ),
    ),
  );
}
