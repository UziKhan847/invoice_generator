import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';
import 'package:markaz_umaza_invoice_generator/widgets/custom_list_tile.dart';

class SlidableItem extends StatelessWidget {
  const SlidableItem(
      {super.key,
      this.backgroundColor,
      this.foregroundColor = Colors.white,
      this.fontSize = 9,
      this.icon = Icons.picture_as_pdf_outlined,
      this.onTap,
      this.splashColor,
      this.text = '',
      this.itemPosition = SlidableItemPosition.middle});

  final Color? splashColor;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconData icon;
  final String text;
  final double fontSize;
  final VoidCallback? onTap;
  final SlidableItemPosition itemPosition;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        borderRadius: switch (itemPosition) {
          SlidableItemPosition.first => const BorderRadius.only(
              topLeft: Radius.circular(4), bottomLeft: Radius.circular(4)),
          SlidableItemPosition.last => const BorderRadius.only(
              topRight: Radius.circular(4), bottomRight: Radius.circular(4)),
          _ => null,
        },
        color: backgroundColor,
        child: InkWell(
          splashColor: splashColor,
          borderRadius: switch (itemPosition) {
            SlidableItemPosition.first => const BorderRadius.only(
                topLeft: Radius.circular(4), bottomLeft: Radius.circular(4)),
            SlidableItemPosition.last => const BorderRadius.only(
                topRight: Radius.circular(4), bottomRight: Radius.circular(4)),
            _ => null,
          },
          onTap: onTap,
          child: Container(
            color: Colors.transparent,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: foregroundColor,
                  ),
                  Margins.vertical4,
                  Text(
                    text,
                    style:
                        TextStyle(fontSize: fontSize, color: foregroundColor),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
