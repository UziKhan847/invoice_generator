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
        Margins.vertical10,
        IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    course.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              const VerticalDivider(
                thickness: 1,
                color: Colors.black,
              ),
              SizedBox(
                width: 80,
                child: Center(
                  child: Text(
                    "\$${course.cost}\n/${course.costFrequency}",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
        Margins.vertical10,
      ],
    );
  }
}
