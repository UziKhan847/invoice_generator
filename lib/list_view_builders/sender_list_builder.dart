import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/models/sender.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';
import 'package:markaz_umaza_invoice_generator/tiles/dialog_tile.dart';
import 'package:markaz_umaza_invoice_generator/tiles/sender_tile.dart';

class SenderListBuilder extends ConsumerWidget {
  SenderListBuilder({super.key, required this.senders});

  final List<Sender> senders;

  late AppData provider;

  bool isPressed = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    provider = ref.watch(appData);

    return ListView.builder(
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      itemCount: senders.length,
      itemBuilder: (context, index) {
        Sender item = senders[index];

        return SenderTile(
          sender: item,
          isLastIndex: index == senders.length - 1,
          onTapDelete: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DialogTile(
                    affirmButtonText: "Yes",
                    cancelButtonText: 'No',
                    dialogTitle:
                        "Are you sure you want to\n delete this sender?",
                    onTapAffirm: () async {
                      await provider.deleteSender(
                          context: context, senderId: item.senderId);

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
