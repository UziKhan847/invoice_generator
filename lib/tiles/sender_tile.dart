import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/sender.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';
import 'package:markaz_umaza_invoice_generator/widgets/custom_list_tile.dart';
import 'package:markaz_umaza_invoice_generator/widgets/tile_row.dart';

class SenderTile extends StatelessWidget {
  const SenderTile({
    super.key,
    required this.sender,
    required this.isLastIndex,
    this.onTapDelete,
    this.onTapEdit,
  });

  final Sender sender;
  final bool isLastIndex;

  final void Function()? onTapDelete;
  final void Function()? onTapEdit;

  @override
  Widget build(BuildContext context) {
    int senderAddressLength =
        "${sender.street}, ${sender.city}, ${sender.province}, ${sender.zip}"
            .length;

    return CustomListTile(
      onTapDelete: onTapDelete,
      onTapEdit: onTapEdit,
      isLastIndex: isLastIndex,
      leadingIcon: const Icon(
        Icons.person,
        size: 20,
      ),
      content: [
        Margins.vertical4,
        for (int i = 0; i < 5; i++) ...[
          switch (i) {
            1 => TileRow("Name: ", sender.name),
            2 => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Address: ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  senderAddressLength > 30
                      ? Text(
                          "${sender.street},\n ${sender.city}, ${sender.province}, ${sender.zip}",
                          style: const TextStyle(fontSize: 11),
                        )
                      : Text(
                          "${sender.street}, ${sender.city}, ${sender.province}, ${sender.zip}",
                          style: const TextStyle(fontSize: 12),
                        )
                ],
              ),
            3 => TileRow("Phone: ", sender.phone),
            4 => TileRow("Email: ", sender.email),
            5 => TileRow('E-Transfer: ', "${sender.eTransfer}"),
            _ => TileRow("Sender Id: ", "${sender.senderId}")
          },
        ],
        Margins.vertical4,
      ],
    );
  }
}
