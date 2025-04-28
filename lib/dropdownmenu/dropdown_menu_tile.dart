import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/properties.dart/arrow_position.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/properties.dart/ink_well_size.dart';

class DropdownMenuTile extends StatelessWidget {
  const DropdownMenuTile({
    super.key,
    this.controller,
    required this.labelText,
    this.labelTextSize,
    required this.isFocused,
    this.onTap,
    this.arrowPosition = const ArrowPosition(top: 12, right: 2),
    this.inkWellSize,
    this.validator,
    this.textPadding,
    this.textStyle,
    this.arrowDownColor,
    this.arrowUpColor,
    required this.layerLink,
    this.widgetKey,
  });

  final TextEditingController? controller;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final String? labelText;
  final bool isFocused;
  final ArrowPosition arrowPosition;
  final InkWellSize? inkWellSize;
  final double? labelTextSize;
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
            width: inkWellSize?.width,
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
          left: arrowPosition.left,
          top: arrowPosition.top,
          right: arrowPosition.right,
          bottom: arrowPosition.bottom,
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
          height: 47,
          width: inkWellSize?.width,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(4),
          ),
        )
      ],
    );
  }
}
