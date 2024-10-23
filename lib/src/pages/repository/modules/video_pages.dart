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
import 'package:repository_ustp/src/utils/palette.dart';

class VideoPages extends StatefulWidget {
  const VideoPages({
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
  State<VideoPages> createState() => _VideoPagesState();
}

class _VideoPagesState extends State<VideoPages> {
  bool isLoading = true;
  Reference? _videoReference;

  @override
  void initState() {
    super.initState();

    _getVideoReference();
  }

  Future<void> _getVideoReference() async {
    final ProjectModel project = widget.projectList[widget.index];
    final storage = FirebaseStorage.instance;

    final folderName =
        'repository/${project.id}/${project.video}'; // Path to the video

    try {
      // Get a single video reference
      _videoReference = storage.ref(folderName);
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
      child: Container(
        decoration: BoxDecoration(
            color: ColorPallete.grey,
            border: Border.all(width: 1),
            borderRadius: BorderRadius.circular(10)),
        height: 180,
        width: 160,
        child: Stack(
          children: [
            if (!isLoading &&
                _videoReference != null) // Display video if loaded
              FutureBuilder<String>(
                future: _videoReference!.getDownloadURL(),
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
                                  await _videoReference!.getDownloadURL();
                              await ViewedRepo.store(
                                project.id,
                                UserSession.id,
                                _videoReference!.name,
                              );
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => FilePreview(
                                        fileName: _videoReference!.name,
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
                              value: 0, child: Text('Play')),
                          if (UserSession.type == 0)
                            const PopupMenuItem<int>(
                                value: 1, child: Text('Source')),
                        ],
                        child: const Column(
                          children: [
                            Expanded(
                                child: Center(
                                    child: Icon(
                              Icons.play_circle,
                              size: 90,
                              color: Colors.blue,
                            )))
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
