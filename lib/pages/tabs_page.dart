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
    with TickerProviderStateMixin {
  int selectedIndex = 0;
  late AppData provider;

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);

    tabController.addListener(() {
      setState(() {
        selectedIndex = tabController.index;
      });
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Color? changeColor(int index) {
    switch (index) {
      case 0:
        return Theme.of(context).appBarTheme.backgroundColor;
      case 1:
        return const Color(0xFFAD6D20);
      case 2:
        return const Color.fromARGB(255, 30, 87, 151);
      case 3:
        return const Color.fromARGB(255, 16, 112, 56);
      case 4:
        return const Color.fromARGB(255, 66, 16, 112);
    }
  }

  Color? changeIndicatorColor(int index) {
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
                backgroundColor: changeColor(selectedIndex),
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
                  tabAlignment: TabAlignment.start,
                  indicatorWeight: 2,
                  overlayColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: BoxDecoration(
                      color: changeIndicatorColor(selectedIndex),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10))),
                  labelPadding: const EdgeInsets.only(right: 15, left: 15),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.white,
                  controller: tabController,
                  // onTap: (index) {
                  //   setState(() {
                  //     selectedIndex = index;
                  //   });
                  // },
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
            physics: const NeverScrollableScrollPhysics(),
            controller: tabController,
            children: [
              InvoiceListBuilder(
                invoices: provider.invoices,
              ),
              SenderListBuilder(senders: provider.senders),
              RecipientListBuilder(recipients: provider.recipients),
              CourseListBuilder(
                courses: provider.courses,
              ),
              const Center(child: Text("RECEIPTS")),
            ],
          ),
        ),
        //  AppBar(
        //   backgroundColor: changeColor(selectedIndex),
        //   title: const GeneralText(
        //     text: "Invoice Generator",
        //     fontFamily: "LiberationSans",
        //     fontWeight: FontWeight.bold,
        //     fontSize: 20,
        //   ),
        //   bottom: TabBar(
        //     overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        //     indicatorSize: TabBarIndicatorSize.tab,
        //     indicator: BoxDecoration(
        //         color: changeIndicatorColor(selectedIndex),
        //         borderRadius: const BorderRadius.only(
        //             topRight: Radius.circular(10),
        //             topLeft: Radius.circular(10))),
        //     labelPadding: const EdgeInsets.all(0),
        //     labelColor: Colors.black,
        //     unselectedLabelColor: Colors.white,
        //     // controller: tabController,
        //     onTap: (index) {
        //       setState(() {
        //         selectedIndex = index;
        //       });
        //     },
        //     tabs: const [
        //       Tab(text: "Invoices"),
        //       Tab(text: "Senders"),
        //       Tab(text: "Recipients"),
        //       Tab(text: "Reciepts"),
        //     ],
        //   ),
        // ),
        // body: TabBarView(
        //   // controller: tabController,
        //   children: [
        //     InvoiceListBuilder(
        //       invoices: provider.invoices,
        //     ),
        //     SenderListBuilder(senders: provider.senders),
        //     RecipientListBuilder(recipients: provider.recipients),
        //     Center(child: Text("RECIIPTS")),
        //   ],
        // ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: changeColor(selectedIndex),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
