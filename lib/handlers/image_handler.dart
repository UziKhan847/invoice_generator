import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:markaz_umaza_invoice_generator/extensions/context_extension.dart';
import 'package:markaz_umaza_invoice_generator/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImageHandler {
  ImageHandler({required this.logoUrl});

  String logoUrl;

  Future<Uint8List?> getImageAsBytes() async {
    try {
      final picker = ImagePicker();

      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile == null) {
        return null;
      }

      final bytes = await pickedFile.readAsBytes();

      final originalImage = img.decodeImage(bytes);

      if (originalImage == null) {
        return null;
      }

      if (originalImage.height > 500) {
        final resizedImage = img.copyResize(originalImage, height: 500);
        return img.encodePng(resizedImage);
      }

      // final fileExtension = image.name.split('.').last.toLowerCase();
      // if (fileExtension != 'png') {
      //   return await FlutterImageCompress.compressWithList(bytes,
      //       format: CompressFormat.png);
      // }

      return img.encodePng(originalImage);
    } catch (e) {
      return null;
    }
  }

  Future<bool> uploadAndSaveImage(BuildContext context) async {
    try {
      final image = await getImageAsBytes();

      if (image == null) {
        return false;
      }

      final dir = await getTemporaryDirectory();

      if (!await dir.exists()) {
        dir.create(recursive: true);
      }

      final file = File("${dir.path}/$logoUrl");

      await file.writeAsBytes(image);

      await supabase.storage.from('logos').uploadBinary(logoUrl, image,
          fileOptions:
              const FileOptions(upsert: true, contentType: "image/png"));

      if (context.mounted) {
        context.showSnackBar("Success in uploading and saving the image!");
      }

      return true;
    } catch (e) {
      if (context.mounted) {
        context.showSnackBar("Could not upload or save image. Error: $e",
            isError: true);
      }
      return false;
    }
  }
}
