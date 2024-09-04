import 'package:flutter/material.dart';
import 'package:my_weight_app/provider/ThemeProvider.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:provider/provider.dart';

class CommonDivider extends StatelessWidget {
  CommonDivider({super.key, this.color, this.horizontal, this.vertical});
  Color? color;
  double? horizontal, vertical;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal ?? 0,
        vertical: vertical ?? 0,
      ),
      child: Divider(
        color: color ?? (isLight ? grey.s400 : Colors.white30),
        height: 0,
        thickness: 0.5,
      ),
    );
  }
}
