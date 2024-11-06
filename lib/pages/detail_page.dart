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
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
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
                    Margins.vertical4,
                    GeneralText(
                      text: "[Name]",
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
                Margins.horizontal14,
              ],
            ),
            Margins.vertical43,
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
                    Margins.vertical12,
                    const GeneralText(
                      text: "[Name]",
                    ),
                    const GeneralText(
                      text: "[Company]",
                    ),
                    const GeneralText(
                      text: "[Address]",
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
                      text: "#------",
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
            Margins.vertical32,
            const CoursesTable(),
            Margins.vertical32,
            const GeneralText(
              text:
                  "Thank you for you business!\nWe look forward to serving you again",
              textAlign: TextAlign.center,
              fontSize: 9.0,
            ),
            Margins.vertical64,
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
      floatingActionButton: const FloatingActionButton(onPressed: null),
    );
  }
}
