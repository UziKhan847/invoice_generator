import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/course.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';
import 'package:markaz_umaza_invoice_generator/widgets/custom_list_tile.dart';
import 'package:markaz_umaza_invoice_generator/widgets/tile_row.dart';

class CourseTile extends StatelessWidget {
  const CourseTile(
      {super.key,
      required this.course,
      required this.isLastIndex,
      this.onTapDelete,
      this.onTapEdit});

  final Course course;
  final bool isLastIndex;

  final void Function()? onTapDelete;
  final void Function()? onTapEdit;

  @override
  Widget build(BuildContext context) {
    //int courseNameLength = course.name.length;

    return CustomListTile(
      isLastIndex: isLastIndex,
      onTapEdit: onTapEdit,
      onTapDelete: onTapDelete,
      leadingIcon: const Icon(
        Icons.my_library_books,
        size: 20,
      ),
      content: [
        Margins.vertical4,
        for (int i = 0; i < 3; i++) ...[
          switch (i) {
            1 => TileRow("Name: ", course.name),
            2 => TileRow(
                "Course Cost: ", "\$${course.cost}/${course.costFrequency}"),
            _ => TileRow("Course Id: ", "${course.courseId}")
          },
        ],
        Margins.vertical4,
      ],
    );
  }
}
