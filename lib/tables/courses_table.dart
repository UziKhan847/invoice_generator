import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/utils/general_table_row.dart';

class CoursesTable extends StatelessWidget {
  const CoursesTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      //defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: const <int, TableColumnWidth>{0: FixedColumnWidth(160)},
      children: <TableRow>[
        GeneralTableRow.row(
          decoration: BoxDecoration(color: Colors.grey.shade300),
          fontSize: 10,
          textAlign: TextAlign.center,
          columnOne: "DESCRIPTION",
          columnTwo: "QUANTITY",
          columnThree: "AMOUNT",
        ),
        GeneralTableRow.row(
          columnOne: "[Name of Course]",
        ),
        GeneralTableRow.row(),
        GeneralTableRow.row(),
        GeneralTableRow.row(),
        GeneralTableRow.row(),
        GeneralTableRow.row(
          columnOne: "HST %13",
        ),
        //Bold Final Top Border
        TableRow(
          children: [
            Container(
              color: Colors.black,
              height: 1,
            ),
            Container(),
            Container(),
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
