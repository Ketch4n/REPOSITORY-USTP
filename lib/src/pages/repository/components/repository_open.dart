// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/snackbar.dart';
import 'package:repository_ustp/src/data/provider/user_session.dart';
import 'package:repository_ustp/src/pages/repository/components/file_preview.dart';
import 'package:repository_ustp/src/pages/repository/components/model/download_model.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/functions/generate_pdf.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/functions/get_files.dart';
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
                            trailing: IconButton(
                              icon: Icon(UserSession.type == 2 &&
                                      fileRef.name.endsWith("zip")
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () async {
                                if (UserSession.type == 2 &&
                                    fileRef.name.endsWith("zip")) {
                                  customSnackBar(
                                      context, 1, "Administrator Access Only");
                                } else {
                                  final url = await fileRef.getDownloadURL();
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
