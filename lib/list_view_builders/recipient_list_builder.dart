import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/recipient.dart';
import 'package:markaz_umaza_invoice_generator/tiles/recipient_tile.dart';

class RecipientListBuilder extends StatelessWidget {
  RecipientListBuilder({super.key, required this.recipients});

  List<Recipient> recipients;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 0, bottom: 0),
        itemCount: recipients.length,
        itemBuilder: (context, index) => RecipientTile(
              recipient: recipients[index],
            ));
  }
}
