import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/pages/loading_pages/loading_data_page.dart';

class SetupPage extends StatefulWidget {
  SetupPage({super.key});

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  late final controller = PageController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Center(
            child: ElevatedButton(
                onPressed: () {
                  controller.nextPage(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.linear);
                },
                child: const Text("Loading Page")),
          ),
          const LoadingDataPage(),
        ],
      ),
    );
  }
}
