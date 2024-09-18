import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:repository_ustp/src/components/confirmation_dialog.dart';
import 'package:repository_ustp/src/components/duck_404.dart';
import 'package:repository_ustp/src/components/show_dialog.dart';
import 'package:repository_ustp/src/data/index/privacy_icon_value.dart';
import 'package:repository_ustp/src/data/provider/card_click_event.dart';
import 'package:repository_ustp/src/data/provider/click_event_keyword.dart';
import 'package:repository_ustp/src/pages/index/components/search_field.dart';
import 'package:repository_ustp/src/pages/index/components/search_field_controller.dart';
import 'package:repository_ustp/src/pages/projects/components/text_content.dart';
import 'package:repository_ustp/src/pages/projects/project_function.dart';
import 'package:repository_ustp/src/pages/projects/project_model.dart';
import 'package:repository_ustp/src/pages/repository/components/repository_open.dart';
import 'package:repository_ustp/src/pages/repository/components/repository_update.dart';
import 'package:repository_ustp/src/pages/repository/modules/top_buttons.dart';
import 'package:repository_ustp/src/pages/repository/repository_function.dart';
import 'package:repository_ustp/src/utils/palette.dart';
import 'package:pdf/widgets.dart' as pw;

class RepositoryPage extends StatefulWidget {
  const RepositoryPage({super.key, required this.projectType});

  final int projectType;

  @override
  State<RepositoryPage> createState() => _RepositoryPageState();
}

class _RepositoryPageState extends State<RepositoryPage> {
  final StreamController<List<ProjectModel>> _projectStream =
      StreamController<List<ProjectModel>>();

  List<ProjectModel> projects = [];

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
  void _fetchProjects(quackType, quackKeyword, search) async {
    await ProjectFunction.fetchProjects(
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

  Future<void> exportToPDF() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text(
                'Project Repository',
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
                textAlign: pw.TextAlign.center,
              ),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                headers: [
                  'Title',
                  'Year Published',
                  'Project Type',
                  'Group Name',
                ],
                data: projects.map((project) {
                  return [
                    project.title,
                    project.year_published,
                    project.project_type,
                    project.group_name,
                  ];
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
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
              RepositoryTopButtons(
                  reload: () => reload(), toPDF: () => exportToPDF()),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Align(
                    alignment: Alignment.center,
                    child: StreamBuilder<List<ProjectModel>>(
                        stream: _projectStream.stream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final List<ProjectModel> projectList =
                                snapshot.data!;
                            projects = projectList;

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
                                  (index) => _buildBody(
                                      index, projectList, context, reload),
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
            ],
          ),
        ),
      ],
    );
  }
}

Widget _buildBody(index, projectList, context, reload) {
  final ProjectModel project = projectList[index];

  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: SizedBox(
      height: 130,
      width: 140,
      child: InkWell(
        onDoubleTap: () {
          showCustomDialog(context, RepositoryOpen(projectID: project.id));
        },
        child: PopupMenuButton<int>(
          onSelected: (value) async {
            switch (value) {
              case 0:
                showCustomDialog(
                    context, RepositoryOpen(projectID: project.id));
                break;
              case 1:
                showCustomDialog(
                    context,
                    RepositoryUpdate(
                      reload: reload,
                      instance: project,
                    ));
                break;
              case 2:
                const title = "Delete this Project ?";
                const content =
                    "this will also delete Authors and Project Data";
                confirmationDialog(context, title, content, () {
                  RepositoryFunction.deleteProject(context, project.id.toInt())
                      .then((value) => reload());
                });

                break;
            }
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem<int>(
              value: 0,
              child: Text('Open'),
            ),
            const PopupMenuItem<int>(
              value: 1,
              child: Text('Edit'),
            ),
            const PopupMenuItem<int>(
              value: 2,
              child: Text('Delete'),
            ),
          ],
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                "assets/folder.png",
              ),
              Align(
                alignment: Alignment.bottomRight,
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
    ),
  );
}
