import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonNull.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/provider/ThemeProvider.dart';
import 'package:my_weight_app/util/enum.dart';
import 'package:my_weight_app/util/func.dart';
import 'package:provider/provider.dart';

class CommonSvgText extends StatelessWidget {
  CommonSvgText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.svgWidth,
    required this.svgDirection,
    this.svgName,
    this.isBold,
    this.isNotTr,
    this.svgRight,
    this.svgLeft,
    this.svgColor,
    this.textColor,
    this.outerPadding,
    this.onTap,
  });

  String text;
  String? svgName;
  Color? textColor, svgColor;
  double svgWidth, fontSize;
  double? svgLeft, svgRight;
  bool? isBold, isNotTr;
  SvgDirection svgDirection;
  EdgeInsets? outerPadding;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    List<Widget> children = [
      CommonText(
        text: text,
        fontSize: fontSize,
        isNotTr: isNotTr,
        isBold: isBold,
        color: textColor,
        overflow: TextOverflow.ellipsis,
      )
    ];

    svgDirection == SvgDirection.left
        ? svgName != null
            ? children.insert(
                0,
                Padding(
                  padding: EdgeInsets.only(right: svgRight ?? 5),
                  child: svgAsset(
                    name: svgName!,
                    width: svgWidth,
                    color: svgColor,
                    isLight: isLight,
                  ),
                ))
            : const CommonNull()
        : svgName != null
            ? children.add(Padding(
                padding: EdgeInsets.only(left: svgLeft ?? 5),
                child: svgAsset(
                  name: svgName!,
                  width: svgWidth,
                  color: svgColor,
                  isLight: isLight,
                ),
              ))
            : const CommonNull();

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: outerPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}
