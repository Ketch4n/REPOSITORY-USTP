import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:repository_ustp/src/components/duck_404.dart';
import 'package:repository_ustp/src/components/duck_access.dart';
import 'package:repository_ustp/src/data/index/project_index_value.dart';
import 'package:repository_ustp/src/data/index/project_semester.dart';
import 'package:repository_ustp/src/data/provider/card_click_event.dart';
import 'package:repository_ustp/src/data/provider/click_event_collection.dart';
import 'package:repository_ustp/src/data/provider/click_event_keyword.dart';
import 'package:repository_ustp/src/data/provider/search_suggestion.dart';
import 'package:repository_ustp/src/data/provider/show_top_items.dart';
import 'package:repository_ustp/src/data/provider/user_session.dart';
import 'package:repository_ustp/src/pages/index/components/card_list.dart';
import 'package:repository_ustp/src/pages/index/components/search_field.dart';
import 'package:repository_ustp/src/pages/index/components/search_field_controller.dart';
import 'package:repository_ustp/src/pages/projects/project_function.dart';
import 'package:repository_ustp/src/pages/projects/project_model.dart';
import 'package:repository_ustp/src/pages/repository/modules/hardbound_pages.dart';
import 'package:repository_ustp/src/pages/repository/modules/manuscript_pages.dart';
import 'package:repository_ustp/src/pages/repository/modules/poster_pages.dart';
import 'package:repository_ustp/src/pages/repository/modules/top_buttons.dart';
import 'package:repository_ustp/src/pages/repository/modules/video_pages.dart';
import 'package:repository_ustp/src/pages/repository/modules/zip_pages.dart';
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
  final searchSuggestion = SearchSuggestion();

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
    await ProjectFunction.fetchProjects(_projectStream, quackType, quackKeyword,
        quackCollection, search, searchSuggestion);
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
                  'Semester',
                  'Group Name',
                ],
                data: projects.map((project) {
                  return [
                    project.title,
                    project.year_published,
                    projectTypeBinaryValue(project.project_type),
                    projectSemesterBinaryValue(project.semester),
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
    return DefaultTabController(
      length: 5,
      child: Scaffold(
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
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: CardList(callback: reload),
                      ),
                    )
                  : const SizedBox(),
              _searchController.text.isNotEmpty
                  ? TabBar(
                      onTap: (value) {
                        // Handle the tab change
                        // You can update your state or perform any action based on the selected tab
                        switch (value) {
                          case 0:
                            ClickEventProjectCollection.quack = value;
                            reload();
                            break;
                          case 1:
                            ClickEventProjectCollection.quack = value;
                            reload();
                            break;
                          case 2:
                            ClickEventProjectCollection.quack = value;
                            reload();
                            break;
                          case 3:
                            ClickEventProjectCollection.quack = value;
                            reload();
                            break;
                          case 4:
                            ClickEventProjectCollection.quack = value;
                            reload();

                            break;
                        }
                      },
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: const [
                        Tab(text: 'All'),
                        Tab(text: 'Manuscript'),
                        Tab(text: 'Poster'),
                        Tab(text: 'Videos'),
                        Tab(text: 'Source Code'),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(height: 8),
              RepositoryTopButtons(
                  reload: () => reload(), toPDF: () => exportToPDF()),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Align(
                    alignment: Alignment.center,
                    child: StreamBuilder<List<ProjectModel>>(
                      stream: _projectStream.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final List<ProjectModel> projectList = snapshot.data!;
                          projects = projectList;

                          if (projectList.isEmpty) {
                            return Consumer<CLickEventProjectType>(
                              builder: (context, value, child) {
                                return Duck(
                                    status:
                                        projectTypeBinaryValue(value.quackNew),
                                    content: "No Repository Found !");
                              },
                            );
                          }

                          return Consumer<ClickEventProjectCollection>(
                              builder: (context, projectCollection, child) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                runAlignment: WrapAlignment.center,
                                runSpacing: 10.0,
                                spacing: 10.0,
                                children: projectCollection.quackNew == 0
                                    ? List.generate(
                                        projectList.length,
                                        (index) => buildBody(index, projectList,
                                            context, reload, widget.indexPage),
                                      )
                                    : projectCollection.quackNew == 1
                                        ? List.generate(
                                            projectList.length,
                                            (index) => ManuscriptPages(
                                              index: index,
                                              projectList: projectList,
                                              reload: reload,
                                              indexpage: widget.indexPage,
                                            ),
                                          )
                                        : projectCollection.quackNew == 2
                                            ? List.generate(
                                                projectList.length,
                                                (index) => PosterPages(
                                                  index: index,
                                                  projectList: projectList,
                                                  reload: reload,
                                                  indexpage: widget.indexPage,
                                                ),
                                              )
                                            : projectCollection.quackNew == 3
                                                ? List.generate(
                                                    projectList.length,
                                                    (index) => VideoPages(
                                                      index: index,
                                                      projectList: projectList,
                                                      reload: reload,
                                                      indexpage:
                                                          widget.indexPage,
                                                    ),
                                                  )
                                                : projectCollection
                                                                    .quackNew ==
                                                                4 &&
                                                            UserSession
                                                                    .type ==
                                                                0 ||
                                                        UserSession.type == 1
                                                    ? List.generate(
                                                        projectList.length,
                                                        (index) => ZipPages(
                                                            index: index,
                                                            projectList:
                                                                projectList,
                                                            reload: reload,
                                                            indexpage: widget
                                                                .indexPage))
                                                    : List.generate(
                                                        projectList.length,
                                                        (index) => const DuckNada(
                                                            status:
                                                                "Admin Access Only",
                                                            content:
                                                                "No access permission !")),
                              ),
                            );
                          });
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text("Error: ${snapshot.error}"),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
