import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';
import 'package:markaz_umaza_invoice_generator/tiles/dialog_tile.dart';
import 'package:markaz_umaza_invoice_generator/tiles/invoice_tile.dart';

class InvoiceListBuilder extends ConsumerStatefulWidget {
  const InvoiceListBuilder({super.key, required this.filteredInvoices});

  final List<Invoice> filteredInvoices;

  @override
  ConsumerState<InvoiceListBuilder> createState() => _InvoiceListBuilderState();
}

class _InvoiceListBuilderState extends ConsumerState<InvoiceListBuilder> {
  late AppData provider;

  @override
  Widget build(BuildContext context) {
    provider = ref.watch(appData);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: ListView.builder(
          padding: const EdgeInsets.only(top: 0, bottom: 0),
          itemCount: widget.filteredInvoices.length,
          itemBuilder: (context, index) {
            Invoice item = widget.filteredInvoices.reversed.toList()[index];

            return InvoiceTile(
              isLastIndex: index == widget.filteredInvoices.length - 1,
              invoice: item,
              onTapDelete: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DialogTile(
                        affirmButtonText: "Yes",
                        cancelButtonText: 'No',
                        dialogTitle:
                            "Are you sure you want to\n delete this invoice?",
                        onTapAffirm: () async {
                          await provider.deleteInvoice(
                              context: context, invoiceId: item.invoiceId);

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
