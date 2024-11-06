import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/pages/detail_page.dart';
import 'package:markaz_umaza_invoice_generator/pages/homepage.dart';
import 'package:markaz_umaza_invoice_generator/pages/invoice_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
            tileColor: Color.fromARGB(255, 247, 247, 247)),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF951414),
          foregroundColor: Colors.white,
          elevation: 4,
          shape: CircleBorder(),
        ),
      ),
      home: const MyHomePage(),
      routes: {
        "/homepage": (context) => const Homepage(),
        "/invoice_list_page": (context) => const InvoiceListPage(),
        "/detail_page": (context) => const DetailPage(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Homepage();
  }
}
