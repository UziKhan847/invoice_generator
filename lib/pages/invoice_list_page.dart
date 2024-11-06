import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/tiles/invoice_tile.dart';

class InvoiceListPage extends StatelessWidget {
  const InvoiceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoices"),
      ),
      body: ListView.builder(
          itemCount: 15, itemBuilder: (context, index) => const UserTile()),
      floatingActionButton: const FloatingActionButton(onPressed: null),
    );
  }
}
