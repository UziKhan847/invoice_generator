import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/pages/detail_page.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';

class InvoiceTile extends StatelessWidget {
  const InvoiceTile({super.key, required this.invoice});

  final Invoice invoice;

  @override
  Widget build(BuildContext context) {
   // invoice.courses.removeWhere((e) => e == null); //TO GET RID OF THE NULL |||||||||||||||||||||||||||||||||

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
            leading: const Icon(
              Icons.receipt,
              size: 20,
            ),
            title: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Invoice Id: ",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${invoice.invoiceId}',
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
                Margins.vertical4,
                Row(
                  children: [
                    const Text(
                      "Sender: ",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      invoice.senders.name,
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
                Margins.vertical4,
                Row(
                  children: [
                    const Text(
                      "Recipient: ",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      invoice.recipients.name,
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
                Margins.vertical4,
                for (int i = 0; i < invoice.courses.length; i++) ...[
                  Row(
                    children: [
                      Text(
                        "Course ${i + 1}: ",
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        invoice.courses[i]!.name,
                        style: const TextStyle(fontSize: 12),
                      )
                    ],
                  ),
                  Margins.vertical4,
                ],
              ],
            ),
            trailing: Text(
              "\$${invoice.total}",
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
