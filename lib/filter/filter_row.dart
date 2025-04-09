import 'package:flutter/material.dart';

class FilterRow extends StatelessWidget {
  const FilterRow({
    super.key,
    required this.update,
    required this.rowLabel,
    required this.filterOptions,
    required this.selectedFilters,
    required this.activeBtnColor,
    required this.inactiveBtnColor,
    required this.activeTextColor,
    required this.inactiveTextColor,
  });

  final List<String> filterOptions;
  final VoidCallback update;
  final String rowLabel;
  final Set<String> selectedFilters;
  final Color activeBtnColor;
  final Color inactiveBtnColor;
  final Color activeTextColor;
  final Color inactiveTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 14),
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 50,
      child: Row(
        children: [
          SizedBox(width: 80, child: Text("$rowLabel:")),
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filterOptions.length,
                itemBuilder: (context, index) {
                  final item = filterOptions[index];

                  return GestureDetector(
                    onTap: () {
                      selectedFilters.contains(item)
                          ? selectedFilters.remove(item)
                          : selectedFilters.add(item);

                      update();
                    },
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: selectedFilters.contains(item)
                                ? activeBtnColor
                                : inactiveBtnColor,
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.16),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              )
                            ],
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                            child: Text(
                          item,
                          style: TextStyle(
                              color: selectedFilters.contains(item)
                                  ? activeTextColor
                                  : inactiveTextColor),
                        ))),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
