import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/course.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/models/recipient.dart';
import 'package:markaz_umaza_invoice_generator/models/sender.dart';
import 'package:markaz_umaza_invoice_generator/pdf/generate_pdf.dart';
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {
  const PdfPreviewPage({
    super.key,
    required this.invoice,
    required this.sender,
    required this.recipient,
    required this.courses,
    required this.showName,
  });

  final Invoice invoice;
  final Sender sender;
  final Recipient recipient;
  final Map<int, Course> courses;
  final bool showName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Preview"),
      ),
      body: PdfPreview(
          build: (context) => generatePdf(
                invoice: invoice,
                sender: sender,
                recipient: recipient,
                courses: courses,
                showName: showName,
              )),
    );
  }
}
