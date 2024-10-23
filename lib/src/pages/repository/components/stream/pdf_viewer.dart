import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pdfx/pdfx.dart';

class PDFViewer extends StatefulWidget {
  const PDFViewer({super.key, required this.fileUrl});
  final fileUrl;

  @override
  State<PDFViewer> createState() => _PDFViewerState();
}

class _PDFViewerState extends State<PDFViewer> {
  PdfControllerPinch? pdfController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (Duration timeStamp) async {
        final String url = widget.fileUrl;
        final Uri parsedUri = Uri.parse(url);
        final Response res = await get(parsedUri);
        final Future<PdfDocument> doc = PdfDocument.openData(res.bodyBytes);
        pdfController = PdfControllerPinch(document: doc);
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    pdfController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pdfController != null
          ? PdfViewPinch(controller: pdfController!)
          : const CircularProgressIndicator(),
    );
  }
}
