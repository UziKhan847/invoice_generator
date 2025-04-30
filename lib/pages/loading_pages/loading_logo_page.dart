import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/main.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';
import 'package:path_provider/path_provider.dart';

class LoadingLogoPage extends ConsumerStatefulWidget {
  const LoadingLogoPage({super.key});

  @override
  ConsumerState<LoadingLogoPage> createState() => _LoadingLogoPageState();
}

class _LoadingLogoPageState extends ConsumerState<LoadingLogoPage> {
  late AppData provider;

  Future<void> getLogo(String userId, String? logoPath) async {
    final dir = getApplicationDocumentsDirectory();

    final file = File("$dir/$userId/compressed_logo.png");

    if (logoPath == null || await file.exists()) {
      return;
    }
  }

  @override
  void initState() {
    super.initState();
    provider = ref.watch(appData);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
