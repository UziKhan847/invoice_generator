import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/filter/filter_row.dart';

class FilterBox extends StatelessWidget {
  const FilterBox({
    super.key,
    required this.isExpanded,
    required this.filterOptions,
    required this.selectedFilters,
    required this.update,
    required this.boxColor,
    required this.activeBtnColor,
    required this.inactiveBtnColor,
    required this.activeTextColor,
    required this.inactiveTextColor,
  });

  final bool isExpanded;
  final VoidCallback update;
  final List<Set<String>> selectedFilters;
  final List<List<String>> filterOptions;
  final Color boxColor;
  final Color activeBtnColor;
  final Color inactiveBtnColor;
  final Color activeTextColor;
  final Color inactiveTextColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: isExpanded ? 300 : 0,
      decoration: BoxDecoration(
          color: boxColor,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 6,
              offset: const Offset(0, 2),
            )
          ]),
      child: ListView(
        children: [
          for (int i = 0; i < 6; i++) ...[
            FilterRow(
              activeBtnColor: activeBtnColor,
              inactiveBtnColor: inactiveBtnColor,
              activeTextColor: activeTextColor,
              inactiveTextColor: inactiveTextColor,
              rowLabel: switch (i) {
                1 => 'Recipients',
                2 => 'Courses',
                3 => 'Years',
                4 => 'Months',
                5 => 'Days',
                _ => 'Senders'
              },
              filterOptions: filterOptions[i],
              selectedFilters: selectedFilters[i],
              update: update,
            ),
            if (i < 5)
              const Divider(
                height: 0,
              ),
          ],
        ],
      ),
    );
  }
}
