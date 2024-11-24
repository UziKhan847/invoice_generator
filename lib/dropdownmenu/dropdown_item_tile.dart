import 'package:flutter/material.dart';

class DropdownItemTile extends StatelessWidget {
  const DropdownItemTile({
    super.key,
    required this.currentMenuIndex,
    required this.itemText,
    required this.lastItemIndex,
    required this.menuItemHeight,
    required this.onItemTap,
  });

  final double? menuItemHeight;
  final int currentMenuIndex;
  final int lastItemIndex;
  final String itemText;
  final void Function()? onItemTap;

  BorderRadius itemBorderRadius() {
    if (currentMenuIndex == 0) {
      return const BorderRadius.only(
          topLeft: Radius.circular(4), topRight: Radius.circular(4));
    } else if (currentMenuIndex == lastItemIndex) {
      return const BorderRadius.only(
          bottomLeft: Radius.circular(4), bottomRight: Radius.circular(4));
    }
    return BorderRadius.circular(0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: menuItemHeight,
        decoration: BoxDecoration(
            color: const Color(0xFFF2F2F2), borderRadius: itemBorderRadius()),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: itemBorderRadius(),
            onTap: onItemTap,
            child: Center(child: Text(itemText)),
          ),
        ));
  }
}
