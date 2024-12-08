import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/recipient.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';
import 'package:markaz_umaza_invoice_generator/widgets/custom_list_tile.dart';
import 'package:markaz_umaza_invoice_generator/widgets/tile_row.dart';

class RecipientTile extends StatelessWidget {
  const RecipientTile({
    super.key,
    required this.recipient,
    required this.isLastIndex,
    this.onTapDelete,
    this.onTapEdit,
  });

  final Recipient recipient;
  final bool isLastIndex;

  final void Function()? onTapDelete;
  final void Function()? onTapEdit;

  @override
  Widget build(BuildContext context) {
    int recipientAddressLength =
        "${recipient.street}, ${recipient.city}, ${recipient.province}, ${recipient.zip}"
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
            1 => TileRow("Name: ", recipient.name),
            2 => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Address: ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  recipientAddressLength > 30
                      ? Text(
                          "${recipient.street},\n ${recipient.city}, ${recipient.province}, ${recipient.zip}",
                          style: const TextStyle(fontSize: 11),
                        )
                      : Text(
                          "${recipient.street}, ${recipient.city}, ${recipient.province}, ${recipient.zip}",
                          style: const TextStyle(fontSize: 12),
                        )
                ],
              ),
            3 => TileRow("Phone: ", recipient.phone),
            4 => TileRow("Email: ", recipient.email),
            _ => TileRow("Recipient Id: ", "${recipient.recipientId}")
          },
        ],
        Margins.vertical4,
      ],
    );
  }
}
