import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/list_view_builders/invoice_list_builder.dart';
import 'package:markaz_umaza_invoice_generator/models/course.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/models/recipient.dart';
import 'package:markaz_umaza_invoice_generator/models/sender.dart';
import 'package:markaz_umaza_invoice_generator/widgets/filter_bar.dart';
import 'package:markaz_umaza_invoice_generator/widgets/filter_row.dart';

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
  bool isExpanded = false;
  late List<Invoice> filteredInvoices;
  Set<String> selectedSenders = {};
  Set<String> selectedRecipients = {};
  Set<String> selectedCourses = {};
  Set<String> selectedYears = {};
  Set<String> selectedMonths = {};
  Set<String> selectedDays = {};

  late List<String> senderNames = widget.senders.map((e) => e.name).toList();
  late List<String> recipientsNames =
      widget.recipients.map((e) => e.name).toList();
  late List<String> courseNames = widget.courses.map((e) => e.name).toList();
  late List<String> years = widget.invoices
      .map((invoice) => invoice.invoiceDate.substring(0, 4))
      .toSet()
      .toList();
  late List<String> months = widget.invoices
      .map((invoice) => invoice.invoiceDate.substring(5, 7))
      .toSet()
      .toList();
  late List<String> days = widget.invoices
      .map((invoice) =>
          invoice.invoiceDate.substring(8, invoice.invoiceDate.length))
      .toSet()
      .toList();

  @override
  void initState() {
    super.initState();
  }

  void filterInvoices() {
    filteredInvoices = widget.invoices.where((invoice) {
      bool matchesSender = selectedSenders.isEmpty ||
          selectedSenders.contains(invoice.senders.name);
      bool matchesRecipient = selectedRecipients.isEmpty ||
          selectedRecipients.contains(invoice.recipients.name);
      bool matchesCourse = selectedCourses.isEmpty ||
          invoice.invoiceCourses!.any((invoiceCourse) =>
              selectedCourses.contains(invoiceCourse.courses.name));
      bool matchesYear = selectedYears.isEmpty ||
          selectedYears.contains(invoice.invoiceDate.substring(0, 4));
      bool matchesMonth = selectedMonths.isEmpty ||
          selectedMonths.contains(invoice.invoiceDate.substring(5, 7));
      bool matchesDay = selectedDays.isEmpty ||
          selectedDays.contains(
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
    senderNames.sort();
    recipientsNames.sort();
    courseNames.sort();
    years.sort();
    months.sort();
    days.sort();
    filteredInvoices = List.from(widget.invoices);
    filterInvoices();

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
              FilterBar(
                isExpanded: isExpanded,
                onTap: () {
                  isExpanded = !isExpanded;

                  setState(() {});
                },
                indicatorColor: widget.indicatorColor,
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: isExpanded ? 300 : 0,
                decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
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
                child: ListView(
                  children: [
                    for (int i = 0; i < 6; i++) ...[
                      FilterRow(
                        rowLabel: switch (i) {
                          1 => 'Recipients',
                          2 => 'Courses',
                          3 => 'Years',
                          4 => 'Months',
                          5 => 'Days',
                          _ => 'Senders'
                        },
                        items: switch (i) {
                          1 => recipientsNames,
                          2 => courseNames,
                          3 => years,
                          4 => months,
                          5 => days,
                          _ => senderNames
                        },
                        selectedItems: switch (i) {
                          1 => selectedRecipients,
                          2 => selectedCourses,
                          3 => selectedYears,
                          4 => selectedMonths,
                          5 => selectedDays,
                          _ => selectedSenders
                        },
                        update: update,
                      ),
                      if (i < 5)
                        const Divider(
                          height: 0,
                        ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            height: 70,
            width: MediaQuery.of(context).size.width * 0.75,
            bottom: 8,
            left: widget.isOnPage
                ? -10
                : -MediaQuery.of(context).size.width * 0.75,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 30),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.25),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    )
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("# of Invoices: ${filteredInvoices.length}"),
                ],
              ),
            ))
      ],
    );
  }
}
