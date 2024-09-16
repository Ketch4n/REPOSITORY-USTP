import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class FilePreview extends StatelessWidget {
  final String fileName;
  final String fileUrl;

  FilePreview({required this.fileName, required this.fileUrl});

  @override
  Widget build(BuildContext context) {
    if (fileName.endsWith('.jpg') || fileName.endsWith('.png')) {
      return Image.network(
        fileUrl,
        fit: BoxFit.scaleDown,
      );
    } else if (fileName.endsWith('.mp4')) {
      return VideoPlayerWidget(fileUrl: fileUrl);
    } else if (fileName.endsWith('.docx') || fileName.endsWith('.doc')) {
      return DocumentViewer(fileUrl: fileUrl);
    } else {
      return Center(child: Text('Unsupported file type'));
    }
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String fileUrl;

  VideoPlayerWidget({required this.fileUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.fileUrl)
      ..initialize().then((_) {
        setState(() {}); // Refresh UI after initialization
      });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : Center(child: CircularProgressIndicator());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class DocumentViewer extends StatelessWidget {
  final String fileUrl;

  DocumentViewer({required this.fileUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          if (await canLaunch(fileUrl)) {
            await launch(fileUrl);
          } else {
            throw 'Could not open document';
          }
        },
        child: Text('View Document'),
      ),
    );
  }
}
