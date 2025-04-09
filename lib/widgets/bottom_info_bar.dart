import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';

class BottomInfoBar extends StatelessWidget {
  const BottomInfoBar({
    super.key,
    required this.filteredInvoices,
    required this.isOnPage,
    required this.item,
    this.grossIncome = 0,
    this.hst = 0,
    this.netIncome = 0,
    required this.isExpanded,
    this.onTapArrow,
    this.expandButtonColor,
    this.arrowColor,
  });

  final bool isOnPage;
  final List<Invoice> filteredInvoices;
  final String item;
  final double grossIncome;
  final double hst;
  final double netIncome;
  final bool isExpanded;
  final VoidCallback? onTapArrow;
  final Color? expandButtonColor;
  final Color? arrowColor;

  @override
  Widget build(BuildContext context) {
    //Orientation orientation = MediaQuery.of(context).orientation;

    return AnimatedPositioned(
        duration: const Duration(milliseconds: 200),
        height: 100,
        width: MediaQuery.of(context).size.width * 0.75,
        bottom: 8,
        left: switch (isOnPage) {
          true =>
            isExpanded ? -10 : -MediaQuery.of(context).size.width * 0.75 + 30,
          false => -MediaQuery.of(context).size.width * 0.75,
        },
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 27),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    )
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "# of ${item}s: ",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      Text(
                        "${filteredInvoices.length}",
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Gross Income: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      Text(
                        "\$$grossIncome",
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "HST: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      Text(
                        "\$$hst",
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        "Net Income: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      Text(
                        "\$$netIncome",
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
                height: 100,
                width: 30,
                right: 0,
                child: GestureDetector(
                  onTap: onTapArrow,
                  child: Container(
                    decoration: BoxDecoration(
                      color: expandButtonColor,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                    ),
                    child: Center(
                      child: Icon(
                        isExpanded ? Icons.arrow_left : Icons.arrow_right,
                        color: arrowColor,
                      ),
                    ),
                  ),
                ))
          ],
        ));
  }
}
