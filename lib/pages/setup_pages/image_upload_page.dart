import 'package:flutter/material.dart';

class ImageUploadPage extends StatefulWidget {
  const ImageUploadPage({super.key});

  @override
  State<ImageUploadPage> createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.image),
        iconSize: 200,
      ),
    );
  }
}
