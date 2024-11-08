import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfText {
  static pw.Text general(
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
}
