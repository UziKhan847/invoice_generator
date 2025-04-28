import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/datepickermenu/properties/icon_position.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/properties.dart/ink_well_size.dart';

class DatepickerMenu extends StatelessWidget {
  const DatepickerMenu({
    super.key,
    required this.labelText,
    required this.isFocused,
    required this.onTap,
    required this.onTapDelete,
    this.inkWellSize = const InkWellSize(height: 47, width: 155),
    this.width = 155,
    required this.controller,
    this.iconPosition = const IconPosition(top: 10, right: 8),
  });

  final TextEditingController controller;
  final String? labelText;
  final bool isFocused;
  final void Function()? onTap;
  final void Function()? onTapDelete;
  final IconPosition iconPosition;
  final InkWellSize inkWellSize;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            SizedBox(
              width: width,
              child: TextFormField(
                readOnly: true,
                controller: controller,
                decoration: InputDecoration(
                  labelText: labelText,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: isFocused
                          ? Theme.of(context)
                              .inputDecorationTheme
                              .focusedBorder!
                              .borderSide
                          : Theme.of(context)
                              .inputDecorationTheme
                              .border!
                              .borderSide),
                ),
              ),
            ),
            Positioned(
                left: iconPosition.left,
                top: iconPosition.top,
                right: iconPosition.right,
                bottom: iconPosition.bottom,
                child: const Icon(Icons.date_range_rounded)),
            InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(4),
              child: SizedBox(
                height: inkWellSize.height,
                width: inkWellSize.width,
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: onTapDelete,
          splashColor: Colors.red,
          icon: const Icon(
            Icons.delete_rounded,
            color: Color(0xFFB71C1C),
          ),
        ),
      ],
    );
  }
}
