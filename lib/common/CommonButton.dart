import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_weight_app/common/CommonText.dart';

class CommonButton extends StatelessWidget {
  CommonButton({
    super.key,
    required this.text,
    required this.textColor,
    required this.buttonColor,
    required this.verticalPadding,
    required this.borderRadius,
    required this.onTap,
    this.nameArgs,
    this.fontSize,
    this.isNotTr,
    this.outerPadding,
  });

  Color textColor, buttonColor;
  double verticalPadding, borderRadius;
  String text;
  EdgeInsetsGeometry? outerPadding;
  double? fontSize;
  bool? isBold, isNotTr;
  Map<String, String>? nameArgs;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: outerPadding ?? const EdgeInsets.all(0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: verticalPadding),
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: CommonText(
                    fontSize: fontSize,
                    isNotTr: isNotTr,
                    text: text,
                    color: textColor,
                    nameArgs: nameArgs,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
