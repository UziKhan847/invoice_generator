import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/page_views/loading_page_view.dart';
import 'package:markaz_umaza_invoice_generator/pages/homepage.dart';
import 'package:markaz_umaza_invoice_generator/pages/loading_pages/loading_screen_page.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';

class LoadingDataPage extends ConsumerStatefulWidget {
  const LoadingDataPage({super.key});

  @override
  ConsumerState<LoadingDataPage> createState() => _LoadingDataPageState();
}

class _LoadingDataPageState extends ConsumerState<LoadingDataPage> {
  late Future<void> data;

  @override
  void initState() {
    super.initState();
    data = ref.read(appData).getData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasError) {
          return const LoadingPageView(secondPage: Homepage());
        }
        return const LoadingScreenPage();
      },
    );
  }
}
