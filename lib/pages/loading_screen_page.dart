import 'package:flutter/material.dart';

class LoadingScreenPage extends StatelessWidget {
  const LoadingScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF951414),
      body: Center(
        child: CircularProgressIndicator(
          color: Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}
