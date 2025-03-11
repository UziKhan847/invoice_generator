import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/adding_item/add_course.dart';
import 'package:markaz_umaza_invoice_generator/adding_item/add_invoice.dart';
import 'package:markaz_umaza_invoice_generator/adding_item/add_receipt.dart';
import 'package:markaz_umaza_invoice_generator/adding_item/add_recipient.dart';
import 'package:markaz_umaza_invoice_generator/adding_item/add_sender.dart';
import 'package:markaz_umaza_invoice_generator/list_view_builders/course_list_builder.dart';
import 'package:markaz_umaza_invoice_generator/list_view_builders/invoice_list_builder.dart';
import 'package:markaz_umaza_invoice_generator/list_view_builders/receipt_list_builder.dart';
import 'package:markaz_umaza_invoice_generator/list_view_builders/recipient_list_builder.dart';
import 'package:markaz_umaza_invoice_generator/list_view_builders/sender_list_builder.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';

class TabsPage extends ConsumerStatefulWidget {
  const TabsPage({super.key});

  @override
  ConsumerState<TabsPage> createState() => _TabPageState();
}

class _TabPageState extends ConsumerState<TabsPage>
    with TickerProviderStateMixin {
  late AppData provider;

  // late TabController tabController = TabController(length: 5, vsync: this);

  late PageController pageController = PageController();
  late List<AnimationController> navItemAnimController;
  late List<Animation<double>> navItemAnim;

  double pageAnimValue = 0;
  bool swipeRight = true;

  int smallerIndex = 0;
  int largerIndex = 0;
  int nextIndex = 0;
  int prevIndex = 0;
  int onTapIndex = 0;
  int onTapPrevIndex = 0;
  bool isTap = false;
  double lerp = 0.0;
  List<double> gradLerp = [0, 0];
  double dragStartX = 0.0;
  double dragDelta = 0.0;

  final navBarColors = [
    const Color(0xFF6B2C2C), // Muted Dark Red
    const Color(0xFF8C5A2E), // Muted Olive Brown
    const Color(0xFF4A6D8C), // Muted Slate Blue
    const Color(0xFF3A5A47), // Muted Dark Green
    const Color(0xFF5B3A73), // Muted Dark Violet
  ];

  final indicatorColors = [
    const Color(0xFFE48787), // Lightened Muted Dark Red
    const Color(0xFFDCAB6F), // Lightened Muted Olive Brown
    const Color(0xFF93B3D1), // Lightened Muted Slate Blue
    const Color(0xFFB6D7B1), // Lightened Muted Dark Green
    const Color(0xFFBE95CE), // Lightened Muted Dark Violet
  ];

  Color? get navBarColor {
    return Color.lerp(
      navBarColors[smallerIndex],
      navBarColors[largerIndex],
      lerp,
    );
  }

  Color? get indicatorColor {
    return Color.lerp(
      indicatorColors[smallerIndex],
      indicatorColors[largerIndex],
      lerp,
    );
  }

  List<Color> get gradientColors => [
        Color.lerp(navBarColors[smallerIndex], navBarColors[largerIndex],
            gradLerp[1])!,
        Color.lerp(navBarColors[smallerIndex], navBarColors[largerIndex],
            gradLerp[0])!,
      ];

  List<Color> get indicatorGradColors => [
        Color.lerp(indicatorColors[smallerIndex], indicatorColors[largerIndex],
            gradLerp[1])!,
        Color.lerp(indicatorColors[smallerIndex], indicatorColors[largerIndex],
            gradLerp[0])!,
      ];

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    pageController.jumpTo(pageController.position.pixels - details.delta.dx);
  }

  @override
  void initState() {
    super.initState();

    navItemAnimController = List<AnimationController>.generate(
      5,
      (_) => AnimationController(
          vsync: this, duration: const Duration(milliseconds: 200)),
      growable: false,
    );

    navItemAnim = List<Animation<double>>.generate(
        5,
        (int index) =>
            Tween<double>(begin: 0, end: 1).animate(navItemAnimController[index]
              ..addListener(() {
                setState(() {});
              })));

    navItemAnimController[0].forward();

    pageController.addListener(() {
      isTap = onTapIndex - smallerIndex > 1;

      pageAnimValue = pageController.page ?? 0;

      swipeRight = pageController.position.userScrollDirection ==
          ScrollDirection.reverse;

      largerIndex = pageAnimValue.ceil();
      smallerIndex = pageAnimValue.floor();

      nextIndex = swipeRight ? largerIndex : smallerIndex;
      prevIndex = swipeRight ? smallerIndex : largerIndex;

      lerp = (pageAnimValue - smallerIndex).abs();

      gradLerp[0] = lerp <= 0.5 ? lerp * 2 : 1;
      gradLerp[1] = lerp >= 0.5 ? (lerp - 0.5) * 2 : 0;

      // print("THE ORIGINAL LERP: $lerp");
      // print("FIRST LERP: ${gradLerp[0]}");
      // print("SECOND LERP: ${gradLerp[1]}");

      for (int i = 0; i < 5; i++) {
        if (pageAnimValue == i) {
          navItemAnimController[i].forward();
        } else {
          if (navItemAnimController[i].isForwardOrCompleted) {
            navItemAnimController[i].reverse();
          }
        }
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    //tabController.dispose();
    pageController.dispose();
    super.dispose();
  }

  double getSelectedItemWidth(double screenWidth, int index) {
    final scrWThird = screenWidth * 0.3;
    final scrWFifth = screenWidth * 0.2;

    if (pageAnimValue % 1 == 0) {
      if (index == pageAnimValue) {
        return scrWThird;
      } else {
        return (screenWidth - scrWThird) / 4;
      }
    }

    return scrWFifth;
  }

  //double getLeft() {}

  @override
  Widget build(BuildContext context) {
    provider = ref.watch(appData);
    double screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 10,
          flexibleSpace: Container(
            height: 10,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )),
          ),
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          pageSnapping: false,
          children: [
            InvoiceListBuilder(invoices: provider.invoices.reversed.toList()),
            SenderListBuilder(senders: provider.senders),
            RecipientListBuilder(recipients: provider.recipients),
            CourseListBuilder(courses: provider.courses),
            ReceiptListBuilder(receipts: provider.receipts.reversed.toList())
          ],
        ),
        floatingActionButton: pageAnimValue % 1 != 0
            ? null
            : FloatingActionButton(
                onPressed: () => showDialog<String>(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) => switch (pageAnimValue) {
                          1 => const AddSender(),
                          2 => const AddRecipient(),
                          3 => const AddCourse(),
                          4 => const AddReceipt(),
                          _ => const AddInvoice(),
                        }),
                backgroundColor: navBarColor,
                child: const Icon(Icons.add),
              ),
        bottomNavigationBar: GestureDetector(
          onHorizontalDragUpdate: (details) {
            pageController.jumpTo(
                (pageController.position.pixels - details.delta.dx)
                    .clamp(0, pageController.position.maxScrollExtent));
          },
          onHorizontalDragEnd: (details) {
            double velocity = details.primaryVelocity ?? 0;

            int targetPage = pageAnimValue.round();

            if (velocity.abs() > 500) {
              if (velocity < 0) {
                lerp < 0.5 ? targetPage += 1 : targetPage;
              } else {
                lerp > 0.5 ? targetPage -= 1 : targetPage;
              }
            }

            targetPage = targetPage.clamp(0, 4);

            pageController.animateToPage(
              targetPage,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          },
          child: Container(
            height: 70,
            // color: navBarColor,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )),
            child: Stack(
              children: [
                Positioned(
                    left: (screenWidth * 0.2) * pageAnimValue,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient:
                              LinearGradient(colors: indicatorGradColors)),
                      width: screenWidth * 0.2,
                      height: 70,
                    )),
                Row(
                  children: [
                    for (int i = 0; i < 5; i++) ...[
                      GestureDetector(
                          onTap: () {
                            // onTapIndex = i;

                            pageController.animateToPage(
                              i,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.linear,
                            );
                          },
                          child: Stack(
                            children: [
                              Positioned(
                                  bottom: 0,
                                  height: 70,
                                  width: lerpDouble(screenWidth * 0.2,
                                      screenWidth * 0.3, navItemAnim[i].value),
                                  child: Container(
                                    color: pageAnimValue == i
                                        ? indicatorColors[i]
                                        : Colors.transparent,
                                  )),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    width: getSelectedItemWidth(
                                      screenWidth,
                                      i,
                                    ),
                                    height: 70,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          switch (i) {
                                            1 => Icons.person,
                                            2 => Icons.person,
                                            3 => Icons.my_library_books,
                                            4 => Icons.receipt_long_rounded,
                                            _ => Icons.receipt,
                                          },
                                          size: 25,
                                          color: Color.lerp(
                                              Colors.white,
                                              Colors.black,
                                              navItemAnim[i].value),
                                        ),
                                        SizeTransition(
                                          sizeFactor: navItemAnimController[i],
                                          axis: Axis.horizontal,
                                          axisAlignment: -1,
                                          child: Center(
                                            child: Text(
                                              switch (i) {
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
                          ))
                    ],
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
