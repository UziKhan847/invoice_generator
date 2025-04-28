import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_menu_tile.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/properties.dart/arrow_color.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/properties.dart/ink_well_size.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';

class DropDownCourseTile extends StatelessWidget {
  DropDownCourseTile({
    super.key,
    required this.isFocused,
    required this.courseNumber,
    required this.layerLink,
    this.courseController,
    this.quantityController,
    this.quantityFocus,
    this.onTap,
    this.textStyle,
    this.arrowColor,
    this.isEnabled = true,
    required this.widgetKey,
  });

  final bool isFocused;
  final bool isEnabled;
  final TextEditingController? courseController;
  final TextEditingController? quantityController;
  final FocusNode? quantityFocus;
  final int courseNumber;
  final void Function()? onTap;
  final TextStyle? textStyle;
  final ArrowColor? arrowColor;
  final LayerLink layerLink;
  final numTwoDecimalsRegex = RegExp(r'^\d+(\.\d{1,2})?$');
  final leadingZerosRegex = RegExp(r'^0+\d');
  final GlobalKey widgetKey;

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
              layerLink: layerLink,
              widgetKey: widgetKey,
              textStyle: textStyle,
              arrowUpColor: arrowColor!.dropUp,
              arrowDownColor: arrowColor!.dropDown,
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
              isFocused: isFocused,
              inkWellSize: const InkWellSize(height: 47),
              onTap: onTap,
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
