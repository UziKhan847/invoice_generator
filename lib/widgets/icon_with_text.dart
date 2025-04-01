import 'package:flutter/material.dart';

class IconWithText extends StatelessWidget {
  const IconWithText(this.icon, this.text, {super.key});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Icon(
            icon,
            size: 14,
          ),
          Expanded(
            child: Text(text,
                style: const TextStyle(fontSize: 10),
                overflow: TextOverflow.ellipsis,
                maxLines: 1),
          ),
        ],
      );
}
