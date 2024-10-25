import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repository_ustp/src/data/index/project_index_value.dart';
import 'package:repository_ustp/src/data/provider/project_id.dart';
import 'package:repository_ustp/src/data/provider/user_session.dart';
import 'package:repository_ustp/src/pages/projects/components/text_content.dart';
import 'package:repository_ustp/src/pages/projects/project_model.dart';
import 'package:repository_ustp/src/pages/repository/components/file_preview.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/functions/viewed_repo.dart';

class ZipPages extends StatefulWidget {
  const ZipPages({
    super.key,
    required this.index,
    required this.projectList,
    required this.reload,
    required this.indexpage,
  });

  final int index;
  final List<ProjectModel> projectList;
  final Function reload;
  final Function indexpage;

  @override
  State<ZipPages> createState() => _ZipPagesState();
}

class _ZipPagesState extends State<ZipPages> {
  bool isLoading = true;
  Reference? _zipReference;

  @override
  void initState() {
    super.initState();

    _getZipReference();
  }

  Future<void> _getZipReference() async {
    final ProjectModel project = widget.projectList[widget.index];
    final storage = FirebaseStorage.instance;

    final folderName =
        'repository/${project.id}/${project.zip}'; // Path to the video

    try {
      // Get a single video reference
      _zipReference = storage.ref(folderName);
      setState(() {
        isLoading = false; // Update loading state
      });
    } catch (e) {
      print('Error retrieving video: $e');
      setState(() => isLoading = false); // Update loading state on error
    }
  }

  @override
  Widget build(BuildContext context) {
    final ProjectModel project = widget.projectList[widget.index];

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 160,
        width: 160,
        child: Stack(
          children: [
            if (!isLoading && _zipReference != null) // Display video if loaded
              FutureBuilder<String>(
                future: _zipReference!.getDownloadURL(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return InkWell(
                      child: PopupMenuButton<int>(
                          onSelected: (value) async {
                            switch (value) {
                              case 0:
                                final url =
                                    await _zipReference!.getDownloadURL();
                                await ViewedRepo.store(
                                  project.id,
                                  UserSession.id,
                                  _zipReference!.name,
                                );
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => FilePreview(
                                          fileName: _zipReference!.name,
                                          fileUrl: url,
                                        )));
                                break;
                              case 1:
                                widget.indexpage(5);
                                Provider.of<ProjectIDClickEvent>(context,
                                        listen: false)
                                    .selectProject(project);
                                break;
                            }
                          },
                          itemBuilder: (BuildContext context) => [
                                const PopupMenuItem<int>(
                                    value: 0, child: Text('Extract')),
                                const PopupMenuItem<int>(
                                    value: 1, child: Text('Source')),
                              ],
                          child: Image.asset("assets/folder.png")),
                    );
                  } else {
                    return const Center(
                        child:
                            CircularProgressIndicator()); // Loading indicator
                  }
                },
              ),
            TextContent(
              alignment: Alignment.center,
              title: project.title,
              size: 10,
              color: Colors.black87,
            ),
            TextContent(
              alignment: Alignment.bottomCenter,
              title:
                  "${projectTypeBinaryValue(project.project_type)}\n${project.year_published}",
              size: 10,
              color: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }
}
