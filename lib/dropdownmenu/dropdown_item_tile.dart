import 'package:flutter/material.dart';

class DropDownItemTile extends StatelessWidget {
  const DropDownItemTile({
    super.key,
    required this.currentIndex,
    this.height,
    required this.onTap,
    required this.itemFormat,
    this.padding = const EdgeInsets.symmetric(vertical: 14),
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  final double? height;
  final int currentIndex;
  final void Function()? onTap;
  final MainAxisAlignment mainAxisAlignment;
  final List<Widget> itemFormat;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: onTap,
            child: Padding(
              padding: padding,
              child: Row(
                  mainAxisAlignment: mainAxisAlignment, children: itemFormat),
            ),
          ),
        ));
  }
}
