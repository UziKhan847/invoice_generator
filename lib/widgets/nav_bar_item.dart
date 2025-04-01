import 'package:flutter/material.dart';

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    super.key,
    required this.iconColor,
    required this.index,
    required this.itemColor,
    required this.onTap,
    required this.controller,
    required this.itemBackWidth,
    required this.itemWidth,
  });

  final VoidCallback onTap;
  final double? itemBackWidth;
  final double itemWidth;
  final Color? itemColor;
  final Color? iconColor;
  final Animation<double> controller;
  final int index;

  Widget get icon => switch (index) {
        1 => SizedBox(
            child: ImageIcon(
              const AssetImage('assets/icons/sender_icon.png'),
              size: 25,
              color: iconColor,
            ),
          ),
        2 => SizedBox(
            child: ImageIcon(
              const AssetImage('assets/icons/recipient_icon.png'),
              size: 25,
              color: iconColor,
            ),
          ),
        3 => Icon(Icons.my_library_books, size: 25, color: iconColor),
        4 => Icon(Icons.receipt_long_rounded, size: 25, color: iconColor),
        _ => Icon(Icons.receipt, size: 25, color: iconColor),
      };

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          onTap: onTap,
          splashColor: itemColor,
          child: Stack(
            children: [
              Positioned(
                  bottom: 0,
                  height: 70,
                  child: Container(
                    color: itemColor,
                    width: itemBackWidth,
                  )),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: itemWidth,
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        icon,
                        SizeTransition(
                          sizeFactor: controller,
                          axis: Axis.horizontal,
                          axisAlignment: -1,
                          child: Center(
                            child: Text(
                              switch (index) {
                                1 => '  Senders',
                                2 => '  Recipients',
                                3 => '  Courses',
                                4 => '  Receipts',
                                _ => '  Invoices',
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
