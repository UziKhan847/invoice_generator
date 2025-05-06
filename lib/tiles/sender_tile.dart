import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/sender.dart';
import 'package:markaz_umaza_invoice_generator/utils/dividers.dart';
import 'package:markaz_umaza_invoice_generator/widgets/custom_list_tile.dart';
import 'package:markaz_umaza_invoice_generator/widgets/icon_with_text.dart';

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
    final name = sender.name.replaceAll(RegExp(' '), '\n');

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
              Dividers.verticalDivider(
                  Theme.of(context).brightness == Brightness.dark),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 8,
                  children: [
                    IconWithText(
                        Icons.account_circle_rounded, " ${sender.position}"),
                    IconWithText(Icons.phone, " ${sender.phone ?? ''}"),
                    IconWithText(Icons.email, ' ${sender.email ?? ''}'),
                    IconWithText(Icons.payment, ' ${sender.eTransfer ?? ''}'),
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
