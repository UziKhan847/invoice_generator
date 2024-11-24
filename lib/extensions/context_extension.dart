import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  static OverlayEntry? overlay;

  void showSnackBar(String message, {bool isError = false}) =>
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor:
              isError ? const Color(0xFF8A241D) : const Color(0xFF187218),
          duration: const Duration(milliseconds: 2500),
        ),
      );

  void dialog(
          {bool barrierDismissible = true,
          required String title,
          Widget? content,
          List<Widget>? actions,
          required BuildContext context}) =>
      showDialog<void>(
          barrierDismissible: barrierDismissible,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              content: content,
              actions: actions,
            );
          });

  void insertOverlay(
    BuildContext context, {
    required Widget? listViewBuilder,
    required Function()? onTapOutsideOverlay,
    double? top,
    double? bottom,
    double? right,
    double? left,
    double? height,
    double? width,
  }) {
    removeOverlay();

    overlay = OverlayEntry(
        builder: (BuildContext context) => Stack(
              children: [
                GestureDetector(
                  onTap: onTapOutsideOverlay,
                  child: Container(
                    color: Colors.transparent,
                  ),
                ),
                Positioned(
                    top: top,
                    bottom: bottom,
                    right: right,
                    left: left,
                    height: height,
                    width: width,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                  offset: const Offset(0, 2))
                            ],
                          ),
                        ),
                        listViewBuilder!
                      ],
                    ))
              ],
            ));

    Overlay.of(context).insert(overlay!);
  }

  void removeOverlay() {
    overlay?.remove();
    overlay?.dispose();
    overlay = null;
  }
}
