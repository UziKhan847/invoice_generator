import 'package:markaz_umaza_invoice_generator/models/course.dart';
import 'package:markaz_umaza_invoice_generator/pdf/pdf_table_row.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfTable {
  static pw.Table table({
    required Course? courseOne,
    required Course? courseTwo,
    required Course? courseThree,
    required Course? courseFour,
    required Course? courseFive,
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
          courseOne == null
              ? PdfTableRow.row()
              : PdfTableRow.row(
                  font: pw.Font.times(),
                  columnOne: "1. ${courseOne.name}",
                  columnTwo: "${courseOne.cost}",
                  columnThree: "${courseOne.quantity}",
                  columnFour: "${courseOne.amount}",
                ),
          courseTwo == null
              ? PdfTableRow.row()
              : PdfTableRow.row(
                  font: pw.Font.times(),
                  columnOne: "2. ${courseTwo.name}",
                  columnTwo: "\$${courseTwo.cost}",
                  columnThree: "${courseTwo.quantity}",
                  columnFour: "\$${courseTwo.amount}",
                ),
          courseThree == null
              ? PdfTableRow.row()
              : PdfTableRow.row(
                  font: pw.Font.times(),
                  columnOne: "3. ${courseThree.name}",
                  columnTwo: "\$${courseThree.cost}",
                  columnThree: "${courseThree.quantity}",
                  columnFour: "\$${courseThree.amount}",
                ),
          courseFour == null
              ? PdfTableRow.row()
              : PdfTableRow.row(
                  font: pw.Font.times(),
                  columnOne: "4. ${courseFour.name}",
                  columnTwo: "\$${courseFour.cost}",
                  columnThree: "${courseFour.quantity}",
                  columnFour: "\$${courseFour.amount}",
                ),
          courseFive == null
              ? PdfTableRow.row()
              : PdfTableRow.row(
                  font: pw.Font.times(),
                  columnOne: "5. ${courseFive.name}",
                  columnTwo: "\$${courseFive.cost}",
                  columnThree: "${courseFive.quantity}",
                  columnFour: "\$${courseFive.amount}",
                ),
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
              pw.SizedBox(
                // color: const PdfColor(0, 0, 0),
                height: 1,
              ),
              pw.SizedBox(),
              pw.SizedBox(),
              pw.SizedBox(),
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
