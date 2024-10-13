import 'package:flutter/material.dart';
import 'package:repository_ustp/src/pages/repository/components/stream/image_viewer.dart';
import 'package:repository_ustp/src/pages/repository/components/stream/pdf_viewer.dart';
import 'package:repository_ustp/src/pages/repository/components/stream/video_player.dart';

class FilePreview extends StatelessWidget {
  final String fileName;
  final String fileUrl;

  const FilePreview({super.key, required this.fileName, required this.fileUrl});

  @override
  Widget build(BuildContext context) {
    final lowerCaseFileName = fileName.toLowerCase();

    if (lowerCaseFileName.endsWith('.jpg') ||
        lowerCaseFileName.endsWith('.png')) {
      return ImagePreview(fileUrl: fileUrl);
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
