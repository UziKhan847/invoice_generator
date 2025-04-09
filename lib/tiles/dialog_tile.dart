import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';

class DialogTile extends StatelessWidget {
  const DialogTile({
    super.key,
    this.dialogContent,
    required this.dialogTitle,
    this.dialogHeight,
    required this.onTapAffirm,
    required this.onTapCancel,
    this.isLoading = false,
    required this.affirmButtonText,
    required this.cancelButtonText,
    this.dialogInsetPadding = 12,
    this.textAlign = TextAlign.left,
  });

  final double dialogInsetPadding;
  final String dialogTitle;
  final Widget? dialogContent;
  final double? dialogHeight;
  final void Function()? onTapAffirm;
  final void Function()? onTapCancel;
  final bool isLoading;
  final String affirmButtonText;
  final String cancelButtonText;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
       
        contentPadding:
            const EdgeInsets.only(top: 16, bottom: 8, left: 20, right: 20),
        insetPadding: const EdgeInsets.all(0),
        title: Text(
          dialogTitle,
          style: const TextStyle(
            fontSize: 20,
          ),
          textAlign: textAlign,
        ),
        content: SizedBox(
          height: dialogHeight,
          child: dialogContent,
        ),
        actions: [
          SizedBox(
            height: 50,
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: onTapCancel,
                        child: Text(cancelButtonText),
                      ),
                      Margins.horizontal10,
                      ElevatedButton(
                        onPressed: onTapAffirm,
                        child: Text(affirmButtonText),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
