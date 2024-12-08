import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/course.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice_course.dart';
import 'package:markaz_umaza_invoice_generator/models/receipt.dart';
import 'package:markaz_umaza_invoice_generator/models/recipient.dart';
import 'package:markaz_umaza_invoice_generator/models/sender.dart';
import 'package:markaz_umaza_invoice_generator/pdf/generate_pdf.dart';
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {
  const PdfPreviewPage({
    super.key,
    required this.isInvoice,
    this.receipt,
    required this.invoice,
    required this.sender,
    required this.recipient,
    required this.invoiceCourses,
  });

  final bool isInvoice;
  final Receipt? receipt;
  final Invoice invoice;
  final Sender sender;
  final Recipient recipient;
  final Map<int, InvoiceCourse> invoiceCourses;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isInvoice
            ? Theme.of(context).appBarTheme.backgroundColor
            : const Color(0xFF421070),
        title: const Text("PDF Preview"),
      ),
      body: PdfPreview(
          build: (context) => generatePdf(
                isInvoice: isInvoice,
                receipt: receipt,
                invoice: invoice,
                sender: sender,
                recipient: recipient,
                invoiceCourses: invoiceCourses,
              )),
    );
  }
}
