import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repository_ustp/src/components/duck_404.dart';
import 'package:repository_ustp/src/components/show_dialog.dart';
import 'package:repository_ustp/src/data/index/privacy_icon_value.dart';
import 'package:repository_ustp/src/data/index/project_index_value.dart';
import 'package:repository_ustp/src/data/provider/card_click_event.dart';
import 'package:repository_ustp/src/data/provider/click_event_keyword.dart';
import 'package:repository_ustp/src/pages/index/components/search_field.dart';
import 'package:repository_ustp/src/pages/index/components/search_field_controller.dart';
import 'package:repository_ustp/src/pages/projects/components/text_content.dart';
import 'package:repository_ustp/src/pages/projects/project_function.dart';
import 'package:repository_ustp/src/pages/projects/project_model.dart';
import 'package:repository_ustp/src/pages/repository/components/repository_add.dart';
import 'package:repository_ustp/src/utils/palette.dart';

class RepositoryPage extends StatefulWidget {
  const RepositoryPage({super.key, required this.projectType});

  final int projectType;

  @override
  State<RepositoryPage> createState() => _RepositoryPageState();
}

class _RepositoryPageState extends State<RepositoryPage> {
  final StreamController<List<ProjectModel>> _projectStream =
      StreamController<List<ProjectModel>>();

  final _searchController = SearchFieldController().search;

  @override
  void initState() {
    super.initState();

    _fetchProjects(CLickEventProjectType.quack, ClickEventProjectKeyword.quack,
        _searchController.text);
  }

  @override
  void dispose() {
    _projectStream.close();
    super.dispose();
  }

  // Method to fetch projects and reload
  void _fetchProjects(quackType, quackKeyword, search) {
    ProjectFunction.fetchProjects(
        _projectStream, quackType, quackKeyword, search);
  }

  // Method to reload the data
  void reload() {
    setState(() {
      _fetchProjects(CLickEventProjectType.quack,
          ClickEventProjectKeyword.quack, _searchController.text);
      // print(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Column(
            children: [
              Container(
                decoration: BoxDecoration(color: ColorPallete.grey),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: SearchField(reload: reload),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: MaterialButton(
                    color: Colors.blue,
                    onPressed: () {
                      // widget.callback(4);
                      // Navigator.pushNamed(context, '/repository/add');
                      showCustomDialog(context, const RepositoryAdd());
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Add New Project",
                          style: TextStyle(color: Colors.white),
                        ),
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Align(
                  alignment: Alignment.center,
                  child: StreamBuilder<List<ProjectModel>>(
                      stream: _projectStream.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final List<ProjectModel?> projectList =
                              snapshot.data!;

                          if (projectList.isEmpty) {
                            return const Duck(
                                status: "NO REPOSITORY FOLDERS YET",
                                content: "");
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
                                (index) =>
                                    _buildBody(index, projectList, context),
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
            ],
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
