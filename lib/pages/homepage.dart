import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/tiles/user_tile.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Person"),
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) => UserTile(
          name: index.isEven ? "Umair's Invoices" : "Uzair's Invoices",
        ),
      ),
    );
  }
}
