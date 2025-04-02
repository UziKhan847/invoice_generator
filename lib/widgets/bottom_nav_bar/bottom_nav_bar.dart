import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:markaz_umaza_invoice_generator/widgets/nav_bar_item.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar(
      {super.key,
      required this.indicatorColor,
      required this.indicatorGradColors,
      required this.gradientColors,
      required this.onHorizontalDragEnd,
      required this.onHorizontalDragUpdate,
      required this.page,
      required this.screenWidth,
      required this.pageController});

  final void Function(DragUpdateDetails)? onHorizontalDragUpdate;
  final void Function(DragEndDetails)? onHorizontalDragEnd;

  final double page;

  final double screenWidth;
  final PageController pageController;
  final Color? indicatorColor;
  final List<Color> gradientColors;
  final List<Color> indicatorGradColors;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with TickerProviderStateMixin {
  late List<AnimationController> navItemAnimControllers;
  late List<Animation<double>> navItemAnims;

  @override
  void initState() {
    super.initState();

    navItemAnimControllers = List<AnimationController>.generate(
      5,
      (_) => AnimationController(
          vsync: this, duration: const Duration(milliseconds: 200)),
      growable: false,
    );

    navItemAnims = List<Animation<double>>.generate(
        5,
        (int index) => Tween<double>(begin: 0, end: 1)
            .animate(navItemAnimControllers[index]
              ..addListener(() {
                setState(() {});
              })));

    navItemAnimControllers[0].forward();

     for (int i = 0; i < 5; i++) {
        if (widget.page == i) {
          navItemAnimControllers[i].forward();
        } else {
          if (navItemAnimControllers[i].isForwardOrCompleted) {
            navItemAnimControllers[i].reverse();
          }
        }
      }

    setState(() {});
  }

  @override
  void dispose() {
    for (AnimationController e in navItemAnimControllers) {
      e.dispose();
    }
    super.dispose();
  }

  double getSelectedItemWidth(double screenWidth, int index) {
    final scrWThird = screenWidth * 0.3;
    final scrWFifth = screenWidth * 0.2;

    if (widget.page % 1 == 0) {
      if (index == widget.page) {
        return scrWThird;
      } else {
        return (screenWidth - scrWThird) / 4;
      }
    }

    return scrWFifth;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: widget.onHorizontalDragUpdate,
      onHorizontalDragEnd: widget.onHorizontalDragEnd,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: widget.gradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        )),
        child: Stack(
          children: [
            Positioned(
                left: (widget.screenWidth * 0.2) * widget.page,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(colors: widget.indicatorGradColors)),
                  width: widget.screenWidth * 0.2,
                  height: 70,
                )),
            Row(
              children: [
                for (int i = 0; i < 5; i++) ...[
                  NavBarItem(
                      iconColor: Color.lerp(
                          Colors.white, Colors.black, navItemAnims[i].value),
                      index: i,
                      itemColor: widget.page == i
                          ? widget.indicatorColor
                          : Colors.transparent,
                      onTap: () {
                        widget.pageController.animateToPage(
                          i,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linear,
                        );
                      },
                      controller: navItemAnimControllers[i],
                      itemBackWidth: lerpDouble(widget.screenWidth * 0.2,
                          widget.screenWidth * 0.3, navItemAnims[i].value),
                      itemWidth: getSelectedItemWidth(widget.screenWidth, i))
                ],
              ],
            )
          ],
        ),
      ),
    );
  }
}
