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

class PosterPages extends StatefulWidget {
  const PosterPages({
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
  State<PosterPages> createState() => _PosterPagesState();
}

class _PosterPagesState extends State<PosterPages> {
  bool isLoading = true; // Set initial loading state
  Reference? _imageReference; // Store a single image reference

  @override
  void initState() {
    super.initState();

    _getImageReference();
  }

  Future<void> _getImageReference() async {
    final ProjectModel project = widget.projectList[widget.index];
    final storage = FirebaseStorage.instance;

    final folderName =
        'repository/${project.id}/${project.poster}'; // Path to the image

    try {
      // Get a single image reference
      _imageReference = storage.ref(folderName);
      setState(() {
        isLoading = false; // Update loading state
      });
    } catch (e) {
      print('Error retrieving image: $e');
      setState(() => isLoading = false); // Update loading state on error
    }
  }

  @override
  Widget build(BuildContext context) {
    final ProjectModel project = widget.projectList[widget.index];

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 190,
        width: 190,
        child: Stack(
          children: [
            if (!isLoading &&
                _imageReference != null) // Display image if loaded
              FutureBuilder<String>(
                future: _imageReference!.getDownloadURL(),
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
                                  await _imageReference!.getDownloadURL();
                              await ViewedRepo.store(
                                project.id,
                                UserSession.id,
                                _imageReference!.name,
                              );
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => FilePreview(
                                        fileName: _imageReference!.name,
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
                              value: 0, child: Text('Fullscreen')),
                          if (UserSession.type == 0)
                            const PopupMenuItem<int>(
                                value: 1, child: Text('Source')),
                        ],
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(snapshot.data!,
                                  fit: BoxFit.cover),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                        child:
                            CircularProgressIndicator()); // Loading indicator
                  }
                },
              ),
            TextContent(
              alignment: Alignment.topCenter,
              title:
                  "${project.title}\n${projectTypeBinaryValue(project.project_type)}",
              size: 10,
            ),
            TextContent(
              alignment: Alignment.bottomCenter,
              title: project.year_published,
              size: 10,
            ),
          ],
        ),
      ),
    );
  }
}
