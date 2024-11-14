import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/keys.dart';
import 'package:markaz_umaza_invoice_generator/pages/loading_screen_page.dart';
import 'package:markaz_umaza_invoice_generator/pages/tabs_page.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

void main() async {
  await Supabase.initialize(
    url: supabaseUrlKey,
    anonKey: supabaseAnonKey,
  );

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  // late final AppData provider;
  // late final data = provider.getData();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // provider = ref.watch(appData);

    return MaterialApp(
      title: "Invoice Generator",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF951414),
              foregroundColor: Colors.white,
              shadowColor: Colors.black,
              elevation: 4,
              centerTitle: true),
          listTileTheme: const ListTileThemeData(
              titleTextStyle: TextStyle(fontSize: 20),
              textColor: Colors.black,
              tileColor: Color(0xFFF7F7F7)),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF951414),
            foregroundColor: Colors.white,
            elevation: 4,
            shape: CircleBorder(),
          ),
          elevatedButtonTheme: const ElevatedButtonThemeData(
              style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.white),
            foregroundColor: WidgetStatePropertyAll(Color(0xFF951414)),
            elevation: WidgetStatePropertyAll(4),
            overlayColor: WidgetStatePropertyAll(Color(0xFFFFC9C9)),
          ))),
      home: TabsPage() 
      // FutureBuilder(
      //     future: data,
      //     builder: (context, snapshot) {
      //       if (snapshot.connectionState == ConnectionState.done) {
      //         return const TabsPage();
      //       }

      //       return const LoadingScreenPage();
      //     }),
    );
  }
}
