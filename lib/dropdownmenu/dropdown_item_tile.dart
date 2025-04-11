import 'package:flutter/material.dart';

class DropdownItemTile extends StatelessWidget {
  const DropdownItemTile({
    super.key,
    required this.currentMenuIndex,
    required this.itemText,
    required this.lastItemIndex,
    required this.menuItemHeight,
    required this.onItemTap,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });

  final double? menuItemHeight;
  final int currentMenuIndex;
  final int lastItemIndex;
  final String itemText;
  final void Function()? onItemTap;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: onItemTap,
        child: Row(mainAxisAlignment: mainAxisAlignment, children: [
          Text(
            itemText,
          )
        ]),
      ),
    ));
  }
}
