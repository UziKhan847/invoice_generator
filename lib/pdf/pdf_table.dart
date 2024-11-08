import 'package:markaz_umaza_invoice_generator/pdf/pdf_table_row.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfTable {
  static pw.Table table() => pw.Table(
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
                child: pw.Text("COST",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      font: pw.Font.times(),
                      fontSize: 14,
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
          PdfTableRow.row(
            columnOne: "[Name of Course]",
            font: pw.Font.times(),
          ),
          PdfTableRow.row(
            font: pw.Font.times(),
          ),
          PdfTableRow.row(
            font: pw.Font.times(),
          ),
          PdfTableRow.row(
            font: pw.Font.times(),
          ),
          PdfTableRow.row(
            font: pw.Font.times(),
          ),
          PdfTableRow.row(
            columnOne: "Subtotal",
            font: pw.Font.times(),
          ),
          PdfTableRow.row(
            columnOne: "HST %13",
            font: pw.Font.times(),
          ),
          //Bold Final Top Border
          pw.TableRow(
            children: [
              pw.Container(
                color: const PdfColor(0, 0, 0),
                height: 1,
              ),
              pw.Container(),
              pw.Container(),
              pw.Container(),
            ],
          ),
          PdfTableRow.row(
            fontWeight: pw.FontWeight.bold,
            font: pw.Font.timesBold(),
            columnOne: "TOTAL",
          ),
        ],
      );
}
