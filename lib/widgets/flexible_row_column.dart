import 'package:flutter/material.dart';

class FlexibleRowColumn extends StatelessWidget {
  const FlexibleRowColumn(
      {super.key,
      this.spacing = 0.0,
      this.mainAxisSize = MainAxisSize.max,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.children = const <Widget>[]});

  final double spacing;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return orientation == Orientation.portrait
        ? Row(
            spacing: spacing,
            mainAxisSize: mainAxisSize,
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            children: children,
          )
        : Column(
            spacing: spacing,
            mainAxisSize: mainAxisSize,
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            children: children,
          );
  }
}
