import 'package:flutter/material.dart';
import 'package:my_weight_app/provider/ThemeProvider.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:provider/provider.dart';

class CommonSvg extends StatelessWidget {
  CommonSvg({
    super.key,
    required this.name,
    required this.onTap,
    required this.padding,
    this.width,
    this.color,
  });

  String name;
  EdgeInsets padding;
  double? width;
  Color? color;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: svgAsset(
          name: name,
          width: width ?? 21,
          isLight: isLight,
          color: color,
        ),
      ),
    );
  }
}
