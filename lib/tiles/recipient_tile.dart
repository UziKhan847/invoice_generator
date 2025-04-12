import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/recipient.dart';
import 'package:markaz_umaza_invoice_generator/utils/dividers.dart';
import 'package:markaz_umaza_invoice_generator/widgets/custom_list_tile.dart';
import 'package:markaz_umaza_invoice_generator/widgets/icon_with_text.dart';

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
    // final recipientAddressLength =
    //     "${recipient.street}, ${recipient.city}, ${recipient.province}, ${recipient.zip}"
    //         .length;

    final name = recipient.name.replaceAll(RegExp(' '), '\n');

    return CustomListTile(
      onTapDelete: onTapDelete,
      onTapEdit: onTapEdit,
      isLastIndex: isLastIndex,
      leadingIcon: const Icon(
        Icons.person,
        size: 20,
      ),
      content: [
        IntrinsicHeight(
          child: Row(
            children: [
              SizedBox(
                width: 120,
                child: Center(
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Dividers.verticalDivider(Theme.of(context).brightness == Brightness.dark),
              Expanded(
                child: Column(
                  spacing: 8,
                  children: [
                    IconWithText(Icons.location_on,
                        ' ${recipient.street} ${recipient.city} ${recipient.province} ${recipient.zip ?? ''}'),
                    IconWithText(Icons.phone, " ${recipient.phone}"),
                    IconWithText(Icons.email, ' ${recipient.email}')
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
