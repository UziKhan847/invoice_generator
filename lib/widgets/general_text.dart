import 'package:flutter/material.dart';

class GeneralText extends StatelessWidget {
  const GeneralText(
      {super.key,
      this.text = '',
      this.fontFamily = "Arial",
      this.fontSize = 9.0,
      this.fontWeight,
      this.color,
      this.textAlign});

  final String text;
  final String? fontFamily;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          color: color,
          fontFamily: fontFamily,
          fontSize: fontSize,
          fontWeight: fontWeight),
    );
  }
}
