import 'package:flutter/material.dart';

enum PageNavButtonType { back, next, finish }

class PageNavButton extends StatelessWidget {
  const PageNavButton(
      {super.key, required this.btnType, required this.onPressed});

  final VoidCallback onPressed;
  final PageNavButtonType btnType;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
        minimumSize: WidgetStatePropertyAll(Size(115, 40)),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (btnType == PageNavButtonType.back) ...[
            const Text('‹', style: TextStyle(fontSize: 22)),
            const Text(
              '  Back',
              style: TextStyle(fontSize: 18),
            ),
          ],
          if (btnType == PageNavButtonType.next) ...[
            const Text(
              'Next  ',
              style: TextStyle(fontSize: 18),
            ),
            const Text('›', style: TextStyle(fontSize: 22)),
          ],
          if (btnType == PageNavButtonType.finish) ...[
            const Text(
              'Finish',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ],
      ),
    );
  }
}
