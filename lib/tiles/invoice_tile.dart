import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/pages/detail_page.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';
import 'package:markaz_umaza_invoice_generator/widgets/tile_row.dart';

class InvoiceTile extends StatelessWidget {
  const InvoiceTile(
      {super.key, required this.invoice, required this.isInvoice});

  final bool isInvoice;
  final Invoice invoice;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(
                      isInvoice: true,
                      invoice: invoice,
                      sender: invoice.senders!,
                      recipient: invoice.recipients!,
                      courses: invoice.courses,
                    )));
      },
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.receipt,
              size: 20,
            ),
            title: Column(
              children: [
                for (int i = 0; i < 3; i++) ...[
                  switch (i) {
                    1 => TileRow("Invoice Date: ", invoice.invoiceDate),
                    2 => TileRow("Sender: ", invoice.senders!.name),
                    3 => TileRow("Recipient: ", invoice.recipients!.name),
                    _ => TileRow("Invoice Id: ", '${invoice.invoiceId}')
                  },
                  Margins.vertical4,
                ],
                for (int i = 0; i < invoice.courses!.length; i++) ...[
                  Row(
                    children: [
                      Text(
                        "Course ${i + 1}: ",
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        invoice.courses![i].name,
                        style: const TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  Margins.vertical4,
                ],
              ],
            ),
            trailing: Text(
              "Due\n\$${invoice.total}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(
            height: 0,
          ),
        ],
      ),
    );
  }
}
