import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:markaz_umaza_invoice_generator/widgets/slidable_item.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    this.boxHeight,
    this.leadingIcon,
    required this.content,
    required this.isLastIndex,
    this.onTapDelete,
    this.onTapEdit,
    this.onTapMail,
    this.onTapPreview,
    this.showPreviewButton = false,
  });

  final double? boxHeight;
  final Widget? leadingIcon;
  final bool isLastIndex;
  final List<Widget> content;
  final VoidCallback? onTapDelete;
  final VoidCallback? onTapMail;
  final VoidCallback? onTapEdit;
  final VoidCallback? onTapPreview;
  final bool showPreviewButton;

  get children => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isLastIndex
          ? const EdgeInsets.only(top: 5, bottom: 131)
          : const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(4)),
      child: Slidable(
        endActionPane: ActionPane(motion: const BehindMotion(), children: [
          if (showPreviewButton)
            SlidableItem(
                icon: Icons.picture_as_pdf,
                text: 'Preview PDF',
                onTap: onTapPreview,
                backgroundColor: const Color.fromARGB(255, 0, 60, 119),
                splashColor: const Color.fromARGB(255, 13, 134, 255),
                foregroundColor: Colors.white),
          if (showPreviewButton)
            SlidableItem(
              icon: Icons.mail,
              text: 'Mail',
              onTap: onTapMail,
              backgroundColor: const Color.fromARGB(255, 150, 95, 0),
              splashColor: const Color.fromARGB(255, 255, 167, 15),
            ),
          SlidableItem(
            icon: Icons.delete,
            text: 'Delete',
            onTap: onTapDelete,
            backgroundColor: const Color.fromARGB(255, 143, 0, 0),
            splashColor: const Color.fromARGB(255, 255, 16, 16),
            isLeftLast: true,
          ),
        ]),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...content,
            ],
          ),
        ),
      ),
    );
  }
}
