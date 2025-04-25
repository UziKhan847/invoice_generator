import 'package:flutter/material.dart';

class LoadingScreenPage extends StatelessWidget {
  const LoadingScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
