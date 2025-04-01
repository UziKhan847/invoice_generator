import 'package:flutter/material.dart';

class IconWithText extends StatelessWidget {
  const IconWithText(this.icon, this.text,
      {super.key, this.fontSize = 10, this.size = 14});

  final IconData icon;
  final String text;
  final double size;
  final double fontSize;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Icon(
            icon,
            size: size,
          ),
          Expanded(
            child: Text(text,
                style: TextStyle(fontSize: fontSize),
                overflow: TextOverflow.ellipsis,
                maxLines: 1),
          ),
        ],
      );
}
