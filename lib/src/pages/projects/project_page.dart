import 'dart:async';
import 'package:flutter/material.dart';
import 'package:repository_ustp/src/pages/projects/components/text_content.dart';
import 'package:repository_ustp/src/pages/projects/project_function.dart';
import 'package:repository_ustp/src/pages/projects/project_model.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key});

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
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
    return Scaffold(
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
                    return const Center(child: Text('No projects available.'));
                  }
                  return Wrap(
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    runSpacing: 10.0,
                    spacing: 10.0,
                    children: List.generate(
                      projectList.length,
                      (index) => _buildBody(index, projectList),
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
    );
  }
}

Widget _buildBody(index, projectList) {
  final ProjectModel project = projectList[index];
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: SizedBox(
      height: 190,
      width: 140,
      child: InkWell(
        onTap: () {},
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset("assets/hardbound.png"),
            TextContent(
                alignment: Alignment.topCenter,
                title: project.category,
                size: 10),
            TextContent(
              alignment: Alignment.center,
              title: project.title,
              color: Colors.yellow,
            ),
            TextContent(
                alignment: Alignment.bottomCenter,
                title: project.year_published,
                size: 8),
          ],
        ),
      ),
    ),
  );
}
