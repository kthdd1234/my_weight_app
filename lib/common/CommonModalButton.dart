import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonContainer.dart';
import 'package:my_weight_app/common/CommonNull.dart';
import 'package:my_weight_app/common/CommonSpace.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/provider/ThemeProvider.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:provider/provider.dart';

class CommonModalButton extends StatelessWidget {
  CommonModalButton({
    super.key,
    required this.actionText,
    required this.onTap,
    this.isSelection,
    this.color,
    this.icon,
    this.svgName,
    this.innerPadding,
    this.isNotSvgColor,
    this.isNotTr,
  });

  String? svgName;
  IconData? icon;
  String actionText;
  bool? isNotTr, isNotSvgColor, isSelection;
  EdgeInsets? innerPadding;
  Color? color;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    Color bgColor = isLight ? Colors.white : darkContainerColor;
    Color settingColor = color ?? (isLight ? themeColor : darkTextColor);

    return Expanded(
      child: Padding(
        padding: innerPadding ?? const EdgeInsets.all(0),
        child: CommonContainer(
          color: isSelection == true ? themeColor : bgColor,
          onTap: onTap,
          radius: 7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              svgName != null
                  ? svgAsset(
                      isNotColor: isNotSvgColor,
                      isLight: isLight,
                      name: svgName!,
                      width: 25,
                      color: isSelection == true ? Colors.white : settingColor,
                    )
                  : const CommonNull(),
              icon != null
                  ? Icon(
                      icon!,
                      size: 25,
                      color: isSelection == true ? Colors.white : settingColor,
                    )
                  : const CommonNull(),
              CommonSpace(height: 10),
              CommonText(
                text: actionText,
                color: isSelection == true ? Colors.white : settingColor,
                isNotTr: isNotTr,
              )
            ],
          ),
        ),
      ),
    );
  }
}
