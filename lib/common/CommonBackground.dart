import 'package:flutter/material.dart';
import 'package:my_weight_app/provider/ThemeProvider.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:provider/provider.dart';

class CommonBackground extends StatelessWidget {
  CommonBackground({
    super.key,
    required this.child,
    this.isRadius,
    this.height,
    this.borderRadius,
    this.padding,
    this.path,
  });

  bool? isRadius;
  double? height;
  BorderRadius? borderRadius;
  EdgeInsets? padding;
  String? path;
  Widget child;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Container(
      padding: padding,
      height: height ?? MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: isLight ? null : darkBgColor,
        borderRadius: borderRadius ??
            BorderRadius.circular(isRadius == true ? 10.0 : 0.0),
        image: isLight
            ? const DecorationImage(
                image: AssetImage('assets/images/texture-1.png'),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: child,
    );
  }
}
