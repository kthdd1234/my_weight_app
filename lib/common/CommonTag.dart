import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/provider/ThemeProvider.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:provider/provider.dart';

class CommonTag extends StatelessWidget {
  CommonTag({
    super.key,
    required this.text,
    required this.onTap,
    this.innerPadding,
    this.isBold,
    this.fontSize,
    this.vertical,
    this.isNotTr,
    this.isSelection,
  });

  String text;
  bool? isBold, isNotTr, isSelection;
  double? fontSize, vertical;
  EdgeInsets? innerPadding;

  Function() onTap;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    Color bgColor = isLight
        ? isSelection == true
            ? darkButtonColor
            : Colors.white
        : isSelection == true
            ? Colors.white
            : darkNotSelectedBgColor;

    Color color = isLight
        ? isSelection == true
            ? Colors.white
            : Colors.black
        : isSelection == true
            ? Colors.black
            : Colors.white;

    return Padding(
      padding: innerPadding ?? const EdgeInsets.all(0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding:
              EdgeInsets.symmetric(vertical: vertical ?? 3, horizontal: 10),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: CommonText(
            text: text,
            fontSize: fontSize,
            color: color,
            isNotTr: isNotTr,
          ),
        ),
      ),
    );
  }
}
