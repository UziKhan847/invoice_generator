import 'package:flutter/services.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice_course.dart';
import 'package:markaz_umaza_invoice_generator/models/receipt.dart';
import 'package:markaz_umaza_invoice_generator/models/recipient.dart';
import 'package:markaz_umaza_invoice_generator/models/sender.dart';
import 'package:markaz_umaza_invoice_generator/pdf/pdf_table.dart';
import 'package:markaz_umaza_invoice_generator/pdf/pdf_margins.dart';
import 'package:markaz_umaza_invoice_generator/pdf/pdf_text.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> generatePdf({

  Receipt? receipt,
  required Invoice invoice,
  required Sender sender,
  required Recipient recipient,
  required Map<int, InvoiceCourse> invoiceCourses,
}) async {
  final pdf = pw.Document();

  //Logo
  final img = await rootBundle.load("assets/images/markaz_umaza_logo.png");
  final imageBytes = img.buffer.asUint8List();
  pw.Image logo = pw.Image(pw.MemoryImage(imageBytes));

  pdf.addPage(pw.Page(build: (context) {
    bool isInvoice = receipt == null ? true : false;

    return pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Row(
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "Markaz Umaza",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 21,
                  ),
                ),
                PdfMargins.vertical6,
                PdfText.general(
                  text: "BN: ${sender.businessNumber}",
                ),
                PdfText.general(
                  text: "${sender.street}, ${sender.city}, ${sender.province}",
                ),
                PdfText.general(
                  text: sender.email,
                ),
                PdfText.general(
                  text: sender.phone,
                ),
              ],
            ),
            pw.Expanded(child: pw.SizedBox()),
            pw.Column(
              children: [
                pw.SizedBox(
                  width: 75,
                  child: logo,
                ),
                PdfText.general(
                    text: isInvoice ? "INVOICE" : "RECEIPT",
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 22.0,
                    color: const PdfColor(0.4, 0.4, 0.4)),
              ],
            ),
            PdfMargins.horizontal14,
          ],
        ),
        PdfMargins.vertical60,
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                PdfText.general(
                  text: isInvoice ? "BILL TO" : "BILLED TO",
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 16,
                ),
                PdfMargins.vertical14,
                pw.Container(
                  height: 1.5,
                  width: 100.0,
                  color: const PdfColor(0.6, 0.6, 0.6),
                ),
                PdfMargins.vertical10,
                PdfText.general(
                  text: recipient.name,
                ),
                PdfText.general(
                  text: recipient.street,
                ),
                PdfText.general(
                  text:
                      "${recipient.city}, ${recipient.province}, ${recipient.zip}",
                ),
                PdfText.general(
                  text: recipient.phone,
                ),
                PdfText.general(
                  text: recipient.email,
                ),
              ],
            ),
            pw.Expanded(child: pw.SizedBox()),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                PdfMargins.vertical4,
                PdfText.general(
                  text: "${isInvoice ? "Invoice" : "Receipt"} No:",
                  fontWeight: pw.FontWeight.bold,
                ),
                PdfMargins.vertical22,
                PdfText.general(
                  text: "${isInvoice ? "Invoice" : "Receipt"} Date:",
                  fontWeight: pw.FontWeight.bold,
                ),
                if (isInvoice)
                  PdfText.general(
                    text: invoice.dueDate == null ? "" : "Due Date:",
                    fontWeight: pw.FontWeight.bold,
                  ),
              ],
            ),
            PdfMargins.horizontal6,
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                PdfMargins.vertical4,
                PdfText.general(
                  text:
                      "#${isInvoice ? invoice.invoiceId : receipt!.receiptId}",
                ),
                PdfMargins.vertical22,
                PdfText.general(
                  text: isInvoice ? invoice.invoiceDate : receipt!.receiptDate,
                ),
                if (isInvoice)
                  PdfText.general(
                    text: invoice.dueDate ?? "",
                  ),
              ],
            ),
          ],
        ),
        PdfMargins.vertical48,
        PdfTable.table(
            isInvoice: isInvoice,
            invoiceCourses: invoiceCourses,
            subtotal: invoice.subtotal,
            hst: invoice.hst,
            total: invoice.total,
            paid: isInvoice ? null : receipt!.paid),
        PdfMargins.vertical48,
        PdfText.general(
          text:
              "Thank you for your business!\nWe look forward to serving you again",
          textAlign: pw.TextAlign.center,
          fontSize: 14.0,
        ),
        PdfMargins.vertical60,
        pw.Row(
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                PdfText.general(
                  text: "Method of Payment",
                  fontSize: 11,
                  fontWeight: pw.FontWeight.bold,
                ),
                PdfMargins.vertical4,
                pw.Container(
                  height: 1,
                  width: 130.0,
                  color: const PdfColor(0.6, 0.6, 0.6),
                ),
                PdfMargins.vertical4,
                pw.Row(
                  children: [
                    PdfText.general(
                      text: "E-transfer to: ",
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                    PdfText.general(
                      text: "${sender.eTransfer}",
                      fontSize: 12,
                    ),
                  ],
                ),
              ],
            ),
          ],
        )
      ],
    );
  }));

  return pdf.save();
}
