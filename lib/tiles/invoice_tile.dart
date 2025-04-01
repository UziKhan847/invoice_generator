import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:markaz_umaza_invoice_generator/extensions/context_extension.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/pages/pdf_preview_page.dart';
import 'package:markaz_umaza_invoice_generator/pdf/generate_pdf.dart';
import 'package:markaz_umaza_invoice_generator/tiles/dialog_tile.dart';
import 'package:markaz_umaza_invoice_generator/utils/mail_service.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';
import 'package:markaz_umaza_invoice_generator/widgets/custom_list_tile.dart';
import 'package:markaz_umaza_invoice_generator/widgets/tile_column.dart';
import 'package:markaz_umaza_invoice_generator/widgets/tile_row.dart';
import 'package:path_provider/path_provider.dart';

class InvoiceTile extends StatelessWidget {
  const InvoiceTile(
      {super.key,
      required this.invoice,
      required this.isLastIndex,
      this.onTapDelete,
      this.onTapEdit});

  final Invoice invoice;

  final bool isLastIndex;

  final void Function()? onTapDelete;
  final void Function()? onTapEdit;

  @override
  Widget build(BuildContext context) {
    final mailService = MailService(invoice: invoice);

    return CustomListTile(
      isInvoiceReceipt: true,
      onTapDelete: onTapDelete,
      onTapEdit: onTapEdit,
      onTapPreview: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PdfPreviewPage(
                      invoice: invoice,
                      sender: invoice.senders,
                      recipient: invoice.recipients,
                      invoiceCourses: invoice.invoiceCourses!.asMap(),
                    )));
      },
      onTapMail: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return DialogTile(
                affirmButtonText: "Yes",
                cancelButtonText: 'No',
                dialogTitle:
                    "Do you want to send\n this invoice to ${invoice.recipients.name}",
                onTapAffirm: () async {
                  mailService.sendEmail(context);

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                onTapCancel: () {
                  Navigator.pop(context);
                },
              );
            });
      },
      isLastIndex: isLastIndex,
      content: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child: TileRow("ID: ", '${invoice.invoiceId}')),
            Expanded(child: TileRow("From: ", invoice.senders.name)),
          ],
        ),
        Row(
          children: [
            Expanded(child: TileRow("Date: ", invoice.invoiceDate)),
            Expanded(child: TileRow("To: ", invoice.recipients.name)),
          ],
        ),
        const Divider(height: 3),
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Course(s): ",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    for (int i = 0;
                        i < invoice.invoiceCourses!.length;
                        i++) ...[
                      Text(
                        "${invoice.invoiceCourses!.length > 1 ? '${i + 1}- ' : ''}${invoice.invoiceCourses![i].courses.name} - \$${invoice.invoiceCourses![i].courses.cost}/${invoice.invoiceCourses![i].courses.costFrequency} x ${invoice.invoiceCourses![i].quantity} = ${invoice.invoiceCourses![i].amount}",
                        style: const TextStyle(fontSize: 10),
                      ),
                      Margins.vertical2,
                    ],
                  ],
                ),
              ),
              const VerticalDivider(
                thickness: 0,
                color: Colors.black,
              ),
              TileColumn(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                "HST:",
                "\$${invoice.hst}",
                fontSize: 11,
              ),
              const VerticalDivider(
                thickness: 0,
                color: Colors.black,
              ),
              TileColumn(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                "TOTAL:",
                "\$${invoice.total}",
                fontSize: 11,
              ),
              Margins.horizontal10
            ],
          ),
        ),
      ],
    );
  }
}
