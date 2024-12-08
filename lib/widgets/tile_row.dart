import 'package:flutter/material.dart';

class TileRow extends StatelessWidget {
  const TileRow(this.textOne, this.textTwo, {super.key, this.fontSize = 12});

  final String textOne;
  final String textTwo;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Row(
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
