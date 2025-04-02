import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/keys.dart';
import 'package:markaz_umaza_invoice_generator/pages/loading_screen_page.dart';
import 'package:markaz_umaza_invoice_generator/pages/main_page.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

void main() async {
  await Supabase.initialize(
    url: supabaseUrlKey,
    anonKey: supabaseAnonKey,
  );

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  late AppData provider;
  late final data = provider.getData();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    provider = ref.watch(appData);

    return MaterialApp(
      title: "Invoice Generator",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF6B2C2C),
            foregroundColor: Colors.white,
            shadowColor: Colors.black,
            elevation: 4,
            centerTitle: true),
        listTileTheme: const ListTileThemeData(
            titleTextStyle: TextStyle(fontSize: 20),
            textColor: Colors.black,
            tileColor: Color(0xFFF7F7F7)),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF6B2C2C),
          foregroundColor: Colors.white,
          elevation: 4,
          shape: CircleBorder(),
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
          fixedSize: WidgetStatePropertyAll(Size(95, 20)),
          backgroundColor: WidgetStatePropertyAll(Colors.white),
          foregroundColor: WidgetStatePropertyAll(Colors.black),
          elevation: WidgetStatePropertyAll(4),
          overlayColor: WidgetStatePropertyAll(Color(0xFFDDDDDD)),
        )),
        inputDecorationTheme: const InputDecorationTheme(
            isDense: true,
            iconColor: Color(0xFF6A6A6A),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: TextStyle(
              color: Color(0xFF6A6A6A),
            ),
            errorStyle: TextStyle(height: 0, fontSize: 11),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF616161))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF135993))),
            errorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            focusedErrorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF616161)))),
        dialogTheme: const DialogTheme(backgroundColor: Color(0xFFF7F7F7)),
      ),
      home:
          // TabsPage()
          FutureBuilder(
              future: data,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    !snapshot.hasError) {
                  return const MainPage();
                }

                return const LoadingScreenPage();
              }),
    );
  }
}
