import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

class FilePreview extends StatelessWidget {
  final String fileName;
  final String fileUrl;

  const FilePreview({super.key, required this.fileName, required this.fileUrl});

  @override
  Widget build(BuildContext context) {
    // Convert fileName to lowercase for consistent comparison
    final lowerCaseFileName = fileName.toLowerCase();

    if (lowerCaseFileName.endsWith('.jpg') ||
        lowerCaseFileName.endsWith('.png')) {
      return Image.network(
        fileUrl,
        fit: BoxFit.scaleDown,
      );
    } else if (lowerCaseFileName.endsWith('.mp4')) {
      return VideoPlayerWidget(fileUrl: fileUrl);
    } else if (lowerCaseFileName.endsWith('.docx') ||
        lowerCaseFileName.endsWith('.pdf')) {
      return DocumentViewer(fileUrl: fileUrl);
    } else {
      return const Center(child: Text('Unsupported file type'));
    }
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String fileUrl;

  const VideoPlayerWidget({super.key, required this.fileUrl});

  @override
  VideoPlayerWidgetState createState() => VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget> {
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
        : const Center(child: CircularProgressIndicator());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class DocumentViewer extends StatelessWidget {
  final String fileUrl;

  const DocumentViewer({super.key, required this.fileUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          final uri = Uri.parse(fileUrl); // Corrected here
          if (await canLaunch(uri.toString())) {
            // Launching the URL
            await launch(uri.toString());
          } else {
            throw 'Could not open document';
          }
        },
        child: const Text('View Document'),
      ),
    );
  }
}
