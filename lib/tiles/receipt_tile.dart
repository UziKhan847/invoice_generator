import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/extensions/context_extension.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/models/receipt.dart';
import 'package:markaz_umaza_invoice_generator/pages/pdf_preview_page.dart';
import 'package:markaz_umaza_invoice_generator/tiles/dialog_tile.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';
import 'package:markaz_umaza_invoice_generator/utils/pdf_handler.dart';
import 'package:markaz_umaza_invoice_generator/widgets/custom_list_tile.dart';
import 'package:markaz_umaza_invoice_generator/widgets/tile_column.dart';
import 'package:markaz_umaza_invoice_generator/widgets/tile_row.dart';

class ReceiptTile extends StatelessWidget {
  const ReceiptTile(
      {super.key,
      required this.receipt,
      required this.isLastIndex,
      this.onTapDelete,
      this.onTapEdit});

  final Receipt receipt;

  final bool isLastIndex;

  final void Function()? onTapDelete;
  final void Function()? onTapEdit;

  get mailService => null;

  @override
  Widget build(BuildContext context) {
    Invoice invoice = receipt.invoices;

    final pdfHandler = PdfHandler(invoice: invoice, receipt: receipt);

    return CustomListTile(
        onTapDelete: onTapDelete,
        onTapEdit: onTapEdit,
        isInvoiceReceipt: true,
        onTapPreview: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PdfPreviewPage(
                        receipt: receipt,
                        invoice: invoice,
                        sender: invoice.senders,
                        recipient: invoice.recipients,
                        invoiceCourses: invoice.invoiceCourses!.asMap(),
                      )));
        },
        onTapSave: () async {
          // if (await pdfHandler.requestStrgPermission(context)) {
          //   if (context.mounted) {
          //     String saveFilePath = await pdfHandler.savePdf(context);
          //     if (context.mounted) {
          //       context.showSnackBar('PDF Saved at: $saveFilePath');
          //     }
          //   }
          // } else {
          //   if (context.mounted) {
          //     context.showSnackBar('Stroage permission denied.', isError: true);
          //   }
          // }
        },
        onTapMail: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return DialogTile(
                  affirmButtonText: "Yes",
                  cancelButtonText: 'No',
                  dialogTitle:
                      "Do you want to send\n this receipt to ${invoice.recipients.name}",
                  onTapAffirm: () async {
                    pdfHandler.sendEmail(context);

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
        leadingIcon: const Icon(
          Icons.receipt_long_rounded,
          size: 20,
        ),
        content: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(child: TileRow("Invoice #: ", '${invoice.invoiceId}')),
              Expanded(child: TileRow("From: ", invoice.senders.name)),
            ],
          ),
          Row(
            children: [
              Expanded(child: TileRow("Date: ", receipt.receiptDate)),
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
                SizedBox(
                  width: 60,
                  child: Center(
                    child: TileColumn(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      "PAID:",
                      "\$${receipt.paid}",
                      fontSize: 11,
                    ),
                  ),
                ),
                Margins.horizontal10
              ],
            ),
          ),
        ]);
  }
}
