import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/tiles/invoice_tile.dart';

class InvoiceListBuilder extends StatelessWidget {
  const InvoiceListBuilder({super.key, required this.invoices});

  final List<Invoice> invoices;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 0, bottom: 0),
        itemCount: invoices.length,
        itemBuilder: (context, index) => InvoiceTile(
              invoice: invoices[index],
            ));
  }
}
