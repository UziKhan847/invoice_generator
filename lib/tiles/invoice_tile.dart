import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/pages/pdf_preview_page.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';
import 'package:markaz_umaza_invoice_generator/widgets/custom_list_tile.dart';
import 'package:markaz_umaza_invoice_generator/widgets/tile_column.dart';
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
                builder: (context) => PdfPreviewPage(
                      isInvoice: true,
                      invoice: invoice,
                      sender: invoice.senders,
                      recipient: invoice.recipients,
                      invoiceCourses: invoice.invoiceCourses!.asMap(),
                    )));
      },
      isLastIndex: isLastIndex,
      content: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child: TileRow("Invoice Id: ", '${invoice.invoiceId}')),
            Expanded(child: TileRow("Invoice Date: ", invoice.invoiceDate)),
          ],
        ),
        Row(
          children: [
            Expanded(child: TileRow("From: ", invoice.senders.name)),
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
