import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  static OverlayEntry? overlay;

  void insertOverlay(
    BuildContext context, {
    required Function()? onTapOutsideOverlay,
    required itemCount,
    required Widget? Function(BuildContext, int) itemBuilder,
    required LayerLink layerLink,
    GlobalKey? widgetKey,
  }) {
    removeOverlay();

    final renderBox =
        widgetKey!.currentContext!.findRenderObject()! as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final height = renderBox.size.height;
     final width = renderBox.size.width;
    final screnHeight = MediaQuery.of(this).size.height;
    final buttonBottom = position.dy + height;
    final availableHeight = screnHeight - buttonBottom - 16;

    overlay = OverlayEntry(
        builder: (BuildContext context) => Stack(
              children: [
                GestureDetector(
                  onTap: onTapOutsideOverlay,
                  behavior: HitTestBehavior.translucent,
                ),
                Positioned(
                    width: width,
                    child: CompositedTransformFollower(
                      link: layerLink,
                      offset: const Offset(0, 48),
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(4),
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black
                            : const Color(0xFFF2F2F2),
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(maxHeight: availableHeight),
                          child: ListView.builder(
                            padding: const EdgeInsets.all(0),
                            shrinkWrap: true,
                            itemCount: itemCount,
                            itemBuilder: itemBuilder,
                          ),
                        ),
                      ),
                    ))
              ],
            ));

    Overlay.of(this).insert(overlay!);
  }

  void removeOverlay() {
    overlay?.remove();
    overlay?.dispose();
    overlay = null;
  }

  void showSnackBar(String message, {bool isError = false}) =>
      ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor:
              isError ? const Color(0xFF8A241D) : const Color(0xFF187218),
          duration: const Duration(milliseconds: 2500),
        ),
      );
}
