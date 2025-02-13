import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    this.boxHeight,
    required this.leadingIcon,
    required this.content,
    required this.isLastIndex,
    this.onTapDelete,
    this.onTapEdit,
    this.onTapPreview,
    this.showPreviewButton = false,
  });

  final double? boxHeight;
  final Widget? leadingIcon;
  final bool isLastIndex;
  final List<Widget> content;
  final void Function()? onTapDelete;
  final void Function()? onTapEdit;
  final void Function()? onTapPreview;
  final bool showPreviewButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 60,
              child: leadingIcon,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: content,
              ),
            ),
            SizedBox(
              width: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (showPreviewButton)
                    IconButton(
                      onPressed: onTapPreview,
                      icon: const Icon(Icons.picture_as_pdf),
                    ),
                  IconButton(
                    onPressed: onTapDelete,
                    icon: const Icon(
                      Icons.delete_rounded,
                      color: Color(0xFFB71C1C),
                    ),
                  ),
                  // IconButton(
                  //   onPressed: onTapEdit,
                  //   icon: const Icon(Icons.edit),
                  // ),
                ],
              ),
            ),
          ],
        ),
        Margins.vertical4,
        const Divider(
          height: 0,
        ),
        if (isLastIndex) Margins.vertical88,
      ],
    );
  }
}
