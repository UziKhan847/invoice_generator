import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/adding_item/add_course.dart';
import 'package:markaz_umaza_invoice_generator/adding_item/add_invoice.dart';
import 'package:markaz_umaza_invoice_generator/adding_item/add_receipt.dart';
import 'package:markaz_umaza_invoice_generator/adding_item/add_recipient.dart';
import 'package:markaz_umaza_invoice_generator/adding_item/add_sender.dart';
import 'package:markaz_umaza_invoice_generator/extensions/string_extension.dart';
import 'package:markaz_umaza_invoice_generator/list_view_builders/course_list_builder.dart';
import 'package:markaz_umaza_invoice_generator/list_view_builders/receipt_list_builder.dart';
import 'package:markaz_umaza_invoice_generator/list_view_builders/recipient_list_builder.dart';
import 'package:markaz_umaza_invoice_generator/list_view_builders/sender_list_builder.dart';
import 'package:markaz_umaza_invoice_generator/main.dart';
import 'package:markaz_umaza_invoice_generator/pages/invoice_page.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';
import 'package:markaz_umaza_invoice_generator/providers/theme_switcher.dart';
import 'package:markaz_umaza_invoice_generator/themes/my_themes.dart';
import 'package:markaz_umaza_invoice_generator/widgets/nav_bar_item.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage>
    with TickerProviderStateMixin {
  late AppData provider;
  late AppTheme themeMode;
  late ThemeNotifier themeNotifier;

  late final pageController = PageController();
  late List<AnimationController> navItemAnimControllers;
  late List<Animation<double>> navItemAnims;

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
    MyThemes.primaryRed,
    MyThemes.primaryOrange,
    MyThemes.primaryBlue,
    MyThemes.primaryGreen,
    MyThemes.primaryPurple,
  ];

  final indicatorColors = [
    MyThemes.secondaryRed,
    MyThemes.secondaryOrange,
    MyThemes.secondaryBlue,
    MyThemes.secondaryGreen,
    MyThemes.secondaryPurple,
  ];

  Color? get navBarColor => Color.lerp(
        navBarColors[smallerIndex],
        navBarColors[largerIndex],
        lerp,
      );

  Color? get indicatorColor => Color.lerp(
        indicatorColors[smallerIndex],
        indicatorColors[largerIndex],
        lerp,
      );

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

    pageController.addListener(() {
      pageAnimValue = pageController.page ?? 0;

      largerIndex = pageAnimValue.ceil();
      smallerIndex = pageAnimValue.floor();

      lerp = (pageAnimValue - smallerIndex).abs();

      gradLerp[0] = lerp <= 0.5 ? lerp * 2 : 1;
      gradLerp[1] = lerp >= 0.5 ? (lerp - 0.5) * 2 : 0;

      for (int i = 0; i < 5; i++) {
        if (pageAnimValue == i) {
          navItemAnimControllers[i].forward();
        } else {
          if (navItemAnimControllers[i].isForwardOrCompleted) {
            navItemAnimControllers[i].reverse();
          }
        }
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    for (AnimationController e in navItemAnimControllers) {
      e.dispose();
    }
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

  @override
  Widget build(BuildContext context) {
    provider = ref.watch(appData);
    themeMode = ref.watch(themeProvider);
    themeNotifier = ref.read(themeProvider.notifier);

    double screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor:
            themeMode == AppTheme.colorful ? MyThemes.secondaryLight : null,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 50, //10,
          flexibleSpace: Container(
            decoration: switch (themeMode) {
              AppTheme.colorful => BoxDecoration(
                    gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )),
              _ => BoxDecoration(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                )
            },
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 20,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        switch (themeMode) {
                          case AppTheme.light:
                            themeNotifier.setTheme(AppTheme.dark);
                          case AppTheme.dark:
                            themeNotifier.setTheme(AppTheme.colorful);
                          default:
                            themeNotifier.setTheme(AppTheme.light);
                        }
                      },
                      child: Text(themeMode.name.toCapitalized)),
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          provider.resetData();
                          await supabase.auth.signOut();
                        } catch (e) {
                          if (mounted) {
                            rethrow;
                          }
                        }
                      },
                      child: const Text("Log Out")),
                
                ],
              ),
            ),
          ),
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          pageSnapping: false,
          children: [
            InvoicePage(
              invoices: provider.invoices,
              senders: provider.senders,
              recipients: provider.recipients,
              courses: provider.courses,
              isOnPage: pageAnimValue == 0,
              navBarColor: navBarColors[0],
              themeMode: themeMode,
              indicatorColor: indicatorColors[0],
            ),
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
                backgroundColor:
                    themeMode == AppTheme.colorful ? navBarColor : null,
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
            decoration: switch (themeMode) {
              AppTheme.colorful => BoxDecoration(
                    gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )),
              AppTheme.dark => const BoxDecoration(
                  color: MyThemes.primaryDark,
                ),
              _ => BoxDecoration(
                  color: Theme.of(context).appBarTheme.backgroundColor,
                )
            },
            child: Stack(
              children: [
                Positioned(
                    left: (screenWidth * 0.2) * pageAnimValue,
                    bottom: 0,
                    child: Container(
                      decoration: switch (themeMode) {
                        AppTheme.light =>
                          const BoxDecoration(color: Colors.white),
                        AppTheme.dark => BoxDecoration(
                            color:
                                Theme.of(context).appBarTheme.backgroundColor),
                        _ => BoxDecoration(
                            gradient:
                                LinearGradient(colors: indicatorGradColors))
                      },
                      width: screenWidth * 0.2,
                      height: 70,
                    )),
                Row(
                  children: [
                    for (int i = 0; i < 5; i++) ...[
                      NavBarItem(
                          iconColor: switch (themeMode) {
                            AppTheme.light => Color.lerp(MyThemes.tertiaryDark,
                                Colors.black, navItemAnims[i].value),
                            AppTheme.dark => Color.lerp(MyThemes.tertiaryLight,
                                Colors.white, navItemAnims[i].value),
                            _ => Color.lerp(Colors.white, Colors.black,
                                navItemAnims[i].value)
                          },

                          // themeMode == AppTheme.colorful
                          //     ? Color.lerp(Colors.white, Colors.black,
                          //         navItemAnims[i].value)
                          //     : null,
                          index: i,
                          itemColor: pageAnimValue == i
                              ? switch (themeMode) {
                                  AppTheme.light => Colors.white,
                                  AppTheme.dark => Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor,
                                  _ => indicatorColors[i]
                                }
                              : Colors.transparent,
                          onTap: () {
                            pageController.jumpToPage(
                              i,
                            );
                          },
                          controller: navItemAnimControllers[i],
                          itemBackWidth: lerpDouble(screenWidth * 0.2,
                              screenWidth * 0.3, navItemAnims[i].value),
                          itemWidth: getSelectedItemWidth(
                            screenWidth,
                            i,
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
