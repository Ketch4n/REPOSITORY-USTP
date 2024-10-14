import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentViewer extends StatefulWidget {
  final String fileUrl;

  const DocumentViewer({super.key, required this.fileUrl});

  @override
  State<DocumentViewer> createState() => _DocumentViewerState();
}

class _DocumentViewerState extends State<DocumentViewer> {
  // String modifyUrlForViewer(String url) {
  //   return 'https://drive.google.com/file/d/1-I6VsotXivyuxq0sWOtVI7XMRWkw8V08/view?usp=sharing';
  // }
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: ElevatedButton(
    //     onPressed: () async {
    //       final modifiedUrl = modifyUrlForViewer(widget.fileUrl);
    //       final uri = Uri.parse(modifiedUrl);
    //       if (await canLaunch(uri.toString())) {
    //         await launch(
    //           uri.toString(),
    //           forceSafariVC: false,
    //           forceWebView: false,
    //         );
    //       } else {
    //         ScaffoldMessenger.of(context).showSnackBar(
    //           SnackBar(content: Text('Could not open document')),
    //         );
    //       }
    //     },
    //     child: const Text('View Document'),
    //   ),
    // );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter PDF Viewer'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(
        widget.fileUrl,
        key: _pdfViewerKey,
      ),
    );
  }
}