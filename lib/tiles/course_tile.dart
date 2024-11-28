import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/course.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';
import 'package:markaz_umaza_invoice_generator/widgets/tile_row.dart';

class CourseTile extends StatelessWidget {
  const CourseTile({super.key, required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.my_library_books,
              size: 20,
            ),
            title: Column(
              children: [
                for (int i = 0; i < 5; i++) ...[
                  switch (i) {
                    1 => TileRow("Course Name: ", course.name),
                    2 => TileRow("Course Cost: ",
                        "\$${course.cost}/${course.costFrequency}"),
                    3 => TileRow("Course Quantity: ", "${course.quantity}"),
                    4 =>
                      TileRow("Total Amount (w/o Tax): ", "\$${course.amount}"),
                    _ => TileRow("Course Id: ", "${course.courseId}")
                  },
                  if (i != 4) ...[
                    Margins.vertical4,
                  ]
                ],
              ],
            ),
          ),
          const Divider(
            height: 0,
          ),
        ],
      ),
    );
  }
}
