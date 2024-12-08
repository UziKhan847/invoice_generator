import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice_course.dart';
import 'package:markaz_umaza_invoice_generator/utils/general_table_row.dart';

class CoursesTable extends StatelessWidget {
  const CoursesTable(
      {super.key,
      required this.isInvoice,
      this.paid,
      required this.invoiceCourses,
      required this.subtotal,
      required this.hst,
      required this.total});

  final Map<int, InvoiceCourse> invoiceCourses;
  final double? paid;
  final double subtotal;
  final double? hst;
  final double total;
  final bool isInvoice;

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      //defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(145),
        1: FixedColumnWidth(50),
        2: FixedColumnWidth(50),
        3: FixedColumnWidth(50),
      },
      children: <TableRow>[
        GeneralTableRow.row(
          decoration: BoxDecoration(color: Colors.grey.shade300),
          fontSizeTwo: 6.5,
          fontSizeThree: 7,
          textAlign: TextAlign.center,
          columnOne: "DESCRIPTION",
          columnTwo: "COST (CAD)",
          columnThree: "QUANTITY",
          columnFour: "AMOUNT",
        ),
        for (int i = 0; i < 5; i++) ...[
          invoiceCourses[i] == null
              ? GeneralTableRow.row()
              : GeneralTableRow.row(
                  fontSizeTwo: 7,
                  columnOne: "${i + 1}. ${invoiceCourses[i]!.courses.name}",
                  columnTwo:
                      "\$${invoiceCourses[i]!.courses.cost}/${invoiceCourses[i]!.courses.costFrequency}",
                  columnThree: "${invoiceCourses[i]!.quantity}",
                  columnFour: "\$${invoiceCourses[i]!.amount}"),
        ],
        GeneralTableRow.row(
          columnOne: "Subtotal",
          columnFour: "\$$subtotal",
        ),
        GeneralTableRow.row(
          columnOne: "HST %13",
          columnFour: "\$$hst",
        ),
        if (isInvoice) ...[
          TableRow(
            children: [
              for (int i = 0; i < 4; i++) ...[
                const SizedBox(
                  height: 1,
                )
              ]
            ],
          ),
          GeneralTableRow.row(
            fontWeight: FontWeight.bold,
            columnOne: "TOTAL",
            columnFour: "\$$total",
          ),
        ],
        if (!isInvoice) ...[
          GeneralTableRow.row(
            columnOne: "TOTAL",
            columnFour: "\$$total",
          ),
          TableRow(
            children: [
              for (int i = 0; i < 4; i++) ...[
                const SizedBox(
                  height: 1,
                )
              ]
            ],
          ),
          GeneralTableRow.row(
            fontWeight: FontWeight.bold,
            columnOne: "PAID",
            columnFour: "\$$paid",
          ),
        ]
      ],
    );
  }
}
