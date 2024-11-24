import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/sender.dart';
import 'package:markaz_umaza_invoice_generator/tiles/sender_tile.dart';

class SenderListBuilder extends StatelessWidget {
  const SenderListBuilder({super.key, required this.senders});

  final List<Sender> senders;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 0, bottom: 0),
        itemCount: senders.length,
        itemBuilder: (context, index) => SenderTile(
              sender: senders[index],
            ));
  }
}
