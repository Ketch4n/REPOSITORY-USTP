import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:archive/archive.dart';

class ZipFileViewer extends StatefulWidget {
  final String url;

  const ZipFileViewer({super.key, required this.url});

  @override
  ZipFileViewerState createState() => ZipFileViewerState();
}

class ZipFileViewerState extends State<ZipFileViewer> {
  List<String> fileNames = [];

  @override
  void initState() {
    super.initState();
    _fetchAndViewZip(widget.url);
  }

  Future<void> _fetchAndViewZip(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        _extractZip(bytes);
      } else {
        throw Exception('Failed to load ZIP file');
      }
    } catch (e) {
      // Handle errors (e.g., show a dialog)
      print('Error: $e');
      // Optionally, display an error message in the UI
      setState(() {
        fileNames = ['Error: ${e.toString()}'];
      });
    }
  }

  void _extractZip(Uint8List bytes) {
    final archive = ZipDecoder().decodeBytes(bytes);
    setState(() {
      fileNames = archive.map((file) => file.name).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View ZIP Contents'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (fileNames.isEmpty)
              const CircularProgressIndicator(), // Show a loader while fetching
            if (fileNames.isNotEmpty) ...[
              const Text('Files in ZIP:'),
              for (var name in fileNames) Text(name),
            ],
          ],
        ),
      ),
    );
  }
}
