// import 'package:flutter/material.dart';
// import 'package:native_pdf_view/native_pdf_view.dart';
// import 'package:http/http.dart' as http;

// class PdfViewerPage extends StatefulWidget {
//   final String pdfUrl;

//   PdfViewerPage({required this.pdfUrl});

//   @override
//   _PdfViewerPageState createState() => _PdfViewerPageState();
// }

// class _PdfViewerPageState extends State<PdfViewerPage> {
//   PdfController? _pdfController;

//   @override
//   void initState() {
//     super.initState();
//     loadPdf();
//   }

//   Future<void> loadPdf() async {
//     final response = await http.get(Uri.parse(widget.pdfUrl));
//     if (response.statusCode == 200) {
//       final bytes = response.bodyBytes;
//       _pdfController = PdfController(document: PdfDocument.openData(bytes));
//       setState(() {});
//     }
//   }

//   @override
//   void dispose() {
//     _pdfController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("PDF Viewer")),
//       body: _pdfController == null
//           ? Center(child: CircularProgressIndicator())
//           : PdfView(controller: _pdfController!),
//     );
//   }
// }
