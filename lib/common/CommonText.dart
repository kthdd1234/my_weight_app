import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_weight_app/provider/ThemeProvider.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:provider/provider.dart';

class CommonText extends StatelessWidget {
  CommonText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.isNotTr,
    this.isBold,
    this.highlightColor,
    this.nameArgs,
    this.textAlign,
    this.overflow,
    this.softWrap,
    this.decoration,
    this.isUnderline,
    this.decorationColor,
  });

  String text;
  Color? color;
  double? fontSize;
  bool? isNotTr, isBold;
  Color? highlightColor;
  Map<String, String>? nameArgs;
  TextAlign? textAlign;
  TextOverflow? overflow;
  bool? softWrap, isUnderline;
  TextDecoration? decoration;
  Color? decorationColor;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    Color defaultColor = isLight ? Colors.black : darkTextColor;
    Color fontColor =
        isUnderline == true ? Colors.transparent : color ?? defaultColor;
    // double fontSizeValue = userRepository.isUser
    //     ? (fontSize ?? userRepository.user.fontSize ?? defaultFontSize)
    //     : defaultFontSize;

    return Container(
      padding: EdgeInsets.all(highlightColor != null ? 3 : 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: highlightColor,
      ),
      child: Text(
        isNotTr == true ? text : text.tr(namedArgs: nameArgs),
        textAlign: textAlign ?? TextAlign.center,
        softWrap: softWrap ?? true,
        style: TextStyle(
          color: fontColor,
          height: isUnderline == true ? 1.9 : null,
          fontSize: fontSize ?? defaultFontSize,
          fontWeight: isBold == true ? FontWeight.bold : FontWeight.w400,
          overflow: overflow,
          decoration: decoration,
          decorationColor: decorationColor,
          decorationStyle:
              isUnderline == true ? TextDecorationStyle.dotted : null,
          shadows: isUnderline == true
              ? [Shadow(color: defaultColor, offset: const Offset(0, -9))]
              : null,
        ),
      ),
    );
  }
}
