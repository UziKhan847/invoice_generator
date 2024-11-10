import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/course.dart';
import 'package:markaz_umaza_invoice_generator/utils/general_table_row.dart';

class CoursesTable extends StatelessWidget {
  const CoursesTable({super.key, required this.courses});

  final List<Course?> courses;

  @override
  Widget build(BuildContext context) {
    Course? courseOne = courses[0];
    Course? courseTwo = courses[1];
    Course? courseThree = courses[2];
    Course? courseFour = courses[3];
    Course? courseFive = courses[4];

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
          fontSizeThree: 7,
          textAlign: TextAlign.center,
          columnOne: "DESCRIPTION",
          columnTwo: "COST",
          columnThree: "QUANTITY",
          columnFour: "AMOUNT",
        ),
        courseOne == null
            ? GeneralTableRow.row()
            : GeneralTableRow.row(
                columnOne: "${courseOne.name}",
                columnTwo: "${courseOne.cost}",
                columnThree: "${courseOne.quantity}",
                columnFour: "${courseOne.amount}"),
        courseTwo == null
            ? GeneralTableRow.row()
            : GeneralTableRow.row(
                columnOne: "${courseTwo.name}",
                columnTwo: "${courseTwo.cost}",
                columnThree: "${courseTwo.quantity}",
                columnFour: "${courseTwo.amount}"),
        courseThree == null
            ? GeneralTableRow.row()
            : GeneralTableRow.row(
                columnOne: "${courseThree.name}",
                columnTwo: "${courseThree.cost}",
                columnThree: "${courseThree.quantity}",
                columnFour: "${courseThree.amount}"),
        courseFour == null
            ? GeneralTableRow.row()
            : GeneralTableRow.row(
                columnOne: "${courseFour.name}",
                columnTwo: "${courseFour.cost}",
                columnThree: "${courseFour.quantity}",
                columnFour: "${courseFour.amount}"),
        courseFive == null
            ? GeneralTableRow.row()
            : GeneralTableRow.row(
                columnOne: "${courseFive.name}",
                columnTwo: "${courseFive.cost}",
                columnThree: "${courseFive.quantity}",
                columnFour: "${courseFive.amount}"),
        GeneralTableRow.row(columnOne: "Subtotal"),
        GeneralTableRow.row(
          columnOne: "HST %13",
        ),
        //Bold Final Top Border
        const TableRow(
          children: [
            SizedBox(
              height: 1,
            ),
            SizedBox(),
            SizedBox(),
            SizedBox(),
          ],
        ),
        GeneralTableRow.row(
          fontWeight: FontWeight.bold,
          columnOne: "TOTAL",
        ),
      ],
    );
  }
}
