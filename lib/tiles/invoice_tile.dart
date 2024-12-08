import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/pages/detail_page.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';
import 'package:markaz_umaza_invoice_generator/widgets/custom_list_tile.dart';
import 'package:markaz_umaza_invoice_generator/widgets/tile_row.dart';

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
    return CustomListTile(
      showPreviewButton: true,
      onTapDelete: onTapDelete,
      onTapEdit: onTapEdit,
      onTapPreview: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(
                      isInvoice: true,
                      invoice: invoice,
                      sender: invoice.senders,
                      recipient: invoice.recipients,
                      invoiceCourses: invoice.invoiceCourses,
                    )));
      },
      isLastIndex: isLastIndex,
      leadingIcon: const Icon(
        Icons.receipt,
        size: 20,
      ),
      content: [
        Margins.vertical4,
        for (int i = 0; i < 4; i++) ...[
          switch (i) {
            1 => TileRow("Invoice Date: ", invoice.invoiceDate),
            2 => TileRow("Sender: ", invoice.senders.name),
            3 => TileRow("Recipient: ", invoice.recipients.name),
            _ => TileRow("Invoice Id: ", '${invoice.invoiceId}')
          },
          Margins.vertical4,
        ],
        const Divider(height: 3),
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
        TileRow(
          "HST:   ",
          "\$${invoice.hst}",
          fontSize: 10,
        ),
        Margins.vertical2,
        const Divider(height: 3),
        Margins.vertical4,
        TileRow("TOTAL DUE:   ", "\$${invoice.total}"),
        Margins.vertical4,
      ],
    );
  }
}
