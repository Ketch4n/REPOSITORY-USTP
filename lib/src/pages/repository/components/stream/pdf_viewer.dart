import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentViewer extends StatelessWidget {
  final String fileUrl;

  const DocumentViewer({super.key, required this.fileUrl});

  String modifyUrlForViewer(String url) {
    return 'https://drive.google.com/file/d/1-I6VsotXivyuxq0sWOtVI7XMRWkw8V08/view?usp=sharing';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          final modifiedUrl = modifyUrlForViewer(fileUrl);
          final uri = Uri.parse(modifiedUrl);
          if (await canLaunch(uri.toString())) {
            await launch(
              uri.toString(),
              forceSafariVC: false,
              forceWebView: false,
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Could not open document')),
            );
          }
        },
        child: const Text('View Document'),
      ),
    );
  }
}
