import 'dart:io';

import 'package:flutter/services.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice_course.dart';
import 'package:markaz_umaza_invoice_generator/models/profile.dart';
import 'package:markaz_umaza_invoice_generator/models/receipt.dart';
import 'package:markaz_umaza_invoice_generator/models/recipient.dart';
import 'package:markaz_umaza_invoice_generator/models/sender.dart';
import 'package:markaz_umaza_invoice_generator/pdf/pdf_components.dart';
import 'package:markaz_umaza_invoice_generator/pdf/pdf_margins.dart';
import 'package:markaz_umaza_invoice_generator/pdf/pdf_page_sections.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfGenerator {
  static Future<Uint8List> generatePdf({
    required Profile profile,
    Receipt? receipt,
    required Invoice invoice,
    required Sender sender,
    required Recipient recipient,
    required Map<int, InvoiceCourse> invoiceCourses,
  }) async {
    final pdf = pw.Document();

    // Load Logo
    final logoUrl = profile.logoUrl;
    final dir = await getTemporaryDirectory();
    final file = File("${dir.path}/$logoUrl");

    Uint8List imageBytes;

    if (logoUrl != null && await file.exists()) {
      imageBytes = await file.readAsBytes();
    } else {
      final img = await rootBundle.load("assets/images/default_logo.png");
      imageBytes = img.buffer.asUint8List();
    }

    pw.Image logo = pw.Image(pw.MemoryImage(imageBytes));

    pdf.addPage(pw.Page(build: (context) {
      bool isInvoice = receipt == null;

      return pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.center,
        children: [
          PdfPageSections.buildHeader(logo, profile, isInvoice),
          PdfMargins.vertical60,
          PdfPageSections.buildRecipientDetails(
              recipient, invoice, receipt, isInvoice),
          PdfMargins.vertical48,
          PdfComponents.table(
            isInvoice: isInvoice,
            invoiceCourses: invoiceCourses,
            subtotal: invoice.subtotal,
            hst: invoice.hst,
            total: invoice.total,
            paid: isInvoice ? null : receipt.paid,
          ),
          PdfMargins.vertical48,
          PdfComponents.generalText(
            text:
                "Thank you for your business!\nWe look forward to serving you again",
            textAlign: pw.TextAlign.center,
            fontSize: 14.0,
          ),
          PdfMargins.vertical60,
          if (sender.eTransfer != null)
            PdfPageSections.buildPaymentDetails(sender),
        ],
      );
    }));

    return pdf.save();
  }
}
