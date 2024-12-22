import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repository_ustp/src/components/confirmation_dialog.dart';
import 'package:repository_ustp/src/data/index/project_index_value.dart';
import 'package:repository_ustp/src/data/provider/click_event_collection.dart';
import 'package:repository_ustp/src/data/provider/project_id.dart';
import 'package:repository_ustp/src/data/provider/project_purpose.dart';
import 'package:repository_ustp/src/data/provider/user_session.dart';
import 'package:repository_ustp/src/pages/projects/components/text_content.dart';
import 'package:repository_ustp/src/pages/projects/project_model.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/functions/get_files.dart';
import 'package:repository_ustp/src/pages/repository/components/repository_update.dart';
import 'package:repository_ustp/src/pages/repository/repository_function.dart';

Widget buildBody(index, projectList, context, reload, indexpage) {
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
          child: Consumer<ClickEventProjectCollection>(
              builder: (context, value, child) {
            return Stack(
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

                value.quackNew == 0
                    ? TextContent(
                        title: project.group_name,
                        size: 10,
                        alignment: Alignment.bottomCenter,
                      )
                    : value.quackNew == 1
                        ? const Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 5.0),
                              child: Icon(
                                Icons.document_scanner,
                                size: 30,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : value.quackNew == 2
                            ? const Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 5.0),
                                  child: Icon(
                                    Icons.photo,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : value.quackNew == 3
                                ? const Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 5.0),
                                      child: Icon(
                                        Icons.play_circle,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : const Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 5.0),
                                      child: Icon(
                                        Icons.folder_zip,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
              ],
            );
          }),
        ),
      ),
    ),
  );
}
