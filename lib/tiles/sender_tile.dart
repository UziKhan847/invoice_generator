import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/sender.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';
import 'package:markaz_umaza_invoice_generator/widgets/tile_row.dart';

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
                for (int i = 0; i < 6; i++) ...[
                  switch (i) {
                    1 => TileRow("Name: ", sender.name),
                    2 => TileRow("Address: ",
                        "${sender.street}, ${sender.city}, ${sender.province}"),
                    3 => TileRow("Phone: ", sender.phone),
                    4 => TileRow("Email: ", sender.email),
                    5 => TileRow("E-Transfer: ", '${sender.eTransfer}'),
                    _ => TileRow("Sender Id: ", "${sender.senderId}")
                  },
                  if (i != 5) ...[
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
