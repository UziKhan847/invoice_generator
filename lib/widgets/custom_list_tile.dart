import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:markaz_umaza_invoice_generator/themes/my_themes.dart';
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
    this.onTapSave,
    this.isInvoiceReceipt = false,
  });

  final double? boxHeight;
  final Widget? leadingIcon;
  final bool isLastIndex;
  final List<Widget> content;
  final VoidCallback? onTapDelete;
  final VoidCallback? onTapMail;
  final VoidCallback? onTapEdit;
  final VoidCallback? onTapPreview;
  final VoidCallback? onTapSave;
  final bool isInvoiceReceipt;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: isLastIndex
          ? const EdgeInsets.only(top: 5, bottom: 131)
          : const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? MyThemes.secondaryDark
            : Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Slidable(
        startActionPane: !isInvoiceReceipt
            ? null
            : ActionPane(motion: const BehindMotion(), children: [
                SlidableItem(
                  icon: Icons.picture_as_pdf,
                  text: 'Preview',
                  onTap: onTapPreview,
                  backgroundColor: const Color.fromARGB(255, 95, 0, 119),
                  splashColor: const Color.fromARGB(255, 203, 13, 255),
                  itemPosition: SlidableItemPosition.first,
                ),
              ]),
        endActionPane: ActionPane(motion: const BehindMotion(), children: [
          if (isInvoiceReceipt)
            SlidableItem(
              icon: Icons.download,
              text: 'Download',
              onTap: onTapSave,
              backgroundColor: const Color(0xFF003C77),
              splashColor: const Color(0xFF0D86FF),
            ),
          if (isInvoiceReceipt)
            SlidableItem(
              icon: Icons.mail,
              text: 'Mail',
              onTap: onTapMail,
              backgroundColor: const Color(0xFF965F00),
              splashColor: const Color(0xFFFFA70F),
            ),
          SlidableItem(
            icon: Icons.delete,
            text: 'Delete',
            onTap: onTapDelete,
            backgroundColor: const Color(0xFF8F0000),
            splashColor: const Color(0xFFFF1010),
            itemPosition: SlidableItemPosition.last,
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

enum SlidableItemPosition { first, last, middle }
