import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/recipient.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';
import 'package:markaz_umaza_invoice_generator/widgets/tile_row.dart';

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
                for (int i = 0; i < 5; i++) ...[
                  switch (i) {
                    1 => TileRow("Name: ", recipient.name),
                    2 => TileRow("Address: ",
                        "${recipient.street}, ${recipient.city}, ${recipient.province}, ${recipient.zip}"),
                    3 => TileRow("Phone: ", recipient.phone),
                    4 => TileRow("Email: ", recipient.email),
                    _ => TileRow("Recipient Id: ", "${recipient.recipientId}")
                  },
                  if (i != 4) ...[
                    Margins.vertical4,
                  ]
                ],
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
