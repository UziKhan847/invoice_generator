import 'package:flutter/services.dart';
import 'package:markaz_umaza_invoice_generator/models/course.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/models/recipient.dart';
import 'package:markaz_umaza_invoice_generator/models/sender.dart';
import 'package:markaz_umaza_invoice_generator/pdf/pdf_table.dart';
import 'package:markaz_umaza_invoice_generator/pdf/pdf_margins.dart';
import 'package:markaz_umaza_invoice_generator/pdf/pdf_text.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> generatePdf({
  required Invoice invoice,
  required Sender sender,
  required Recipient recipient,
  required List<Course?> courses,
  required bool showName,
}) async {
  final pdf = pw.Document();

  //Logo
  final img = await rootBundle.load("images/markaz_umaza_logo.png");
  final imageBytes = img.buffer.asUint8List();
  pw.Image logo = pw.Image(pw.MemoryImage(imageBytes));

  pdf.addPage(pw.Page(build: (context) {
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
                  text: showName ? sender.name : "",
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
                    text: "INVOICE",
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
                  text: "BILL TO",
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
                  text: "Invoice No:",
                  fontWeight: pw.FontWeight.bold,
                ),
                PdfMargins.vertical22,
                PdfText.general(
                  text: "Invoice Date:",
                  fontWeight: pw.FontWeight.bold,
                ),
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
                  text: "#${invoice.invoiceId}",
                ),
                PdfMargins.vertical22,
                PdfText.general(
                  text: invoice.invoiceDate,
                ),
                PdfText.general(
                  text: invoice.dueDate ?? "",
                ),
              ],
            ),
          ],
        ),
        PdfMargins.vertical48,
        PdfTable.table(
          courses: courses,
          subtotal: invoice.subtotal,
          hst: invoice.hst,
          total: invoice.total,
        ),
        PdfMargins.vertical48,
        PdfText.general(
          text:
              "Thank you for you business!\nWe look forward to serving you again",
          textAlign: pw.TextAlign.center,
          fontSize: 14.0,
        ),
        PdfMargins.vertical74,
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














// import 'package:flutter/services.dart';
// import 'package:pdf/widgets.dart';

// Future<Uint8List> generatePdf() async {
//   final pdf = Document();

//   //Logo
//   final img = await rootBundle.load("/images/markaz_umaza_logo.png");
//   final ImageBytes = img.buffer.asUint8List();
//   Image logo = Image(MemoryImage(ImageBytes));

//   pdf.addPage(Page(build: (context) {
//     return Column(children: []);
//   }));

//   return pdf.save();
// }