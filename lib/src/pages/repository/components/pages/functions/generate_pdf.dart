import 'package:repository_ustp/src/pages/repository/components/model/download_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> generatePdf(List<Download> downloads) async {
  final pdf = pw.Document();

  // Add a page to the PDF
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Project Downloads Report',
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 20),
            // Table header
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Email',
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold)),
                pw.Text('Downloads',
                    style: pw.TextStyle(
                        fontSize: 18, fontWeight: pw.FontWeight.bold)),
              ],
            ),
            pw.Divider(),
            // Iterate through downloads and display each user's email and number of downloads
            ...downloads.map((download) {
              return pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(download.email,
                      style: const pw.TextStyle(fontSize: 16)),
                  pw.Text(download.downloads.toString(),
                      style: const pw.TextStyle(fontSize: 16)),
                ],
              );
            }),
          ],
        );
      },
    ),
  );

  // Save PDF to file or preview it using the Printing package
  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save());
}
