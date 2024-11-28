import 'package:flutter/material.dart';

class TileRow extends StatelessWidget {
  const TileRow(this.textOne, this.textTwo, {super.key});

  final String textOne;
  final String textTwo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          textOne,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        Text(
          textTwo,
          style: const TextStyle(fontSize: 12),
        )
      ],
    );
  }
}
