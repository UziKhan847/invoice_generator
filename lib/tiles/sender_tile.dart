import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/sender.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';

class SenderTile extends StatelessWidget {
  const SenderTile({super.key, required this.sender});

  final Sender sender;

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
                      "Sender Id: ",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${sender.senderId}",
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
                      sender.name,
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
                      "${sender.city}, ${sender.city}, ${sender.province}, ${sender.zip}",
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
                      sender.phone,
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
                      sender.email,
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
                Margins.vertical4,
                Row(
                  children: [
                    const Text(
                      "E-Transfer: ",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${sender.eTransfer}",
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                )
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
