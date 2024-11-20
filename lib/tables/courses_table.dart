import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/course.dart';
import 'package:markaz_umaza_invoice_generator/utils/general_table_row.dart';

class CoursesTable extends StatelessWidget {
  const CoursesTable(
      {super.key,
      required this.courses,
      required this.subtotal,
      required this.hst,
      required this.total});

  final Map<int, Course> courses;
  final double subtotal;
  final double? hst;
  final double total;

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
          courses[i] == null
              ? GeneralTableRow.row()
              : GeneralTableRow.row(
                  fontSizeTwo: 7,
                  columnOne: "${i + 1}. ${courses[i]!.name}",
                  columnTwo:
                      "\$${courses[i]!.cost}/${courses[i]!.costFrequency}",
                  columnThree: "${courses[i]!.quantity}",
                  columnFour: "\$${courses[i]!.amount}"),
        ],
        GeneralTableRow.row(
          columnOne: "Subtotal",
          columnFour: "\$$subtotal",
        ),
        GeneralTableRow.row(
          columnOne: "HST %13",
          columnFour: "\$$hst",
        ),
        //Bold Final Top Border
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
    );
  }
}
