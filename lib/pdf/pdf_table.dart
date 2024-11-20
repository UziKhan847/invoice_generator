import 'package:markaz_umaza_invoice_generator/models/course.dart';
import 'package:markaz_umaza_invoice_generator/pdf/pdf_table_row.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfTable {
  static pw.Table table({
    required Map<int, Course?> courses,
    required double subtotal,
    required double? hst,
    required double total,
  }) =>
      pw.Table(
        border: pw.TableBorder.all(),
        //defaultVerticalAlignment: TableCellVerticalAlignment.middle,
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
              pw.Padding(
                padding: const pw.EdgeInsets.all(3.0),
                child: pw.Text("DESCRIPTION",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      font: pw.Font.times(),
                      fontSize: 14,
                    )),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(3.0),
                child: pw.Text("COST (CAD)",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      font: pw.Font.times(),
                      fontSize: 12,
                    )),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(3.0),
                child: pw.Text("QUANTITY",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      font: pw.Font.times(),
                      fontSize: 12,
                    )),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(3.0),
                child: pw.Text("AMOUNT",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      font: pw.Font.times(),
                      fontSize: 14,
                    )),
              ),
            ],
          ),
          for (int i = 0; i < 5; i++) ...[
            courses[i] == null
                ? PdfTableRow.row()
                : PdfTableRow.row(
                    font: pw.Font.times(),
                    fontSizeTwo: 12,
                    columnOne: "${i + 1}. ${courses[i]!.name}",
                    columnTwo:
                        "\$${courses[i]!.cost}/${courses[i]!.costFrequency}",
                    columnThree: "${courses[i]!.quantity}",
                    columnFour: "\$${courses[i]!.amount}",
                  ),
          ],
          PdfTableRow.row(
              font: pw.Font.times(),
              columnOne: "Subtotal",
              columnFour: "\$$subtotal"),
          PdfTableRow.row(
            font: pw.Font.times(),
            columnOne: "HST %13",
            columnFour: "\$$hst",
          ),
          //Bold Final Top Border
          pw.TableRow(
            children: [
              for (int i = 0; i < 4; i++) ...[
                pw.SizedBox(
                  height: 1,
                ),
              ],
            ],
          ),
          PdfTableRow.row(
              fontWeight: pw.FontWeight.bold,
              font: pw.Font.timesBold(),
              columnOne: "TOTAL",
              columnFour: "\$$total"),
        ],
      );
}
