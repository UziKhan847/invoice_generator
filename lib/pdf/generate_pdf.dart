import 'package:flutter/services.dart';
import 'package:markaz_umaza_invoice_generator/pdf/pdf_table.dart';
import 'package:markaz_umaza_invoice_generator/pdf/pdf_margins.dart';
import 'package:markaz_umaza_invoice_generator/pdf/pdf_text.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> generatePdf() async {
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
                  text: "[Name]",
                ),
                PdfText.general(
                  text: "118 Chestnut Avenue, Hamitlon, ON",
                ),
                PdfText.general(
                  text: "[letter].saleem@markazumaza.com",
                ),
                PdfText.general(
                  text: "+1 (289)-456-9089",
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
                  text: "[Name]",
                ),
                PdfText.general(
                  text: "[Street]",
                ),
                PdfText.general(
                  text: "[City, Prov, ZIP]",
                ),
                PdfText.general(
                  text: "[Email]",
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
                  text: "Due Date:",
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
                  text: "4085292927",
                ),
                PdfMargins.vertical22,
                PdfText.general(
                  text: "MM/DD/YYYY",
                ),
                PdfText.general(
                  text: "MM/DD/YYYY",
                ),
              ],
            ),
          ],
        ),
        PdfMargins.vertical48,
        PdfTable.table(),
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
                      text: "[etransfer@email.com]",
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