import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonBackground.dart';
import 'package:my_weight_app/provider/ThemeProvider.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:provider/provider.dart';

class CommonPopup extends StatelessWidget {
  CommonPopup({
    super.key,
    required this.height,
    required this.child,
    this.insetPaddingHorizontal,
  });

  double? insetPaddingHorizontal;
  double height;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      insetPadding:
          EdgeInsets.symmetric(horizontal: insetPaddingHorizontal ?? 30),
      shape: roundedRectangleBorder,
      content: CommonBackground(
        isRadius: true,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        padding: const EdgeInsets.all(0),
        height: height,
        child: child,
      ),
    );
  }
}
