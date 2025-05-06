import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';

class SlidableItem extends StatelessWidget {
  const SlidableItem({
    super.key,
    this.backgroundColor,
    this.foregroundColor = Colors.white,
    this.fontSize = 9,
    this.icon = Icons.picture_as_pdf_outlined,
    this.onTap,
    this.splashColor,
    this.text = '',
  });

  final Color? splashColor;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final IconData icon;
  final String text;
  final double fontSize;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: backgroundColor,
        child: InkWell(
          splashColor: splashColor,
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
