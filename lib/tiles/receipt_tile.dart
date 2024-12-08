import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/models/receipt.dart';
import 'package:markaz_umaza_invoice_generator/pages/detail_page.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';
import 'package:markaz_umaza_invoice_generator/widgets/custom_list_tile.dart';
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

  @override
  Widget build(BuildContext context) {
    Invoice invoice = receipt.invoices;


    return CustomListTile(
        onTapDelete: onTapDelete,
        onTapEdit: onTapEdit,
        showPreviewButton: true,
        onTapPreview: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailPage(
                        receipt: receipt,
                        invoice: invoice,
                      sender: invoice.senders,
                      recipient: invoice.recipients,
                      invoiceCourses: invoice.invoiceCourses,
                      )));
        },
        isLastIndex: isLastIndex,
        leadingIcon: const Icon(
          Icons.receipt_long_rounded,
          size: 20,
        ),
        content: [
          Margins.vertical4,
          for (int i = 0; i < 6; i++) ...[
            switch (i) {
              1 => TileRow("Receipt Date: ", receipt.receiptDate),
              2 => TileRow("Invoice #: ", "${invoice.invoiceId}"),
              3 => TileRow("Amount Due: ", "\$${invoice.total}"),
              4 => TileRow("Sender: ", invoice.senders.name),
              5 => TileRow("Recipient: ", invoice.recipients.name),
              _ => TileRow("Receipt Id: ", '${receipt.receiptId}')
            },
            Margins.vertical4,
          ],
          const Text(
            "Courses: ",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          for (int i = 0; i < invoice.invoiceCourses!.length; i++) ...[
            Text(
              "${i + 1}- ${invoice.invoiceCourses![i].courses.name} - \$${invoice.invoiceCourses![i].courses.cost}/${invoice.invoiceCourses![i].courses.costFrequency} x ${invoice.invoiceCourses![i].quantity} = ${invoice.invoiceCourses![i].amount}",
              style: const TextStyle(fontSize: 10),
            ),
            Margins.vertical2,
          ],
          Margins.vertical2,
          const Divider(height: 3),
          Margins.vertical4,
          TileRow("TOTAL PAID:   ", "\$${receipt.paid}"),
          Margins.vertical4,
        ]);
  }
}
