import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';

class AddDialogTile extends StatelessWidget {
  const AddDialogTile({
    super.key,
    required this.dialogContent,
    required this.dialogTitle,
    required this.onTapAdd,
    required this.onTapCancel,
    required this.isLoading,
    this.dialogInsetPadding = 12,
  });

  final double dialogInsetPadding;
  final String dialogTitle;
  final Widget? dialogContent;
  final void Function()? onTapAdd;
  final void Function()? onTapCancel;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.only(top: 16, bottom: 8, left: 20, right: 20),
      insetPadding: const EdgeInsets.all(0),
      title: Text(
        dialogTitle,
        style: const TextStyle(fontSize: 20),
      ),
      content: dialogContent,
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
                      child: const Text("Close"),
                    ),
                    Margins.horizontal10,
                    ElevatedButton(
                      onPressed: onTapAdd,
                      child: const Text("Add"),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
