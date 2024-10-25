// ignore_for_file: use_build_context_synchronously

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/confirmation_dialog.dart';
import 'package:repository_ustp/src/components/snackbar.dart';
import 'package:repository_ustp/src/data/provider/user_session.dart';
import 'package:repository_ustp/src/pages/repository/components/file_preview.dart';
import 'package:repository_ustp/src/pages/repository/components/model/download_model.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/functions/collection/update.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/functions/collection/update_null.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/functions/generate_pdf.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/functions/get_files.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/functions/upload_files.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/functions/viewed_repo.dart';
import 'package:repository_ustp/src/pages/repository/components/stream/download_stream.dart';
import 'package:url_launcher/url_launcher.dart';

class RepositoryOpen extends StatefulWidget {
  const RepositoryOpen({super.key, required this.projectID});
  final int projectID;

  @override
  State<RepositoryOpen> createState() => _RepositoryOpenState();
}

class _RepositoryOpenState extends State<RepositoryOpen> {
  late DownloadStream _downloadStream;
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

  Future<void> _deleteFile(String fileName) async {
    String fileExtension = "";
    int type;
    if (fileName.contains(".")) {
      fileExtension =
          fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();
    }

    switch (fileExtension) {
      case "jpg":
      case "jpeg":
      case "png":
        type = 2;
        break;
      case "pdf":
        type = 1;
        break;
      case "mp4":
        type = 3;
        break;
      default:
        type = 4;
        break;
    }

    try {
      final fileRef = FirebaseStorage.instance
          .ref('repository/${widget.projectID}/$fileName');
      final value = await confirmationDialog(
          context,
          "Confirm File Deletion ?",
          "This file will be removed in the repository",
          () => fileRef.delete());
      if (value == true) {
        updateCollectionNULL(context, widget.projectID, type);
        customSnackBar(context, 0, "$fileName deleted successfully.");
        Navigator.of(context).pop();
      }
    } catch (e) {
      customSnackBar(context, 1, "Error deleting $fileName: $e");
    }
  }

  Future<void> _replaceFile(String fileName) async {
    int type;
    String? newFileName;
    final fileRef = FirebaseStorage.instance
        .ref('repository/${widget.projectID}/$fileName');

    // Determine file type and prompt user for selection
    if (fileName.endsWith("jpg") ||
        fileName.endsWith("jpeg") ||
        fileName.endsWith("png")) {
      type = 2;
      await PagesUploadFiles.selectImg(context);
      newFileName = PagesUploadFiles.selectedImg?.name; // Use null safety
    } else if (fileName.endsWith("pdf")) {
      type = 1;
      await PagesUploadFiles.selectDoc(context);
      newFileName = PagesUploadFiles.selectedDoc?.name;
    } else if (fileName.endsWith("mp4")) {
      type = 3;
      await PagesUploadFiles.selectClip(context);
      newFileName = PagesUploadFiles.selectedClip?.name;
    } else {
      type = 4;
      await PagesUploadFiles.selectZip(context);
      newFileName = PagesUploadFiles.selectedZip?.name;
    }

    // Check if a new file was selected
    if (newFileName != null) {
      try {
        // Delete the existing file
        await fileRef.delete();

        // Update the collection with the new file details
        await updateCollectionFile(
            context, widget.projectID, type, newFileName);

        // Upload the new file
        await PagesUploadFiles.uploadFile(context, widget.projectID);
      } catch (e) {
        // Handle errors (e.g., file deletion or upload issues)
        customSnackBar(context, 1, "Error replacing file: $e");
      }
    } else {
      customSnackBar(context, 1, "No file selected for replacement.");
    }
  }

  @override
  void initState() {
    super.initState();
    _loadFiles();
    _downloadStream = DownloadStream();
    _downloadStream.fetchDownloads(widget.projectID);
  }

  @override
  void dispose() {
    _downloadStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
          constraints: const BoxConstraints(maxHeight: 500, maxWidth: 500),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Center(child: CircularProgressIndicator()));
    }
    return Container(
      constraints: const BoxConstraints(maxHeight: 500, maxWidth: 500),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: PagesGetFiles.fileReferences.isEmpty
          ? const Center(child: Text("No files available"))
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
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
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                UserSession.type == 0
                                    ? PopupMenuButton<int>(
                                        onSelected: (value) async {
                                          switch (value) {
                                            case 1:
                                              _replaceFile(fileRef.name);
                                              break;
                                            case 2:
                                              _deleteFile(fileRef.name);
                                              break;
                                          }
                                        },
                                        icon: const Icon(Icons.menu),
                                        itemBuilder: (BuildContext context) => [
                                          const PopupMenuItem<int>(
                                            value: 1,
                                            child: Text('Replace'),
                                          ),
                                          const PopupMenuItem<int>(
                                            value: 2,
                                            child: Text('Delete'),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                                IconButton(
                                  icon: Icon(UserSession.type == 2 &&
                                          fileRef.name.endsWith("zip")
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () async {
                                    if (UserSession.type == 2 &&
                                        fileRef.name.endsWith("zip")) {
                                      customSnackBar(context, 1,
                                          "Administrator Access Only");
                                    } else {
                                      final url =
                                          await fileRef.getDownloadURL();
                                      await ViewedRepo.store(
                                        widget.projectID,
                                        UserSession.id,
                                        fileRef.name,
                                      );
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => FilePreview(
                                            fileName: fileRef.name,
                                            fileUrl: url,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                StreamBuilder<List<Download>>(
                    stream: _downloadStream.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("Counting...");
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Text("Total Views: 0");
                      }
                      List<Download> downloads = snapshot.data!;
                      int totalDownloads = snapshot.data!
                          .fold(0, (sum, download) => sum + download.downloads);
                      return Column(
                        children: [
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Total Views :"),
                                const SizedBox(width: 10),
                                Text(totalDownloads.toString()),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          MaterialButton(
                            color: Colors.grey,
                            onPressed: () {
                              if (UserSession.type == 0) {
                                generatePdf(downloads);
                              } else {
                                customSnackBar(
                                    context, 1, "Administrator Access Only");
                              }
                            },
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Report",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(width: 10),
                                Icon(
                                  Icons.picture_as_pdf,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ],
            ),
    );
  }
}
