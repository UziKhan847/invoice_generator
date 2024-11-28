import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/receipt.dart';
import 'package:markaz_umaza_invoice_generator/tiles/receipt_tile.dart';

class ReceiptListBuilder extends StatelessWidget {
  const ReceiptListBuilder({super.key, required this.receipts});

  final List<Receipt> receipts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 0, bottom: 0),
        itemCount: receipts.length,
        itemBuilder: (context, index) => ReceiptTile(
              receipt: receipts[index],
            ));
  }
}
