import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_menu_tile.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';

class DropdownCourseTile extends StatelessWidget {
  const DropdownCourseTile({
    super.key,
    this.isFirstCourse = false,
    this.isLastCourse = false,
    required this.isSelected,
    required this.courseNumber,
    this.controller,
    this.onTapAdd,
    this.onTapMenuBox,
    this.onTapRemove,
    this.textStyle,
    this.arrowDownColor,
    this.arrowUpColor,
  });

  final bool isFirstCourse;
  final bool isLastCourse;
  final bool isSelected;
  final TextEditingController? controller;
  final int courseNumber;
  final void Function()? onTapMenuBox;
  final void Function()? onTapAdd;
  final void Function()? onTapRemove;
  final TextStyle? textStyle;
  final Color? arrowUpColor;
  final Color? arrowDownColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isFirstCourse || isLastCourse
          ? MainAxisAlignment.start
          : MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            height: 65,
            width: 170,
            child: DropdownMenuTile(
              textStyle: textStyle,
              arrowUpColor: arrowUpColor,
              arrowDownColor: arrowDownColor,
              controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select Course $courseNumber";
                }
                return null;
              },
              textPadding: const EdgeInsets.only(
                  top: 12, bottom: 12, right: 22, left: 10),
              labelText: "Course $courseNumber*",
              labelTextSize: 16,
              isSelected: isSelected,
              arrowRightPosition: 2,
              arrowTopPosition: 12,
              menuInkHeight: 47,
              onTapMenuBox: onTapMenuBox,
            )),
        Margins.horizontal4,
        if (!isLastCourse) ...[
          IconButton(
            style: const ButtonStyle(
                iconSize: WidgetStatePropertyAll(20),
                shape: WidgetStatePropertyAll(CircleBorder()),
                //backgroundColor: WidgetStatePropertyAll(Color(0xFFFFFFFF)),
                overlayColor: WidgetStatePropertyAll(Color(0xFFD7FFD8))),
            onPressed: onTapAdd,
            icon: const Icon(Icons.add),
          )
        ],
        if (!isFirstCourse) ...[
          IconButton(
            style: const ButtonStyle(
                iconSize: WidgetStatePropertyAll(20),
                shape: WidgetStatePropertyAll(CircleBorder()),
                //backgroundColor: WidgetStatePropertyAll(Color(0xFFFFFFFF)),
                overlayColor: WidgetStatePropertyAll(Color(0xFFFFD7D7))),
            onPressed: onTapRemove,
            icon: const Icon(Icons.remove),
          )
        ],
      ],
    );
  }
}
