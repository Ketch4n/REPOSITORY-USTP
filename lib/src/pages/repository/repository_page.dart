import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:repository_ustp/src/components/confirmation_dialog.dart';
import 'package:repository_ustp/src/components/duck_404.dart';
import 'package:repository_ustp/src/components/show_dialog.dart';
import 'package:repository_ustp/src/data/index/project_index_value.dart';
import 'package:repository_ustp/src/data/provider/card_click_event.dart';
import 'package:repository_ustp/src/data/provider/click_event_collection.dart';
import 'package:repository_ustp/src/data/provider/click_event_keyword.dart';
import 'package:repository_ustp/src/data/provider/index_menu_item.dart';
import 'package:repository_ustp/src/data/provider/project_id.dart';
import 'package:repository_ustp/src/data/provider/project_purpose.dart';
import 'package:repository_ustp/src/data/provider/show_top_items.dart';
import 'package:repository_ustp/src/data/provider/user_session.dart';
import 'package:repository_ustp/src/pages/index/components/card_list.dart';
import 'package:repository_ustp/src/pages/index/components/search_field.dart';
import 'package:repository_ustp/src/pages/index/components/search_field_controller.dart';
import 'package:repository_ustp/src/pages/index/index_page.dart';
import 'package:repository_ustp/src/pages/projects/components/text_content.dart';
import 'package:repository_ustp/src/pages/projects/project_function.dart';
import 'package:repository_ustp/src/pages/projects/project_model.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/functions/get_files.dart';
import 'package:repository_ustp/src/pages/repository/components/repository_open.dart';
import 'package:repository_ustp/src/pages/repository/components/repository_update.dart';
import 'package:repository_ustp/src/pages/repository/modules/top_buttons.dart';
import 'package:repository_ustp/src/pages/repository/repository_function.dart';
import 'package:repository_ustp/src/utils/palette.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:repository_ustp/src/utils/screen_breakpoint.dart';

class RepositoryPage extends StatefulWidget {
  const RepositoryPage(
      {super.key, required this.projectType, required this.indexPage});

  final int projectType;
  final Function indexPage;

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
  void _fetchProjects(quackType, quackKeyword, quackCollection, search) async {
    await ProjectFunction.fetchProjects(
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
                    projectTypeBinaryValue(project.project_type),
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
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Scaffold(
          body: Consumer<ShowTopItems>(builder: (context, value, child) {
            return Column(
              children: [
                value.isShow || width > tabletBreakpoint
                    ? Container(
                        decoration: BoxDecoration(color: ColorPallete.grey),
                        child: SearchField(reload: reload),
                      )
                    : const SizedBox(),
                value.isShow || width > tabletBreakpoint
                    ? Container(
                        decoration: BoxDecoration(color: ColorPallete.grey),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: CardList(callback: reload),
                        ),
                      )
                    : const SizedBox(),
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
                                return Consumer<CLickEventProjectType>(
                                    builder: (context, value, child) {
                                  return Duck(
                                      status: projectTypeBinaryValue(
                                          value.quackNew),
                                      content: "No Repository Found !");
                                });
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
                                    (index) => _buildBody(index, projectList,
                                        context, reload, widget.indexPage),
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
            );
          }),
        ),
      ],
    );
  }
}

Widget _buildBody(index, projectList, context, reload, indexpage) {
  final ProjectModel project = projectList[index];

  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: SizedBox(
      height: 190,
      width: 140,
      child: InkWell(
        onDoubleTap: () {
          // showCustomDialog(context, RepositoryOpen(projectID: project.id));
          indexpage(5);
          Provider.of<ProjectIDClickEvent>(context, listen: false)
              .selectProject(project);
        },
        child: PopupMenuButton<int>(
          onSelected: (value) async {
            switch (value) {
              case 0:
                // showCustomDialog(
                //     context, RepositoryOpen(projectID: project.id));
                indexpage(5);
                Provider.of<ProjectIDClickEvent>(context, listen: false)
                    .selectProject(project);
                break;
              case 1:
                ProjectPurpose.quack = 1;
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RepositoryUpdate(
                      reload: reload,
                      instance: project,
                    ),
                  ),
                );
                break;
              case 2:
                const title = "Delete this Project ?";
                const content =
                    "this will also delete Authors and Project Data";
                var quack =
                    await confirmationDialog(context, title, content, () {
                  RepositoryFunction.deleteProject(context, project.id.toInt())
                      .then((value) => reload());
                });
                if (quack == true) {
                  await PagesGetFiles.deleteFolder('${project.id}');
                }

                break;
            }
          },
          itemBuilder: (BuildContext context) => [
            const PopupMenuItem<int>(
              value: 0,
              child: Text('Open'),
            ),
            if (UserSession.type == 0)
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Edit'),
              ),
            if (UserSession.type == 0)
              const PopupMenuItem<int>(
                value: 2,
                child: Text('Delete'),
              ),
          ],
          child: Stack(
            children: [
              Image.asset("assets/hardbound.png"),
              // Positioned(
              //   right: 10,
              //   bottom: 5,
              //   child: Align(
              //     alignment: Alignment.bottomRight,
              //     child: projectPrivacyValue(project.privacy, context),
              //   ),
              // ),
              TextContent(
                alignment: Alignment.topCenter,
                title:
                    "${projectTypeBinaryValue(project.project_type).toString()}\n${project.year_published}",
                size: 10,
              ),
              TextContent(
                alignment: Alignment.center,
                title: project.title,
                color: Colors.yellow,
              ),
              TextContent(
                title: project.group_name,
                size: 8,
                alignment: Alignment.bottomCenter,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
