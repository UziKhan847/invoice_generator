import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/handlers/image_handler.dart';
import 'package:markaz_umaza_invoice_generator/providers/logo_image_data.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';
import 'package:markaz_umaza_invoice_generator/widgets/setup_page_widgets/upload_logo_container.dart';

class LogoUpload extends ConsumerStatefulWidget {
  const LogoUpload({
    super.key,
    required this.orientation,
    //required this.uploadImage,
    required this.logoUrl,
  });

  final Orientation orientation;
  // final void Function(Uint8List?) uploadImage;
  final String logoUrl;

  @override
  ConsumerState<LogoUpload> createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends ConsumerState<LogoUpload> {
  bool isLoading = false;

  Future<void> handleImageUpload() async {
    setState(() => isLoading = true);
    final imageHandler = ImageHandler(logoUrl: widget.logoUrl);
    final bytes = await imageHandler.getImageAsBytes();
    if (bytes != null) {
      ref.read(logoImageProvider.notifier).state = bytes;
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final imageBytes = ref.watch(logoImageProvider);
    final orientation = MediaQuery.of(context).orientation;
    final double size = orientation == Orientation.portrait ? 210 : 175;

    return Center(
      child: Column(
        spacing: 12,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.orientation == Orientation.portrait) ...[
            const Text(
              "Upload a Logo",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Optional. Can be uploaded later; otherwise, the app icon will be used as the default logo.",
              textAlign: TextAlign.center,
            ),
            Margins.vertical10,
          ],
          Material(
            child: InkWell(
              onTap: isLoading ? null : handleImageUpload,
              child: isLoading
                  ? SizedBox(
                      width: size,
                      height: size,
                      child: Center(
                          child: CircularProgressIndicator(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? null
                            : Colors.black,
                      )),
                    )
                  : imageBytes != null
                      ? ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: size,
                            maxWidth: size,
                          ),
                          child: Image.memory(
                            imageBytes,
                          ),
                        )
                      : UploadLogoContainer(
                          orientation: orientation,
                          size: size,
                        ),
            ),
          ),
          if (orientation == Orientation.portrait) ...[
            SizedBox(
              height: 30,
              child: imageBytes != null
                  ? const Text("This is a preview of the logo.")
                  : null,
            ),
            Margins.vertical10,
          ],
        ],
      ),
    );
  }
}
