import 'package:flutter/material.dart';

class TileColumn extends StatelessWidget {
  const TileColumn(this.textOne, this.textTwo,
      {super.key,
      this.fontSize = 12,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.crossAxisAlignment = CrossAxisAlignment.center});

  final String textOne;
  final String textTwo;
  final double? fontSize;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          textOne,
          style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : null),
        ),
        Text(
          textTwo,
          style: TextStyle(
              fontSize: fontSize, color: isDark ? Colors.white : null),
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}
