import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/pages/tabs_page.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';
import 'package:markaz_umaza_invoice_generator/tiles/dialog_tile.dart';
import 'package:markaz_umaza_invoice_generator/tiles/invoice_tile.dart';

class InvoiceListBuilder extends ConsumerStatefulWidget {
  const InvoiceListBuilder({super.key, required this.invoices});

  final List<Invoice> invoices;

  @override
  ConsumerState<InvoiceListBuilder> createState() => _InvoiceListBuilderState();
}

class _InvoiceListBuilderState extends ConsumerState<InvoiceListBuilder> {
  late AppData provider;
  bool isExpanded = false;
  late List<Invoice> filteredInvoices;
  Set<String> selectedSenders = {};

  @override
  void initState() {
    super.initState();
    filteredInvoices = List.from(widget.invoices);
  }

  void filterInvoices() {
    filteredInvoices = widget.invoices.where((invoice) {
      bool matchesName = selectedSenders.isEmpty ||
          selectedSenders.contains(invoice.senders.name);
      return matchesName;
    }).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    provider = ref.watch(appData);

    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.only(top: 0, bottom: 0),
                  itemCount: filteredInvoices.length,
                  itemBuilder: (context, index) {
                    Invoice item = filteredInvoices.reversed.toList()[index];

                    return InvoiceTile(
                      isLastIndex: index == widget.invoices.length - 1,
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
                                      context: context,
                                      invoiceId: item.invoiceId);

                                  if (context.mounted) {
                                    //Navigator.pop(context);
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const TabsPage()),
                                      (route) => false,
                                    );
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
            ),
          ],
        ),
        Positioned(
            child: IgnorePointer(
          ignoring: isExpanded ? false : true,
          child: GestureDetector(
            onTap: () {
              isExpanded = !isExpanded;

              setState(() {});
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              color: Colors.black.withValues(alpha: isExpanded ? 0.4 : 0),
            ),
          ),
        )),
        Positioned(
          top: 0,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  isExpanded = !isExpanded;

                  setState(() {});
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color(0xFFE48787),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.16),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        )
                      ]),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: isExpanded ? 300 : 0,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.16),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      )
                    ]),
                child: Column(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 8, bottom: 8, left: 14),
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: 50,
                      child: Row(
                        children: [
                          const SizedBox(width: 80, child: Text("Senders:")),
                          Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: provider.senders.length,
                                itemBuilder: (context, index) {
                                  final sender = provider.senders[index].name;

                                  return GestureDetector(
                                    onTap: () {
                                      selectedSenders.contains(sender)
                                          ? selectedSenders.remove(sender)
                                          : selectedSenders.add(sender);

                                      filterInvoices();
                                    },
                                    child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        decoration: BoxDecoration(
                                            color:
                                                selectedSenders.contains(sender)
                                                    ? const Color.fromARGB(
                                                        255, 172, 22, 22)
                                                    : const Color.fromARGB(
                                                        255, 235, 166, 166),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                color: Colors.black
                                                    .withValues(alpha: 0.16),
                                                blurRadius: 6,
                                                offset: const Offset(0, 2),
                                              )
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Center(
                                            child: Text(
                                          sender,
                                          style: TextStyle(
                                              color: selectedSenders
                                                      .contains(sender)
                                                  ? Colors.white
                                                  : Colors.black),
                                        ))),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
