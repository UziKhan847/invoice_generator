import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/recipient.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';

class RecipientTile extends StatelessWidget {
  const RecipientTile({super.key, required this.recipient});

  final Recipient recipient;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.person,
              size: 20,
            ),
            title: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Recipient Id: ",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${recipient.recipientId}",
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
                Margins.vertical4,
                Row(
                  children: [
                    const Text(
                      "Name: ",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      recipient.name,
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
                Margins.vertical4,
                Row(
                  children: [
                    const Text(
                      "Address: ",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${recipient.city}, ${recipient.city}, ${recipient.province}, ${recipient.zip}",
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
                Margins.vertical4,
                Row(
                  children: [
                    const Text(
                      "Phone: ",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      recipient.phone,
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
                Margins.vertical4,
                Row(
                  children: [
                    const Text(
                      "Email: ",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      recipient.email,
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ],
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
