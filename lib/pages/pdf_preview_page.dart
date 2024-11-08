import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/pdf/generate_pdf.dart';
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {
  const PdfPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Preview"),
      ),
      body: PdfPreview(build: (context) => generatePdf()),
    );
  }
}
