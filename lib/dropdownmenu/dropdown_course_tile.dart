import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_menu_tile.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';

class DropdownCourseTile extends StatelessWidget {
  DropdownCourseTile({
    super.key,
    this.isFirstCourse = false,
    this.isLastCourse = false,
    required this.isSelected,
    required this.courseNumber,
    this.courseController,
    this.quantityController,
    this.quantityFocus,
    this.onTapAffirm,
    this.onTapMenuBox,
    this.onTapRemove,
    this.textStyle,
    this.arrowDownColor,
    this.arrowUpColor,
    this.isEnabled = true,
  });

  final bool isFirstCourse;
  final bool isLastCourse;
  final bool isSelected;
  final bool isEnabled;
  final TextEditingController? courseController;
  final TextEditingController? quantityController;
  final FocusNode? quantityFocus;
  final int courseNumber;
  final void Function()? onTapMenuBox;
  final void Function()? onTapAffirm;
  final void Function()? onTapRemove;
  final TextStyle? textStyle;
  final Color? arrowUpColor;
  final Color? arrowDownColor;
  final numTwoDecimalsRegex = RegExp(r'^\d+(\.\d{1,2})?$');
  final leadingZerosRegex = RegExp(r'^0+\d');

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            height: 65,
            width: 180,
            child: DropdownMenuTile(
              textStyle: textStyle,
              arrowUpColor: arrowUpColor,
              arrowDownColor: arrowDownColor,
              controller: courseController,
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
        SizedBox(
          width: 70,
          child: TextFormField(
            keyboardType: const TextInputType.numberWithOptions(),
            focusNode: quantityFocus,
            enabled: isEnabled,
            controller: quantityController,
            onTapOutside: (_) => quantityFocus!.unfocus(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Invalid';
              } else if (!numTwoDecimalsRegex.hasMatch(value) ||
                  leadingZerosRegex.hasMatch(value)) {
                return 'Invalid';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: "Quantity*",
              labelStyle: TextStyle(fontSize: 10),
            ),
          ),
        ),
      ],
    );
  }
}
