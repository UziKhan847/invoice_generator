import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/course.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/models/recipient.dart';
import 'package:markaz_umaza_invoice_generator/models/sender.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';
import 'package:markaz_umaza_invoice_generator/tables/courses_table.dart';
import 'package:markaz_umaza_invoice_generator/widgets/general_text.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.invoice});

  final Invoice invoice;

  @override
  Widget build(BuildContext context) {
    Sender sender = invoice.senders;
    Recipient recipient = invoice.recipients;
    List<Course?> courses = invoice.courses;

    while (courses.length < 5) {
      courses.add(null);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice Details"),
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
              const EdgeInsets.only(right: 8.0, left: 8, top: 15, bottom: 90),
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
                            text: "${sender.name}",
                          ),
                          GeneralText(
                            text:
                                "${sender.street}, ${sender.city}, ${sender.province}",
                          ),
                          GeneralText(
                            text: invoice.senders.email!,
                          ),
                          GeneralText(
                            text: "${sender.phone}",
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
                          const GeneralText(
                            text: "INVOICE",
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF828282),
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
                          const GeneralText(
                            text: "BILL TO",
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
                            text: "${recipient.name}",
                          ),
                          GeneralText(
                            text: "${recipient.street}",
                          ),
                          GeneralText(
                            text:
                                "${recipient.city}, ${recipient.province}, ${recipient.zip}",
                          ),
                          GeneralText(
                            text: "${recipient.email}",
                          ),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GeneralText(
                            text: "Invoice No:",
                            fontWeight: FontWeight.bold,
                          ),
                          Margins.vertical22,
                          GeneralText(
                            text: "Invoice Date:",
                            fontWeight: FontWeight.bold,
                          ),
                          GeneralText(
                            text: "Due Date:",
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      Margins.horizontal6,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GeneralText(
                            text: "${invoice.invoiceId}",
                          ),
                          Margins.vertical22,
                          GeneralText(
                            text: invoice.invoiceDate,
                          ),
                          GeneralText(
                            text: "${invoice.dueDate}",
                          ),
                        ],
                      ),
                    ],
                  ),
                  Margins.vertical26,
                  CoursesTable(courses: courses,),
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
                                text: "${sender.eTransfer}",
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
        onPressed: () {
          Navigator.pushNamed(context, "/pdf_preview_page");
        },
        child: const Icon(Icons.picture_as_pdf_rounded),
      ),
    );
  }
}
