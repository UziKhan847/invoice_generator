import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/models/profile.dart';
import 'package:markaz_umaza_invoice_generator/models/receipt.dart';
import 'package:markaz_umaza_invoice_generator/models/recipient.dart';
import 'package:markaz_umaza_invoice_generator/models/sender.dart';
import 'package:markaz_umaza_invoice_generator/pdf/pdf_components.dart';
import 'package:markaz_umaza_invoice_generator/pdf/pdf_margins.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfPageSections {
  static pw.Widget buildHeader(pw.Image logo, Profile profile, bool isInvoice) {
    return pw.Row(
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(profile.fullName!,
                style:
                    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 21)),
            PdfMargins.vertical6,
            PdfComponents.generalText(
                text: profile.businessNumber == null
                    ? ''
                    : "BN: ${profile.businessNumber}"),
            PdfComponents.generalText(
                text: "${profile.street}, ${profile.city}, ${profile.province}"),
            PdfComponents.generalText(text: profile.email!),
            PdfComponents.generalText(text: profile.phone!),
          ],
        ),
        pw.Expanded(child: pw.SizedBox()),
        pw.Column(
          children: [
            pw.SizedBox(width: 75, child: logo),
            PdfComponents.generalText(
              text: isInvoice ? "INVOICE" : "RECEIPT",
              fontWeight: pw.FontWeight.bold,
              fontSize: 22.0,
              color: const PdfColor(0.4, 0.4, 0.4),
            ),
          ],
        ),
        PdfMargins.horizontal14,
      ],
    );
  }

  static pw.Widget buildRecipientDetails(
      Recipient recipient, Invoice invoice, Receipt? receipt, bool isInvoice) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            PdfComponents.generalText(
                text: isInvoice ? "BILL TO" : "BILLED TO",
                fontWeight: pw.FontWeight.bold,
                fontSize: 16),
            PdfMargins.vertical14,
            pw.Container(
                height: 1.5,
                width: 100.0,
                color: const PdfColor(0.6, 0.6, 0.6)),
            PdfMargins.vertical10,
            PdfComponents.generalText(text: recipient.name),
            PdfComponents.generalText(text: recipient.street),
            PdfComponents.generalText(
                text:
                    "${recipient.city}, ${recipient.province}, ${recipient.zip}"),
            PdfComponents.generalText(text: recipient.phone),
            PdfComponents.generalText(text: recipient.email),
          ],
        ),
        pw.Expanded(child: pw.SizedBox()),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            PdfMargins.vertical4,
            PdfComponents.generalText(
                text: "${isInvoice ? "Invoice" : "Receipt"} No:",
                fontWeight: pw.FontWeight.bold),
            PdfMargins.vertical22,
            PdfComponents.generalText(
                text: "${isInvoice ? "Invoice" : "Receipt"} Date:",
                fontWeight: pw.FontWeight.bold),
            if (isInvoice)
              PdfComponents.generalText(
                  text: invoice.dueDate == null ? "" : "Due Date:",
                  fontWeight: pw.FontWeight.bold),
          ],
        ),
        PdfMargins.horizontal6,
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            PdfMargins.vertical4,
            PdfComponents.generalText(
                text: "#${isInvoice ? invoice.invoiceId : receipt!.receiptId}"),
            PdfMargins.vertical22,
            PdfComponents.generalText(
                text: isInvoice ? invoice.invoiceDate : receipt!.receiptDate),
            if (isInvoice)
              PdfComponents.generalText(text: invoice.dueDate ?? ""),
          ],
        ),
      ],
    );
  }

  static pw.Widget buildPaymentDetails(Sender sender) {
    return pw.Row(
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            PdfComponents.generalText(
                text: "Method of Payment",
                fontSize: 11,
                fontWeight: pw.FontWeight.bold),
            PdfMargins.vertical4,
            pw.Container(
                height: 1, width: 130.0, color: const PdfColor(0.6, 0.6, 0.6)),
            PdfMargins.vertical4,
            pw.Row(
              children: [
                PdfComponents.generalText(
                    text: "E-transfer to: ",
                    fontSize: 12,
                    fontWeight: pw.FontWeight.bold),
                PdfComponents.generalText(
                    text: "${sender.eTransfer}", fontSize: 12),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
