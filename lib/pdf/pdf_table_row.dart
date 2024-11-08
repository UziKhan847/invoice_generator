import 'package:pdf/widgets.dart' as pw;

class PdfTableRow {
  static pw.TableRow row(
          {pw.TextAlign? textAlign,
          pw.BoxDecoration? decoration,
          pw.FontWeight? fontWeight,
          pw.Font? font,
          double? fontSize = 14.0,
          String columnOne = "",
          String columnTwo = "",
          String columnThree = "",
          String columnFour = ""}) =>
      pw.TableRow(
        decoration: decoration,
        children: <pw.Widget>[
          pw.Padding(
            padding: const pw.EdgeInsets.all(3.0),
            child: pw.Row(children: [
              pw.SizedBox(
                height: 14,
                width: 5,
              ),
              pw.Text(columnOne,
                  textAlign: textAlign,
                  style: pw.TextStyle(
                    font: font,
                    fontSize: fontSize,
                    fontWeight: fontWeight,
                  ))
            ]),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(3.0),
            child: pw.Text(columnTwo,
                textAlign: textAlign,
                style: pw.TextStyle(
                  font: font,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                )),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(3.0),
            child: pw.Text(columnThree,
                textAlign: textAlign,
                style: pw.TextStyle(
                  font: font,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                )),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(3.0),
            child: pw.Text(columnFour,
                textAlign: textAlign,
                style: pw.TextStyle(
                  font: font,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                )),
          ),
        ],
      );
}
