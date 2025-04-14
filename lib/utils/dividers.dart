import 'package:flutter/material.dart';

class Dividers {
  static VerticalDivider verticalDivider(bool isDark) => VerticalDivider(
        thickness: 0,
        color: isDark ? Colors.white : Colors.black,
      );
}
