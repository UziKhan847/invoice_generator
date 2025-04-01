import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/models/receipt.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';
import 'package:markaz_umaza_invoice_generator/tiles/dialog_tile.dart';
import 'package:markaz_umaza_invoice_generator/tiles/receipt_tile.dart';

class ReceiptListBuilder extends ConsumerWidget {
  ReceiptListBuilder({super.key, required this.receipts});

  final List<Receipt> receipts;
  late AppData provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    provider = ref.watch(appData);

    return Padding(
  padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ListView.builder(
          padding: const EdgeInsets.only(top: 0, bottom: 0),
          itemCount: receipts.length,
          itemBuilder: (context, index) {
            Receipt item = receipts[index];
      
            return ReceiptTile(
              receipt: item,
              isLastIndex: index == receipts.length - 1,
              onTapDelete: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DialogTile(
                        affirmButtonText: "Yes",
                        cancelButtonText: 'No',
                        dialogTitle:
                            "Are you sure you want to\n delete this receipt?",
                        onTapAffirm: () async {
                          await provider.deleteReceipt(
                              context: context, receiptId: item.receiptId);
      
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
          }),
    );
  }
}
