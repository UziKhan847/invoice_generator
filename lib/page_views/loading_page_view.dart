import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/pages/homepage.dart';
import 'package:markaz_umaza_invoice_generator/pages/loading_pages/loading_screen_page.dart';

class LoadingPageView extends StatefulWidget {
  const LoadingPageView({super.key, required this.secondPage});

  final Widget secondPage;

  @override
  State<LoadingPageView> createState() => _LoadingPageViewState();
}

class _LoadingPageViewState extends State<LoadingPageView> {
  late final pageController = PageController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (pageController.hasClients) {
        pageController.nextPage(
            duration: Duration(milliseconds: 1000), curve: Curves.linear);
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      children: [const LoadingScreenPage(), widget.secondPage],
    );
  }
}
