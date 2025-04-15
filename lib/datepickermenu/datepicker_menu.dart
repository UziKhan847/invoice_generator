import 'package:flutter/material.dart';

class DatepickerMenu extends StatelessWidget {
  const DatepickerMenu({
    super.key,
    required this.labelText,
    required this.isFocused,
    required this.onTapMenuBox,
    required this.onTapDelete,
    required this.menuInkHeight,
    required this.menuInkWidth,
    required this.menuBoxWidth,
    required this.controller,
    this.iconBottomPosition,
    this.iconLeftPosition,
    this.iconRightPosition,
    this.iconTopPosition,
    this.deleteBottomPosition,
    this.deleteLeftPosition,
    this.deleteRightPosition,
    this.deleteTopPosition,
  });

  final TextEditingController controller;
  final String? labelText;
  final bool isFocused;
  final void Function()? onTapMenuBox;
  final void Function()? onTapDelete;
  final double? iconBottomPosition;
  final double? iconLeftPosition;
  final double? iconRightPosition;
  final double? iconTopPosition;
  final double? deleteBottomPosition;
  final double? deleteLeftPosition;
  final double? deleteRightPosition;
  final double? deleteTopPosition;
  final double? menuInkHeight;
  final double? menuInkWidth;
  final double? menuBoxWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            SizedBox(
              width: menuBoxWidth,
              child: TextFormField(
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
                left: iconLeftPosition,
                top: iconTopPosition,
                right: iconRightPosition,
                bottom: iconBottomPosition,
                child: const Icon(Icons.date_range_rounded)),
            Container(
              height: menuInkHeight,
              width: menuInkWidth,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
              child: InkWell(
                onTap: onTapMenuBox,
                borderRadius: BorderRadius.circular(4),
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
