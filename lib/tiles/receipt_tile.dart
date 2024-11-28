import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/receipt.dart';
import 'package:markaz_umaza_invoice_generator/pages/detail_page.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';
import 'package:markaz_umaza_invoice_generator/widgets/tile_row.dart';

class ReceiptTile extends StatelessWidget {
  const ReceiptTile({super.key, required this.receipt});

  final Receipt receipt;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(
                      isInvoice: false,
                      receipt: receipt,
                      invoice: receipt.invoices,
                      sender: receipt.senders,
                      recipient: receipt.recipients,
                      courses: receipt.courses,
                    )));
      },
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.receipt_long_rounded,
              size: 20,
            ),
            title: Column(
              children: [
                for (int i = 0; i < 6; i++) ...[
                  switch (i) {
                    1 => TileRow("Receipt Date: ", receipt.receiptDate),
                    2 => TileRow("Invoice #: ", "${receipt.invoiceId}"),
                    3 => TileRow("Amount Due: ", "\$${receipt.invoices.total}"),
                    4 => TileRow("Sender: ", receipt.senders.name),
                    5 => TileRow("Recipient: ", receipt.recipients.name),
                    _ => TileRow("Receipt Id: ", '${receipt.invoiceId}')
                  },
                  Margins.vertical4,
                ],
                for (int i = 0; i < receipt.courses.length; i++) ...[
                  Row(
                    children: [
                      Text(
                        "Course ${i + 1}: ",
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        receipt.courses[i].name,
                        style: const TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  Margins.vertical4,
                ],
              ],
            ),
            trailing: Text(
              "Paid\n\$${receipt.paid}",
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
