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
                        Icon(
                          switch (index) {
                            1 => Icons.person,
                            2 => Icons.person,
                            3 => Icons.my_library_books,
                            4 => Icons.receipt_long_rounded,
                            _ => Icons.receipt,
                          },
                          size: 25,
                          color: iconColor,
                        ),
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
