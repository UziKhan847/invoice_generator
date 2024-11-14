import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/list%20view%20builders/course_list_builder.dart';
import 'package:markaz_umaza_invoice_generator/list%20view%20builders/invoice_list_builder.dart';
import 'package:markaz_umaza_invoice_generator/list%20view%20builders/recipient_list_builder.dart';
import 'package:markaz_umaza_invoice_generator/list%20view%20builders/sender_list_builder.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';
import 'package:markaz_umaza_invoice_generator/widgets/general_text.dart';

class TabsPage extends ConsumerStatefulWidget {
  const TabsPage({super.key});

  @override
  ConsumerState<TabsPage> createState() => _TabPageState();
}

class _TabPageState extends ConsumerState<TabsPage>
    with SingleTickerProviderStateMixin {
  late AppData provider;

  late TabController tabController;
  Color? appBarColor;
  Color? indicatorColor;
  int selectedIndex = 0;
  double currentIndex = 0;
  late double animationValue;
  late double offset;
  late bool swipeRight;
  double counter = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);

    tabController.animation!.addListener(() {
      animationValue = tabController.animation!.value;
      offset = tabController.offset;
      currentIndex = animationValue % 1 == 0
          ? tabController.animation!.value
          : currentIndex;
      selectedIndex = tabController.index;
      swipeRight = animationValue > currentIndex;

      setState(() {
        if (selectedIndex != 0) {
          counter = 0;
        }

        if (swipeRight) {
          if (animationValue > selectedIndex) {
            appBarColor = Color.lerp(
              getAppBarColor(selectedIndex),
              getAppBarColor(selectedIndex + 1),
              offset.abs(),
            );

            indicatorColor = Color.lerp(
              getIndicatorColor(selectedIndex),
              getIndicatorColor(selectedIndex + 1),
              offset.abs(),
            );
          } else if (animationValue < selectedIndex) {
            appBarColor = Color.lerp(
              getAppBarColor(currentIndex.toInt()),
              getAppBarColor(selectedIndex),
              (animationValue / selectedIndex).abs(),
            );

            indicatorColor = Color.lerp(
              getIndicatorColor(currentIndex.toInt()),
              getIndicatorColor(selectedIndex),
              (animationValue / selectedIndex).abs(),
            );
          }
        } else {
          if (animationValue < selectedIndex) {
            appBarColor = Color.lerp(
              getAppBarColor(selectedIndex),
              getAppBarColor(selectedIndex - 1),
              offset.abs(),
            );

            indicatorColor = Color.lerp(
              getIndicatorColor(selectedIndex),
              getIndicatorColor(selectedIndex - 1),
              offset.abs(),
            );
          } else if (animationValue > selectedIndex) {
            appBarColor = Color.lerp(
              getAppBarColor(currentIndex.toInt()),
              getAppBarColor(selectedIndex),
              selectedIndex != 0
                  ? (selectedIndex / animationValue).abs()
                  : counter >= 1
                      ? 1
                      : (counter = counter + 0.15),
            );

            indicatorColor = Color.lerp(
              getIndicatorColor(currentIndex.toInt()),
              getIndicatorColor(selectedIndex),
              selectedIndex != 0
                  ? (selectedIndex / animationValue).abs()
                  : counter >= 1
                      ? 1
                      : (counter = counter + 0.15),
            );
          }
        }
      });
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Color? getAppBarColor(int index) {
    switch (index) {
      case 0:
        return Theme.of(context).appBarTheme.backgroundColor;
      case 1:
        return const Color(0xFFAD6D20);
      case 2:
        return const Color(0xFF1E5797);
      case 3:
        return const Color(0xFF107038);
      case 4:
        return const Color(0xFF421070);
      default:
        return Theme.of(context).appBarTheme.backgroundColor;
    }
  }

  Color? getIndicatorColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xFFF6857D);
      case 1:
        return const Color.fromARGB(255, 255, 202, 138);
      case 2:
        return const Color.fromARGB(255, 163, 206, 255);
      case 3:
        return const Color.fromARGB(255, 165, 255, 203);
      case 4:
        return const Color.fromARGB(255, 221, 185, 255);
      default:
        return const Color(0xFFF6857D);
    }
  }

  @override
  Widget build(BuildContext context) {
    provider = ref.watch(appData);

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: appBarColor, //changeColor(selectedIndex),
                foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
                title: const GeneralText(
                  text: "Invoice Generator",
                  fontFamily: "LiberationSans",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                pinned: true,
                floating: true,
                bottom: TabBar(
                  onTap: null,
                  tabAlignment: TabAlignment.start,
                  indicatorWeight: 2,
                  overlayColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                      color: indicatorColor ?? const Color(0xFFF6857D),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10))),
                  labelPadding: const EdgeInsets.only(right: 15, left: 15),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.white,
                  controller: tabController,
                  isScrollable: true,
                  tabs: const [
                    Tab(text: "Invoices"),
                    Tab(text: "Senders"),
                    Tab(text: "Recipients"),
                    Tab(text: "Courses"),
                    Tab(text: "Receipts"),
                  ],
                ),
              )
            ];
          },
          body: TabBarView(
            //physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: [
              // InvoiceListBuilder(
              //   invoices: provider.invoices,
              // ),
              // SenderListBuilder(senders: provider.senders),
              // RecipientListBuilder(recipients: provider.recipients),
              // CourseListBuilder(
              //   courses: provider.courses,
              // ),
              const Center(child: Text("RECEIPTS")),
              const Center(child: Text("RECEIPTS")),
              const Center(child: Text("RECEIPTS")),
              const Center(child: Text("RECEIPTS")),
              const Center(child: Text("RECEIPTS")),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: appBarColor,
          //splashColor: labelColor ?? const Color(0xFFF6857D),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
