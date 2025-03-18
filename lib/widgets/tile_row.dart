import 'package:flutter/material.dart';

class TileRow extends StatelessWidget {
  const TileRow(this.textOne, this.textTwo,
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
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          textOne,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
        ),
        Text(
          textTwo,
          style: TextStyle(fontSize: fontSize),
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}
