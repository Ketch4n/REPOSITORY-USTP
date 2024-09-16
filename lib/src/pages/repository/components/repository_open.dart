// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/snackbar.dart';
import 'package:repository_ustp/src/pages/repository/components/file_preview.dart';
import 'package:url_launcher/url_launcher.dart';

class RepositoryOpen extends StatefulWidget {
  const RepositoryOpen({super.key, required this.projectID});
  final int projectID;

  @override
  State<RepositoryOpen> createState() => _RepositoryOpenState();
}

class _RepositoryOpenState extends State<RepositoryOpen> {
  List<Reference> _fileReferences = [];

  Future<void> _getFileRef() async {
    final storage = FirebaseStorage.instance;
    final projectID = widget.projectID;
    final folderName = 'uploads/$projectID';

    try {
      final listResult = await storage.ref(folderName).list();
      setState(() {
        _fileReferences = listResult.items;
      });
    } catch (e) {
      print('Error listing files: $e');
    }
  }

  void uploadFile(context) async {
    // Pick a file
    final result = await FilePicker.platform.pickFiles();
    if (result == null || result.files.isEmpty) return;

    final file = result.files.single;

    // Access file bytes
    final Uint8List fileBytes = file.bytes!;

    // Define file name and create a reference
    final projectID = widget.projectID;
    final fileName = file.name;
    final storageRef =
        FirebaseStorage.instance.ref().child('uploads/$projectID/$fileName');

    try {
      // Upload file bytes
      await storageRef.putData(fileBytes);
      // print('File uploaded successfully');
      _getFileRef();
      customSnackBar(context, 0, "File uploaded successfully");
    } catch (e) {
      print('Error uploading file: $e');
      // customSnackBar(context, 0, "File uploaded successfully");
    }
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();

    _getFileRef();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 800,
      // width: 800,
      constraints: const BoxConstraints(maxHeight: 800, maxWidth: 800),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            uploadFile(context);
          },
          child: const Icon(Icons.add),
        ),
        body: Container(
          constraints: const BoxConstraints(maxHeight: 800, maxWidth: 800),
          padding: const EdgeInsets.all(8.0),
          child: _fileReferences.isEmpty
              ? const Center(child: Text("No files available"))
              : ListView.builder(
                  itemCount: _fileReferences.length,
                  itemBuilder: (context, index) {
                    final fileRef = _fileReferences[index];
                    return ListTile(
                      title: Text(fileRef.name),
                      onTap: () async {
                        try {
                          final url = await fileRef.getDownloadURL();
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(fileRef.name),
                              content: FilePreview(
                                  fileName: fileRef.name, fileUrl: url),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Close'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          );
                        } catch (e) {
                          print('Error fetching file URL: $e');
                        }
                      },
                      trailing: IconButton(
                        icon: const Icon(Icons.download),
                        onPressed: () async {
                          final url = await fileRef.getDownloadURL();

                          _launchURL(url);
                        },
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
