import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/pages/detail_page.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';

class InvoiceTile extends StatelessWidget {
  const InvoiceTile({super.key, required this.invoice});

  final Invoice invoice;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(
                      invoice: invoice,
                    )));
      },
      child: Column(
        children: [
          ListTile(
            title: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "ID: ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${invoice.invoiceId}',
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
                Margins.vertical4,
                Row(
                  children: [
                    const Text(
                      "Sender: ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      invoice.senders.name!,
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                ),
                Margins.vertical4,
                Row(
                  children: [
                    const Text(
                      "Recipient: ",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      invoice.recipients.name!,
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                )
              ],
            ),
            trailing: Text(
              "\$${invoice.total}",
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
