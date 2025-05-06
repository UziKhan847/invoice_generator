
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class UploadLogoContainer extends StatelessWidget {
  const UploadLogoContainer({super.key, required this.orientation, required this.size});

  final Orientation orientation;
  final double size;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(4),
      dashPattern: const [8, 4],
      strokeWidth: 2.5,
      color: Colors.black,
      child: SizedBox(
        width: size,
        height: size,
        child: const Center(
          child: Text(
            'Click Here\n to Upload Logo',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
