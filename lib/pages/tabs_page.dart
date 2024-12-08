import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/adding_dialogs/add_course.dart';
import 'package:markaz_umaza_invoice_generator/adding_dialogs/add_invoice.dart';
import 'package:markaz_umaza_invoice_generator/adding_dialogs/add_receipt.dart';
import 'package:markaz_umaza_invoice_generator/adding_dialogs/add_recipient.dart';
import 'package:markaz_umaza_invoice_generator/adding_dialogs/add_sender.dart';
import 'package:markaz_umaza_invoice_generator/list_view_builders/course_list_builder.dart';
import 'package:markaz_umaza_invoice_generator/list_view_builders/invoice_list_builder.dart';
import 'package:markaz_umaza_invoice_generator/list_view_builders/receipt_list_builder.dart';
import 'package:markaz_umaza_invoice_generator/list_view_builders/recipient_list_builder.dart';
import 'package:markaz_umaza_invoice_generator/list_view_builders/sender_list_builder.dart';
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

  late TabController tabController = TabController(length: 5, vsync: this);
  int currentIndex = 0;
  int nextIndex = 0;
  double lerp = 0.0;
  bool isTransitioning = false;

  final appBarColors = [
    const Color(0xFF951414),
    const Color(0xFFAD6D20),
    const Color(0xFF1E5797),
    const Color(0xFF107038),
    const Color(0xFF421070)
  ];

  final indicatorColors = [
    const Color(0xFFF6857D),
    const Color(0xFFFFCA8A),
    const Color(0xFFA3CEFF),
    const Color(0xFFA5FFCB),
    const Color(0xFFDDB9FF)
  ];

  Color? get appBarColor {
    return Color.lerp(
      appBarColors[currentIndex],
      appBarColors[nextIndex],
      lerp,
    );
  }

  Color? get indicatorColor {
    return Color.lerp(
      indicatorColors[currentIndex],
      indicatorColors[nextIndex],
      lerp,
    );
  }

  @override
  void initState() {
    super.initState();

    tabController.animation!.addListener(() {
      final animationValue = tabController.animation!.value;
      final tabIndex = tabController.index;
      currentIndex =
          animationValue % 1 == 0 ? animationValue.toInt() : currentIndex;
      final differenceOnTap = (tabIndex - currentIndex).abs();
      final swipeRight = animationValue > currentIndex;

      //onSwipe
      if (currentIndex == tabIndex) {
        nextIndex = swipeRight ? animationValue.ceil() : animationValue.floor();
        lerp = tabController.offset.abs();
      }
      //onTap
      else {
        nextIndex = tabIndex;
        lerp = (animationValue - currentIndex).abs() / differenceOnTap;
      }

      setState(() {});
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
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
                backgroundColor: appBarColor,
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
            controller: tabController,
            children: [
              InvoiceListBuilder(invoices: provider.invoices),
              SenderListBuilder(senders: provider.senders),
              RecipientListBuilder(recipients: provider.recipients),
              CourseListBuilder(courses: provider.courses),
              ReceiptListBuilder(receipts: provider.receipts)
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog<String>(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) => switch (currentIndex) {
                    1 => const AddSender(),
                    2 => const AddRecipient(),
                    3 => const AddCourse(),
                    4 => const AddReceipt(),
                    _ => const AddInvoice(),
                  }),
          backgroundColor: appBarColor,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
