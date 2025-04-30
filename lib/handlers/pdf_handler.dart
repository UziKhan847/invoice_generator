import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/extensions/context_extension.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/models/profile.dart';
import 'package:markaz_umaza_invoice_generator/models/receipt.dart';
import 'package:markaz_umaza_invoice_generator/pdf/pdf_generator.dart';
import 'package:markaz_umaza_invoice_generator/tiles/dialog_tile.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:permission_handler/permission_handler.dart';

class PdfHandler {
  PdfHandler({required this.invoice, this.receipt, required this.profile});

  final Profile profile;
  final Invoice invoice;
  final Receipt? receipt;

  //EMAIL
  Future<String> getPdfFilePath(Future<Uint8List> pdf) async {
    final dir = await getTemporaryDirectory();
    final fileName =
        '${receipt == null ? invoice.invoiceDate : receipt!.receiptDate}_${invoice.recipients.name}'
            .replaceAll(RegExp('[- ]'), '_');
    final file = File('${dir.path}/$fileName.pdf');

    await file.writeAsBytes(await pdf);
    return file.path;
  }

  Future<void> sendEmail(BuildContext context) async {
    try {
      final pdfPath = await getPdfFilePath(PdfGenerator.generatePdf(
        profile: profile,
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

  //SAVE
  Future<String> savePdf(BuildContext context) async {
    try {
      final dir = Directory(
          '/storage/emulated/0/Invoice Generator/${invoice.senders.name}/${receipt == null ? 'invoices' : 'receipts'}');

      if (!await dir.exists()) {
        dir.create(recursive: true);
      }

      final fileName =
          '${receipt == null ? invoice.invoiceDate : receipt!.receiptDate}_${invoice.recipients.name}'
              .replaceAll(RegExp('[- ]'), '_');

      final filePath = '${dir.path}/$fileName.pdf';

      final file = File(filePath);

      await file.writeAsBytes(await PdfGenerator.generatePdf(
        profile: profile,
        receipt: receipt,
        invoice: invoice,
        sender: invoice.senders,
        recipient: invoice.recipients,
        invoiceCourses: invoice.invoiceCourses!.asMap(),
      ));

      return filePath;
    } catch (e) {
      if (context.mounted) {
        context.showSnackBar('Error saving PDF: $e', isError: true);
      }

      return '';
    }
  }

  Future<bool> isGranted(BuildContext context) async {
    try {
      return await Permission.manageExternalStorage.isGranted;
    } catch (e) {
      context.showSnackBar('Unable to check if storage permission is granted',
          isError: true);
      return false;
    }
  }

  Future<bool> requestStrgPermission(BuildContext context) async {
    final status = await Permission.manageExternalStorage.request();

    if (status.isGranted) {
      if (context.mounted) {
        context.showSnackBar('Permission granted!');
      }
    } else {
      if (context.mounted) {
        context.showSnackBar('Permission denied.', isError: true);
      }
    }

    return status.isGranted;
  }

  Future<void> showPermssionDialog(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => DialogTile(
              dialogTitle: 'Storage Permission Required',
              onTapAffirm: () async {
                try {
                  await requestStrgPermission(context);
                } catch (e) {
                  if (context.mounted) {
                    context.showSnackBar('Error requesting permission: $e');
                  }
                }

                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              onTapCancel: () {
                Navigator.of(context).pop();
              },
              affirmButtonText: 'Open Settings',
              cancelButtonText: 'Cancel',
            ));
  }
}
