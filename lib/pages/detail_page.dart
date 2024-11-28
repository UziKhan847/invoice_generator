import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/course.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/models/receipt.dart';
import 'package:markaz_umaza_invoice_generator/models/recipient.dart';
import 'package:markaz_umaza_invoice_generator/models/sender.dart';
import 'package:markaz_umaza_invoice_generator/pages/pdf_preview_page.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';
import 'package:markaz_umaza_invoice_generator/tables/courses_table.dart';
import 'package:markaz_umaza_invoice_generator/widgets/general_text.dart';

class DetailPage extends StatefulWidget {
  const DetailPage(
      {super.key,
      required this.isInvoice,
      this.receipt,
      required this.invoice,
      required this.sender,
      required this.recipient,
      required this.courses});

  final bool isInvoice;
  final Receipt? receipt;
  final Invoice invoice;
  final Sender sender;
  final Recipient recipient;
  final List<Course>? courses;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.isInvoice ? "Invoice" : "Receipt"} Details"),
        backgroundColor: widget.isInvoice
            ? Theme.of(context).appBarTheme.backgroundColor
            : const Color(0xFF421070),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFBDBDBD), Color(0xFFEEEDED)])),
        child: Padding(
          padding:
              const EdgeInsets.only(right: 8.0, left: 8, top: 13, bottom: 82),
          child: Material(
            elevation: 6,
            child: Container(
              padding: const EdgeInsets.all(24.0),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Markaz Umaza",
                            style: TextStyle(
                                fontFamily: "LiberationSans",
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Margins.vertical2,
                          GeneralText(
                            text: "BN ${widget.sender.businessNumber}",
                          ),
                          GeneralText(
                              text:
                                  "${widget.sender.street}, ${widget.sender.city}, ${widget.sender.province}"),
                          GeneralText(
                            text: widget.sender.email,
                          ),
                          GeneralText(
                            text: widget.sender.phone,
                          ),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                      Column(
                        children: [
                          Image.asset(
                            "images/markaz_umaza_logo.png",
                            width: 50,
                          ),
                          GeneralText(
                            text: widget.isInvoice ? "INVOICE" : "RECEIPT",
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF828282),
                            fontSize: 16.0,
                          ),
                        ],
                      ),
                      Margins.horizontal10,
                    ],
                  ),
                  Margins.vertical36,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GeneralText(
                            text: widget.isInvoice ? "BILL TO" : "BILLED TO",
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          Margins.vertical6,
                          Container(
                            height: 1.5,
                            width: 80.0,
                            color: Colors.grey,
                          ),
                          Margins.vertical10,
                          GeneralText(
                            text: widget.recipient.name,
                          ),
                          GeneralText(
                            text: widget.recipient.street,
                          ),
                          GeneralText(
                            text:
                                "${widget.recipient.city}, ${widget.recipient.province}, ${widget.recipient.zip}",
                          ),
                          GeneralText(
                            text: widget.recipient.email,
                          ),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GeneralText(
                            text:
                                "${widget.isInvoice ? "Invoice" : "Receipt"} No:",
                            fontWeight: FontWeight.bold,
                          ),
                          Margins.vertical22,
                          GeneralText(
                            text:
                                "${widget.isInvoice ? "Invoice" : "Receipt"} Date:",
                            fontWeight: FontWeight.bold,
                          ),
                          if (widget.isInvoice)
                            GeneralText(
                              text: widget.invoice.dueDate == null
                                  ? ""
                                  : "Due Date:",
                              fontWeight: FontWeight.bold,
                            ),
                        ],
                      ),
                      Margins.horizontal6,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GeneralText(
                            text:
                                "#${widget.isInvoice ? widget.invoice.invoiceId : widget.receipt!.receiptId}",
                          ),
                          Margins.vertical22,
                          GeneralText(
                            text: widget.isInvoice
                                ? widget.invoice.invoiceDate
                                : widget.receipt!.receiptDate,
                          ),
                          if (widget.isInvoice)
                            GeneralText(
                              text: widget.invoice.dueDate ?? "",
                            ),
                        ],
                      ),
                    ],
                  ),
                  Margins.vertical26,
                  CoursesTable(
                    isInvoice: widget.isInvoice,
                    courses: widget.courses!.asMap(),
                    subtotal: widget.invoice.subtotal,
                    hst: widget.invoice.hst,
                    total: widget.invoice.total,
                    paid: !widget.isInvoice ? widget.receipt!.paid : null,
                  ),
                  Margins.vertical26,
                  const GeneralText(
                    text:
                        "Thank you for you business!\nWe look forward to serving you again",
                    textAlign: TextAlign.center,
                    fontSize: 9.0,
                  ),
                  Margins.vertical32,
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const GeneralText(
                            text: "Method of Payment",
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                          Container(
                            height: 1,
                            width: 130.0,
                            color: Colors.grey.shade500,
                          ),
                          Row(
                            children: [
                              const GeneralText(
                                text: "E-transfer to: ",
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              GeneralText(
                                text: "${widget.sender.eTransfer}",
                                fontSize: 12,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: widget.isInvoice
            ? Theme.of(context).appBarTheme.backgroundColor
            : const Color(0xFF421070),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PdfPreviewPage(
                        isInvoice: widget.isInvoice,
                        receipt: !widget.isInvoice ? widget.receipt : null,
                        invoice: widget.invoice,
                        sender: widget.sender,
                        recipient: widget.recipient,
                        courses: widget.courses!.asMap(),
                      )));
        },
        child: const Icon(Icons.picture_as_pdf_rounded),
      ),
    );
  }
}
