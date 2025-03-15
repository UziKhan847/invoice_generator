import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/filter/filter_row.dart';

class FilterBox extends StatelessWidget {
  const FilterBox({
    super.key,
    required this.isExpanded,
    required this.filterOptions,
    required this.selectedFilters,
    required this.update,
  });

  final bool isExpanded;
  final VoidCallback update;
  final List<Set<String>> selectedFilters;
  final List<List<String>> filterOptions;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: isExpanded ? 300 : 0,
      decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.16),
              blurRadius: 6,
              offset: const Offset(0, 2),
            )
          ]),
      child: ListView(
        children: [
          for (int i = 0; i < 6; i++) ...[
            FilterRow(
              rowLabel: switch (i) {
                1 => 'Recipients',
                2 => 'Courses',
                3 => 'Years',
                4 => 'Months',
                5 => 'Days',
                _ => 'Senders'
              },
              filterOptions: filterOptions[i],
              selectedFilters:selectedFilters[i],
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
