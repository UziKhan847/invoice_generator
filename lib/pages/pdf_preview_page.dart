import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice_course.dart';
import 'package:markaz_umaza_invoice_generator/models/receipt.dart';
import 'package:markaz_umaza_invoice_generator/models/recipient.dart';
import 'package:markaz_umaza_invoice_generator/models/sender.dart';
import 'package:markaz_umaza_invoice_generator/pdf/pdf_generator.dart';
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {
  const PdfPreviewPage({
    super.key,
    this.receipt,
    required this.invoice,
    required this.sender,
    required this.recipient,
    required this.invoiceCourses,
  });

  final Receipt? receipt;
  final Invoice invoice;
  final Sender sender;
  final Recipient recipient;
  final Map<int, InvoiceCourse> invoiceCourses;

  @override
  Widget build(BuildContext context) {
    bool isInvoice = receipt == null;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isInvoice
            ? Theme.of(context).appBarTheme.backgroundColor
            : const Color(0xFF421070),
        title: const Text("PDF Preview"),
      ),
      body: PdfPreview(
          actionBarTheme: PdfActionBarTheme(
            height: 70,
            backgroundColor: isInvoice
                ? Theme.of(context).appBarTheme.backgroundColor
                : const Color(0xFF421070),
          ),
          build: (context) => PdfGenerator.generatePdf(
                receipt: receipt,
                invoice: invoice,
                sender: sender,
                recipient: recipient,
                invoiceCourses: invoiceCourses,
              )),
    );
  }
}
