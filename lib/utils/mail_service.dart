import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/extensions/context_extension.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/models/receipt.dart';
import 'package:markaz_umaza_invoice_generator/pdf/generate_pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class MailService {
  MailService({required this.invoice, this.receipt});

  final Invoice invoice;
  final Receipt? receipt;

  Future<String> getPdfFilePath(Future<Uint8List> pdf) async {
    final dir = await getTemporaryDirectory();
    final file = File(
        '${dir.path}/${receipt == null ? invoice.invoiceDate.replaceAll(RegExp(r'-'), '_') : receipt!.receiptDate.replaceAll(RegExp(r'-'), '_')}_${invoice.recipients.name}.pdf');

    await file.writeAsBytes(await pdf);
    return file.path;
  }

  Future<void> sendEmail(BuildContext context) async {
    try {
      final pdfPath = await getPdfFilePath(generatePdf(
        receipt: receipt,
        invoice: invoice,
        sender: invoice.senders,
        recipient: invoice.recipients,
        invoiceCourses: invoice.invoiceCourses!.asMap(),
      ));

      String courseNames = invoice.invoiceCourses!
          .asMap()
          .entries
          .map((entry) => '${entry.key + 1}- ${entry.value.courses.name}')
          .join('\n');

      final emailToSend = Email(
        body:
            "Dear ${invoice.recipients.name},\n\nPlease find attached your ${receipt == null ? 'invoice' : 'receipt'} for the following course(s):\n$courseNames\n\nBest Regards,\nMarkaz Umaza\nmarkazumaza.com\n+1 (289) 456-9089",
        subject:
            '${receipt == null ? 'Invoice' : 'Receipt'} - ${invoice.recipients.name} - ${invoice.invoiceDate}',
        recipients: [invoice.recipients.email],
        attachmentPaths: [pdfPath],
        isHTML: false,
      );

      await FlutterEmailSender.send(emailToSend);

      if (context.mounted) {
        context.showSnackBar('Successfully Sent Email!');
      }
    } catch (e) {
      if (context.mounted) {
        context.showSnackBar('$e', isError: true);
      }
    }
  }
}

class Reciepient {}
