import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:markaz_umaza_invoice_generator/extensions/context_extension.dart';
import 'package:markaz_umaza_invoice_generator/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ImageHandler {
  final userId = supabase.auth.currentUser!.id;

  Future<Uint8List?> getCompressedImageAsBytes() async {
    final picker = ImagePicker();

    final image =
        await picker.pickImage(source: ImageSource.gallery, maxHeight: 500);

    if (image == null) {
      return null;
    }

    final compressedImg = await FlutterImageCompress.compressWithFile(
        image.path,
        quality: 5,
        format: CompressFormat.png);

    return compressedImg;
  }

  Future<void> uploadAndSaveImage(BuildContext context) async {
    try {
      final compressedImgAsBytes = await getCompressedImageAsBytes();

      if (compressedImgAsBytes == null) {
        return;
      }

      final dir = getApplicationDocumentsDirectory();

      final file = File("$dir/$userId/compressed_logo.png");

      await file.writeAsBytes(compressedImgAsBytes);

      await supabase.storage.from('logos').uploadBinary(
          "$userId/compressed_logo.png", compressedImgAsBytes,
          fileOptions:
              const FileOptions(upsert: true, contentType: "image/png"));

      await supabase
          .from('profiles')
          .update({'logo_url': file.path}).eq("id", userId);

      if (context.mounted) {
        context.showSnackBar("Succesfully updated logo!");
      }
    } catch (e) {
      if (context.mounted) {
        context.showSnackBar("Failed to update logo.", isError: true);
      }
    }
  }
}
