import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repository_ustp/src/components/duck_404.dart';
import 'package:repository_ustp/src/data/index/project_index_value.dart';
import 'package:repository_ustp/src/data/index/project_keyword_value.dart';
import 'package:repository_ustp/src/data/provider/card_click_event.dart';
import 'package:repository_ustp/src/data/provider/click_event_collection.dart';
import 'package:repository_ustp/src/data/provider/click_event_keyword.dart';
import 'package:repository_ustp/src/pages/index/components/search_field.dart';
import 'package:repository_ustp/src/pages/index/components/search_field_controller.dart';
import 'package:repository_ustp/src/pages/projects/components/text_content.dart';
import 'package:repository_ustp/src/pages/projects/project_function.dart';
import 'package:repository_ustp/src/pages/projects/project_model.dart';
import 'package:repository_ustp/src/utils/palette.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({super.key, required this.projectType});
  final int projectType;

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  final StreamController<List<ProjectModel>> _projectStream =
      StreamController<List<ProjectModel>>();

  final _searchController = SearchFieldController().search;

  @override
  void initState() {
    super.initState();

    _fetchProjects(
      CLickEventProjectType.quack,
      ClickEventProjectKeyword.quack,
      ClickEventProjectCollection.quack,
      _searchController.text,
    );
  }

  @override
  void dispose() {
    _projectStream.close();
    super.dispose();
  }

  // Method to fetch projects and reload
  void _fetchProjects(quackType, quackKeyword, quackCollection, search) {
    ProjectFunction.fetchProjects(
        _projectStream, quackType, quackKeyword, quackCollection, search);
  }

  // Method to reload the data
  void reload() {
    setState(() {
      _fetchProjects(
        CLickEventProjectType.quack,
        ClickEventProjectKeyword.quack,
        ClickEventProjectCollection.quack,
        _searchController.text,
      );
      // print(_searchController.text);
    });
  }

  void clear() {
    setState(() {
      _searchController.clear();
      CLickEventProjectType.quack = 0;
      ClickEventProjectKeyword.quack = 0;
      reload();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: ColorPallete.grey),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: SearchField(reload: reload),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Consumer<CLickEventProjectType>(
                      builder: (context, value, child) {
                    return Text(
                      projectTypeBinaryValue(value.quackNew),
                      style: const TextStyle(fontSize: 20),
                    );
                  }),
                  const Text(" / "),
                  Consumer<ClickEventProjectKeyword>(
                      builder: (context, value, child) {
                    return Text(
                      projectKeywordBinaryValue(value.quackNew),
                      style: const TextStyle(fontSize: 20),
                    );
                  }),
                  const SizedBox(width: 10),
                  IconButton(
                      onPressed: () {
                        clear();
                      },
                      icon: const Icon(Icons.refresh))
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.center,
                  child: StreamBuilder<List<ProjectModel>>(
                      stream: _projectStream.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final List<ProjectModel?> projectList =
                              snapshot.data!;

                          if (projectList.isEmpty) {
                            // return const Text('No projects available.');
                            return const Duck(
                                status: "NO PROJECT DATA", content: "");
                          }
                          return _buildProject(projectList);
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
          ),
        ],
      ),
    );
  }

  Widget _buildProject(projectList) {
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
  }

  Widget _buildBody(index, projectList) {
    final ProjectModel project = projectList[index];
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Stack(
        children: [
          SizedBox(
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
                    title:
                        projectTypeBinaryValue(project.project_type).toString(),
                    size: 10,
                  ),
                  TextContent(
                    alignment: Alignment.center,
                    title: project.title,
                    color: Colors.yellow,
                  ),
                  TextContent(
                    alignment: Alignment.bottomCenter,
                    title: project.year_published,
                    size: 8,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
