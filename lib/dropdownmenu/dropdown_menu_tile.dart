import 'package:flutter/material.dart';

class DropdownMenuTile extends StatelessWidget {
  const DropdownMenuTile({
    super.key,
    this.controller,
    required this.labelText,
    this.labelTextSize = 10,
    required this.isFocused,
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
    this.arrowUpColor,
    required this.layerLink,
    this.widgetKey,
  });

  final TextEditingController? controller;
  final void Function()? onTapMenuBox;
  final String? Function(String?)? validator;
  final String? labelText;
  final bool isFocused;
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
  final LayerLink layerLink;
  final GlobalKey? widgetKey;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CompositedTransformTarget(
          link: layerLink,
          child: SizedBox(
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
        ),
        Positioned(
          left: arrowLeftPosition,
          top: arrowTopPosition,
          right: arrowRightPosition,
          bottom: arrowBottomPosition,
          child: isFocused
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
          key: widgetKey,
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
