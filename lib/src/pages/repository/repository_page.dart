import 'dart:async';

import 'package:flutter/material.dart';
import 'package:repository_ustp/src/pages/projects/components/text_content.dart';
import 'package:repository_ustp/src/pages/projects/project_function.dart';
import 'package:repository_ustp/src/pages/projects/project_model.dart';

class RepositoryPage extends StatefulWidget {
  const RepositoryPage({super.key, required this.callback});
  final Function callback;

  @override
  State<RepositoryPage> createState() => _RepositoryPageState();
}

class _RepositoryPageState extends State<RepositoryPage> {
  final StreamController<List<ProjectModel>> _projectStream =
      StreamController<List<ProjectModel>>();

  @override
  void initState() {
    super.initState();
    ProjectFunction.fetchProjects(_projectStream);
  }

  @override
  dispose() {
    super.dispose();
    _projectStream.close();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
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
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          runSpacing: 10.0,
                          spacing: 10.0,
                          children: List.generate(
                            projectList.length,
                            (index) => _buildBody(index, projectList),
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
                  widget.callback(4);
                  // Navigator.pushNamed(context, '/repository/add');
                },
                icon: const Icon(Icons.add),
                label: const Text("Add New Repository")),
          ),
        ),
      ],
    );
  }
}

Widget _buildBody(index, projectList) {
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