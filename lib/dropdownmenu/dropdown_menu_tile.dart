import 'package:flutter/material.dart';

class DropdownMenuTile extends StatelessWidget {
  const DropdownMenuTile(
      {super.key,
      required this.labelText,
      required this.selectedItem,
      required this.isSelected,
      required this.onTapMenuBox,
      this.arrowBottomPosition,
      this.arrowLeftPosition,
      this.arrowRightPosition,
      this.arrowTopPosition,
      required this.menuInkHeight,
      required this.menuInkWidth,
      required this.menuBoxWidth});

  final String? labelText;
  final String selectedItem;
  final bool isSelected;
  final void Function()? onTapMenuBox;
  final double? arrowBottomPosition;
  final double? arrowLeftPosition;
  final double? arrowRightPosition;
  final double? arrowTopPosition;
  final double? menuInkHeight;
  final double? menuInkWidth;
  final double? menuBoxWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: menuBoxWidth,
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: const TextStyle(fontSize: 10),
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
            child: Text(
              selectedItem,
              style: const TextStyle(
                  fontSize: 16, color: Color(0xFF424242), height: 1.47),
            ),
          ),
        ),
        Positioned(
          left: arrowLeftPosition,
          top: arrowTopPosition,
          right: arrowRightPosition,
          bottom: arrowBottomPosition,
          child: isSelected
              ? const Icon(Icons.arrow_drop_up)
              : const Icon(Icons.arrow_drop_down),
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
