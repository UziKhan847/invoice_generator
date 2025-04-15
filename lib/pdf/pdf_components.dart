import 'package:markaz_umaza_invoice_generator/models/invoice_course.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfComponents {
  static pw.Text generalText(
      {String text = '',
      pw.Font? font,
      double fontSize = 13.0,
      pw.FontWeight? fontWeight,
      PdfColor? color,
      pw.TextAlign? textAlign}) {
    return pw.Text(text,
        textAlign: textAlign,
        style: pw.TextStyle(
          color: color,
          font: font,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ));
  }

  static pw.Table table({
    double? paid,
    required bool isInvoice,
    required Map<int, InvoiceCourse> invoiceCourses,
    required double subtotal,
    required double? hst,
    required double total,
  }) =>
      pw.Table(
        border: pw.TableBorder.all(),
        columnWidths: const <int, pw.TableColumnWidth>{
          0: pw.FixedColumnWidth(185),
          1: pw.FixedColumnWidth(55),
          2: pw.FixedColumnWidth(55),
          3: pw.FixedColumnWidth(55),
        },
        children: <pw.TableRow>[
          pw.TableRow(
            decoration: const pw.BoxDecoration(color: PdfColor(0.9, 0.9, 0.9)),
            children: [
              for (int i = 0; i < 4; i++) ...[
                pw.Padding(
                  padding: const pw.EdgeInsets.all(3.0),
                  child: pw.Text(
                      switch (i) {
                        1 => "COST (CAD)",
                        2 => 'QUANTITY',
                        3 => 'AMOUNT',
                        _ => "DESCRIPTION"
                      },
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        font: pw.Font.times(),
                        fontSize: switch (i) { 1 || 2 => 12, _ => 14 },
                      )),
                ),
              ],
            ],
          ),
          for (int i = 0; i < 5; i++) ...[
            invoiceCourses[i] == null
                ? PdfComponents.tableRow()
                : PdfComponents.tableRow(font: pw.Font.times(), fontSizes: [
                    14,
                    12,
                    14,
                    14
                  ], columns: [
                    "${i + 1}. ${invoiceCourses[i]!.courses.name}",
                    "\$${invoiceCourses[i]!.courses.cost}/${invoiceCourses[i]!.courses.costFrequency}",
                    "${invoiceCourses[i]!.quantity}",
                    "\$${invoiceCourses[i]!.amount}",
                  ]),
          ],
          PdfComponents.tableRow(
              font: pw.Font.times(),
              columns: ["Subtotal", '', '', "\$$subtotal"]),
          PdfComponents.tableRow(
            font: pw.Font.times(),
            columns: ["HST %13", '', '', "\$${hst ?? 0.0}"],
          ),
          if (!isInvoice)
            tableRow(
              font: pw.Font.times(),
              columns: ["TOTAL", '', '', "\$$total"],
            ),
          pw.TableRow(
            children: [
              for (int i = 0; i < 4; i++) ...[
                pw.SizedBox(
                  height: 1,
                ),
              ],
            ],
          ),
          tableRow(
              fontWeight: pw.FontWeight.bold,
              font: pw.Font.timesBold(),
              columns: [
                (isInvoice ? "TOTAL" : "PAID"),
                '',
                '',
                "\$${isInvoice ? total : paid}"
              ]),
        ],
      );

  static pw.TableRow tableRow({
    pw.TextAlign? textAlign,
    pw.BoxDecoration? decoration,
    pw.FontWeight? fontWeight,
    pw.Font? font,
    List<double?> fontSizes = const [14, 14, 14, 14],
    List<String> columns = const ['', '', '', ''],
  }) =>
      pw.TableRow(
        decoration: decoration,
        children: <pw.Widget>[
          for (int i = 0; i < 4; i++) ...[
            pw.Padding(
              padding: const pw.EdgeInsets.all(3.0),
              child: switch (i) {
                0 => pw.Row(children: [
                    pw.SizedBox(
                      height: 14,
                      width: 5,
                    ),
                    pw.Text(columns[i],
                        textAlign: textAlign,
                        style: pw.TextStyle(
                          font: font,
                          fontSize: fontSizes[i],
                          fontWeight: fontWeight,
                        ))
                  ]),
                _ => pw.Text(columns[i],
                    textAlign: textAlign,
                    style: pw.TextStyle(
                      font: font,
                      fontSize: fontSizes[i],
                      fontWeight: fontWeight,
                    ))
              },
            ),
          ],
        ],
      );
}
