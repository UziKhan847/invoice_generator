import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/list_view_builders/invoice_list_builder.dart';
import 'package:markaz_umaza_invoice_generator/models/course.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/models/recipient.dart';
import 'package:markaz_umaza_invoice_generator/models/sender.dart';
import 'package:markaz_umaza_invoice_generator/filter/filter_bar.dart';
import 'package:markaz_umaza_invoice_generator/filter/filter_box.dart';
import 'package:markaz_umaza_invoice_generator/widgets/bottom_info_bar.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage(
      {super.key,
      required this.invoices,
      required this.courses,
      required this.recipients,
      required this.senders,
      required this.isOnPage,
      required this.indicatorColor,
      required this.navBarColor});

  final List<Invoice> invoices;
  final List<Sender> senders;
  final List<Recipient> recipients;
  final List<Course> courses;
  final bool isOnPage;
  final Color navBarColor;
  final Color indicatorColor;

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage> {
  double netincome = 0;
  double hst = 0;
  double get grossIncome => double.parse((netincome - hst).toStringAsFixed(2));
  bool isExpanded = false;
  bool isBottomInfoBarExpanded = false;
  late List<Invoice> filteredInvoices;
  Map<String, Set<String>> selectedFilters = {
    'senders': {},
    'recipients': {},
    'courses': {},
    'years': {},
    'months': {},
    'days': {},
  };

  late Map<String, List<String>> filterOptions = {
    'senders': widget.senders.map((e) => e.name).toList(),
    'recipients': widget.recipients.map((e) => e.name).toList(),
    'courses': widget.courses.map((e) => e.name).toList(),
    'years': widget.invoices
        .map((invoice) => invoice.invoiceDate.substring(0, 4))
        .toSet()
        .toList(),
    'months': widget.invoices
        .map((invoice) => invoice.invoiceDate.substring(5, 7))
        .toSet()
        .toList(),
    'days': widget.invoices
        .map((invoice) =>
            invoice.invoiceDate.substring(8, invoice.invoiceDate.length))
        .toSet()
        .toList(),
  };

//   late List<String> filterCategories = [
//   'Recipients',
//   'Courses',
//   'Years',
//   'Months',
//   'Days',
//   'Senders',
// ];

  @override
  void initState() {
    super.initState();
  }

  void filterInvoices() {
    filteredInvoices = widget.invoices.where((invoice) {
      bool matchesSender = selectedFilters['senders']!.isEmpty ||
          selectedFilters['senders']!.contains(invoice.senders.name);
      bool matchesRecipient = selectedFilters['recipients']!.isEmpty ||
          selectedFilters['recipients']!.contains(invoice.recipients.name);
      bool matchesCourse = selectedFilters['courses']!.isEmpty ||
          invoice.invoiceCourses!.any((invoiceCourse) =>
              selectedFilters['courses']!.contains(invoiceCourse.courses.name));
      bool matchesYear = selectedFilters['years']!.isEmpty ||
          selectedFilters['years']!
              .contains(invoice.invoiceDate.substring(0, 4));
      bool matchesMonth = selectedFilters['months']!.isEmpty ||
          selectedFilters['months']!
              .contains(invoice.invoiceDate.substring(5, 7));
      bool matchesDay = selectedFilters['days']!.isEmpty ||
          selectedFilters['days']!.contains(
              invoice.invoiceDate.substring(8, invoice.invoiceDate.length));

      return matchesSender &&
          matchesRecipient &&
          matchesCourse &&
          matchesYear &&
          matchesMonth &&
          matchesDay;
    }).toList();
  }

  void update() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    filterOptions.forEach((k, v) {
      v.sort();
    });
    filteredInvoices = List.from(widget.invoices);
    filterInvoices();

    if (filteredInvoices.isNotEmpty) {
      netincome = double.parse(filteredInvoices
          .map((e) => e.total.toDouble())
          .reduce((a, b) => a + b)
          .toStringAsFixed(2));
      hst = double.parse(filteredInvoices
          .map((e) => e.hst == null ? 0.0 : e.hst!.toDouble())
          .reduce((a, b) => a + b)
          .toStringAsFixed(2));
    } else {
      netincome = 0;
      hst = 0;
    }

    return Stack(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Expanded(
                child: InvoiceListBuilder(filteredInvoices: filteredInvoices)),
          ],
        ),
        if (isExpanded)
          Positioned(
              child: GestureDetector(
            onTap: () {
              isExpanded = !isExpanded;

              setState(() {});
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              color: Colors.black.withValues(alpha: 0.4),
            ),
          )),
        Positioned(
          top: 0,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              FilterBar(
                isExpanded: isExpanded,
                onTap: () {
                  isExpanded = !isExpanded;

                  setState(() {});
                },
                indicatorColor: widget.indicatorColor,
              ),
              FilterBox(
                  isExpanded: isExpanded,
                  filterOptions: filterOptions.values.toList(),
                  selectedFilters: selectedFilters.values.toList(),
                  update: update)
            ],
          ),
        ),
        BottomInfoBar(
          filteredInvoices: filteredInvoices,
          isOnPage: widget.isOnPage,
          item: "Invoice",
          grossIncome: grossIncome,
          hst: hst,
          netIncome: netincome,
          isExpanded: isBottomInfoBarExpanded,
          expandButtonColor: widget.indicatorColor,
          onTapArrow: () {
            setState(() {
              isBottomInfoBarExpanded = !isBottomInfoBarExpanded;
            });
          },
        )
      ],
    );
  }
}
