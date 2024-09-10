import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/provider/ThemeProvider.dart';
import 'package:my_weight_app/util/class.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:provider/provider.dart';

class CommonTag extends StatelessWidget {
  CommonTag({
    super.key,
    required this.text,
    required this.onTap,
    this.isColor,
    this.colorName,
    this.innerPadding,
    this.isBold,
    this.fontSize,
    this.vertical,
    this.horizontal,
    this.isNotTr,
    this.isSelection,
  });

  String text;
  String? colorName;
  bool? isBold, isNotTr, isSelection, isColor;
  double? fontSize, vertical, horizontal;
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

    Color textColor = isLight
        ? isSelection == true
            ? Colors.white
            : Colors.black
        : isSelection == true
            ? Colors.black
            : Colors.white;

    if (isColor == true) {
      ColorClass colorInfo = getColorClass(colorName);

      bgColor = isSelection == true ? colorInfo.s50 : Colors.white;
      textColor = isSelection == true ? colorInfo.s400 : grey.original;
    }

    return Padding(
      padding: innerPadding ?? const EdgeInsets.all(0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
              vertical: vertical ?? 3, horizontal: horizontal ?? 10),
          decoration: BoxDecoration(
            color: colorName != '투명' ? bgColor : Colors.transparent,
            borderRadius: BorderRadius.circular(5),
          ),
          child: CommonText(
            text: text,
            fontSize: fontSize,
            color: textColor,
            isNotTr: isNotTr,
          ),
        ),
      ),
    );
  }
}
