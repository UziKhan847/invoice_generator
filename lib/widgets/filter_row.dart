import 'package:flutter/material.dart';

class FilterRow extends StatelessWidget {
  const FilterRow({
    super.key,
    //this.onTap,
    required this.update,
    required this.rowLabel,
    required this.items,
    required this.selectedItems,
  });

  final List<String> items;
  //final VoidCallback? onTap;
  final VoidCallback update;
  final String rowLabel;
  final Set<String> selectedItems;

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
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];

                  return GestureDetector(
                    onTap: () {
                      selectedItems.contains(item)
                          ? selectedItems.remove(item)
                          : selectedItems.add(item);

                      update();
                    },
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: selectedItems.contains(item)
                                ? const Color(0xFFAC1616)
                                : const Color(0xFFEBA6A6),
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
                              color: selectedItems.contains(item)
                                  ? Colors.white
                                  : Colors.black),
                        ))),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
