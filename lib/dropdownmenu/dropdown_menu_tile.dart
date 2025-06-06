import 'package:flutter/material.dart';

class DropdownMenuTile extends StatelessWidget {
  const DropdownMenuTile(
      {super.key,
      this.controller,
      required this.labelText,
      this.labelTextSize = 10,
      required this.isSelected,
      this.onTapMenuBox,
      this.arrowBottomPosition,
      this.arrowLeftPosition,
      this.arrowRightPosition = 2,
      this.arrowTopPosition = 12,
      required this.menuInkHeight,
      this.menuInkWidth,
      this.menuBoxWidth,
      this.validator,
      this.textPadding,
      this.textStyle,
      this.arrowDownColor,
      this.arrowUpColor});

  final TextEditingController? controller;
  final void Function()? onTapMenuBox;
  final String? Function(String?)? validator;
  final String? labelText;
  final bool isSelected;
  final double? arrowBottomPosition;
  final double? arrowLeftPosition;
  final double? arrowRightPosition;
  final double? arrowTopPosition;
  final double? menuInkHeight;
  final double? menuInkWidth;
  final double? menuBoxWidth;
  final double labelTextSize;
  final EdgeInsetsGeometry? textPadding;
  final TextStyle? textStyle;
  final Color? arrowUpColor;
  final Color? arrowDownColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 65,
          width: menuBoxWidth,
          child: TextFormField(
            style: textStyle,
            readOnly: true,
            controller: controller,
            validator: validator,
            decoration: InputDecoration(
              contentPadding: textPadding,
              labelText: labelText,
              labelStyle: TextStyle(fontSize: labelTextSize),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: isSelected
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
          left: arrowLeftPosition,
          top: arrowTopPosition,
          right: arrowRightPosition,
          bottom: arrowBottomPosition,
          child: isSelected
              ? Icon(
                  Icons.arrow_drop_up,
                  color: arrowUpColor,
                )
              : Icon(
                  Icons.arrow_drop_down,
                  color: arrowDownColor,
                ),
        ),
        Container(
          height: menuInkHeight,
          width: menuInkWidth,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
          child: InkWell(
            onTap: onTapMenuBox,
            borderRadius: BorderRadius.circular(4),
          ),
        )
      ],
    );
  }
}
