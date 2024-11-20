import 'package:pdf/widgets.dart' as pw;

class PdfTableRow {
  static pw.TableRow row(
          {pw.TextAlign? textAlign,
          pw.BoxDecoration? decoration,
          pw.FontWeight? fontWeight,
          pw.Font? font,
          double? fontSizeOne = 14.0,
          double? fontSizeTwo = 14.0,
          double? fontSizeThree = 14.0,
          double? fontSizeFour = 14.0,
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
                    fontSize: fontSizeOne,
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
                  fontSize: fontSizeTwo,
                  fontWeight: fontWeight,
                )),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(3.0),
            child: pw.Text(columnThree,
                textAlign: textAlign,
                style: pw.TextStyle(
                  font: font,
                  fontSize: fontSizeThree,
                  fontWeight: fontWeight,
                )),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(3.0),
            child: pw.Text(columnFour,
                textAlign: textAlign,
                style: pw.TextStyle(
                  font: font,
                  fontSize: fontSizeFour,
                  fontWeight: fontWeight,
                )),
          ),
        ],
      );
}
