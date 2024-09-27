// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:repository_ustp/src/data/provider/user_session.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/functions/get_files.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/functions/viewed_repo.dart';
import 'package:url_launcher/url_launcher.dart';

class RepositoryOpen extends StatefulWidget {
  const RepositoryOpen({super.key, required this.projectID});
  final int projectID;

  @override
  State<RepositoryOpen> createState() => _RepositoryOpenState();
}

class _RepositoryOpenState extends State<RepositoryOpen> {
  // void uploadFile(context) async {
  //   // Pick a file
  //   final result = await FilePicker.platform.pickFiles();
  //   if (result == null || result.files.isEmpty) return;

  //   final file = result.files.single;

  //   // Access file bytes
  //   final Uint8List fileBytes = file.bytes!;

  //   // Define file name and create a reference
  //   final projectID = widget.projectID;
  //   final fileName = file.name;
  //   final storageRef =
  //       FirebaseStorage.instance.ref().child('uploads/$projectID/$fileName');

  //   try {
  //     // Upload file bytes
  //     await storageRef.putData(fileBytes);
  //     // print('File uploaded successfully');
  //     _getFileRef();
  //     customSnackBar(context, 0, "File uploaded successfully");
  //   } catch (e) {
  //     print('Error uploading file: $e');
  //     // customSnackBar(context, 0, "File uploaded successfully");
  //   }
  // }
  bool isLoading = true;

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url); // Use parse for web URLs

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri); // Corrected this line
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _loadFiles() async {
    await PagesGetFiles.getFileRef(widget.projectID);
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadFiles();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
          constraints: const BoxConstraints(maxHeight: 400, maxWidth: 400),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Center(child: CircularProgressIndicator()));
    }
    return Container(
      // height: 800,
      // width: 800,
      constraints: const BoxConstraints(maxHeight: 400, maxWidth: 400),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: PagesGetFiles.fileReferences.isEmpty
          ? const Center(child: Text("No files available"))
          : Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Text("REPOSITORY FILES"),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: PagesGetFiles.fileReferences.length,
                      itemBuilder: (context, index) {
                        final fileRef = PagesGetFiles.fileReferences[index];
                        return Card(
                          child: ListTile(
                            title: Text(fileRef.name),

                            // onTap: () async {
                            //   try {
                            //     final url = await fileRef.getDownloadURL();
                            //     showDialog(
                            //       context: context,
                            //       builder: (context) => AlertDialog(
                            //         title: Text(fileRef.name),
                            //         content: FilePreview(
                            //             fileName: fileRef.name, fileUrl: url),
                            //         actions: <Widget>[
                            //           TextButton(
                            //             child: const Text('Close'),
                            //             onPressed: () {
                            //               Navigator.of(context).pop();
                            //             },
                            //           ),
                            //         ],
                            //       ),
                            //     );
                            //   } catch (e) {
                            //     print('Error fetching file URL: $e');
                            //   }
                            // },
                            trailing: IconButton(
                              icon: const Icon(Icons.download),
                              onPressed: () async {
                                final url = await fileRef.getDownloadURL();
                                ViewedRepo.store(
                                  widget.projectID.toInt(),
                                  UserSession.id.toInt(),
                                  fileRef.name.toString(),
                                );

                                _launchURL(url);
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
