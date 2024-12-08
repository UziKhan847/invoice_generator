import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/models/recipient.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';
import 'package:markaz_umaza_invoice_generator/tiles/dialog_tile.dart';
import 'package:markaz_umaza_invoice_generator/tiles/recipient_tile.dart';

class RecipientListBuilder extends ConsumerWidget {
  RecipientListBuilder({super.key, required this.recipients});

  final List<Recipient> recipients;
  late AppData provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    provider = ref.watch(appData);

    return ListView.builder(
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      itemCount: recipients.length,
      itemBuilder: (context, index) {
        Recipient item = recipients[index];

        return RecipientTile(
          recipient: item,
          isLastIndex: index == recipients.length - 1,
          onTapDelete: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DialogTile(
                    affirmButtonText: "Yes",
                    cancelButtonText: 'No',
                    dialogTitle:
                        "Are you sure you want to\n delete this recipient?",
                    onTapAffirm: () async {
                      await provider.deleteRecipient(
                          context: context, recipientId: item.recipientId);

                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    onTapCancel: () {
                      Navigator.pop(context);
                    },
                  );
                });
          },
        );
      },
    );
  }
}
