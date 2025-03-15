import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key, required this.isExpanded, required this.onTap, required this.indicatorColor});

  final bool isExpanded;
  final VoidCallback onTap;
  final Color indicatorColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 50,
        padding:
            const EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            color: isExpanded ? Colors.white : indicatorColor,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.16),
                blurRadius: 6,
                offset: const Offset(0, 2),
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Filter',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down)
          ],
        ),
      ),
    );
  }
}
