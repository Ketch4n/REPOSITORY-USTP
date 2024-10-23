// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:repository_ustp/src/components/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentViewer extends StatefulWidget {
  final String fileUrl;

  const DocumentViewer({super.key, required this.fileUrl});

  @override
  State<DocumentViewer> createState() => _DocumentViewerState();
}

class _DocumentViewerState extends State<DocumentViewer> {
  String modifyUrlForViewer(String url) {
    return widget.fileUrl;
  }

  viewDocs() async {
    final modifiedUrl = modifyUrlForViewer(widget.fileUrl);
    final uri = Uri.parse(modifiedUrl);
    if (await canLaunch(uri.toString())) {
      await launch(
        uri.toString(),
        forceSafariVC: false,
        forceWebView: true,
      );
    } else {
      customSnackBar(context, 1, 'Could not open document');
    }
  }

  @override
  void initState() {
    viewDocs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: MaterialButton(
        color: Colors.blue,
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text(
          "Back to Recent Page",
          style: TextStyle(color: Colors.white),
        ),
      )),
    );
  }
}
