import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';
import 'package:markaz_umaza_invoice_generator/tables/courses_table.dart';
import 'package:markaz_umaza_invoice_generator/widgets/general_text.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Markaz Umaza",
                            style: TextStyle(
                                fontFamily: "LiberationSans",
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Margins.vertical2,
                          GeneralText(
                            text: "[Name Optional]",
                          ),
                          GeneralText(
                            text: "118 Chestnut Avenue, Hamitlon, ON",
                          ),
                          GeneralText(
                            text: "[letter].saleem@markazumaza.com",
                          ),
                          GeneralText(
                            text: "+1 (289)-456-9089",
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
                          const GeneralText(
                            text: "[Name/Company Name]",
                          ),
                          const GeneralText(
                            text: "[Street]",
                          ),
                          const GeneralText(
                            text: "[City, Prov, ZIP]",
                          ),
                          const GeneralText(
                            text: "[Email]",
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
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GeneralText(
                            text: "4085292927",
                          ),
                          Margins.vertical22,
                          GeneralText(
                            text: "MM/DD/YYYY",
                          ),
                          GeneralText(
                            text: "MM/DD/YYYY",
                          ),
                        ],
                      ),
                    ],
                  ),
                  Margins.vertical26,
                  const CoursesTable(),
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
                          const Row(
                            children: [
                              GeneralText(
                                text: "E-transfer to: ",
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                              GeneralText(
                                text: "[etransfer@email.com]",
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
