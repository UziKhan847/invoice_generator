import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';
import 'package:markaz_umaza_invoice_generator/tiles/invoice_tile.dart';

class InvoiceListPage extends ConsumerWidget {
  InvoiceListPage({super.key});

  late final AppData provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    provider = ref.watch(appData);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoices"),
      ),
      body: ListView.builder(
          itemCount: provider.invoices.length,
          itemBuilder: (context, index) => InvoiceTile(
                invoice: provider.invoices[index],
              )),
      floatingActionButton: const FloatingActionButton(onPressed: null),
    );
  }
}
