import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/main.dart';
import 'package:markaz_umaza_invoice_generator/pages/loading_pages/loading_data_page.dart';
import 'package:markaz_umaza_invoice_generator/pages/loading_pages/loading_screen_page.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';
import 'package:path_provider/path_provider.dart';

class LoadingLogoPage extends ConsumerStatefulWidget {
  const LoadingLogoPage({super.key});

  @override
  ConsumerState<LoadingLogoPage> createState() => _LoadingLogoPageState();
}

class _LoadingLogoPageState extends ConsumerState<LoadingLogoPage> {
  late AppData provider;
  late Future<void> data;

  Future<void> getLogo(String? logoUrl) async {
    if (logoUrl == null) {
      return;
    }

    try {
      final dir = await getTemporaryDirectory();

      final file = File("${dir.path}/$logoUrl");

      if (await file.exists()) {
        await file.delete();
      }

      final downloadedFile =
          await supabase.storage.from('logos').download(logoUrl);

      await file.writeAsBytes(downloadedFile);
    } catch (e) {
      throw Exception("Eexception: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    provider = ref.read(appData);
    data = getLogo(provider.profile.logoUrl);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: data,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const LoadingDataPage();
          }

          return const LoadingScreenPage();
        });
  }
}
