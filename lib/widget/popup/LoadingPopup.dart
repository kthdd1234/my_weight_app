import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonNull.dart';
import 'package:my_weight_app/common/CommonSpace.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/util/constant.dart';

class LoadingPopup extends StatelessWidget {
  LoadingPopup({
    super.key,
    required this.text,
    required this.color,
    this.isLoadingIcon,
    this.nameArgs,
    this.subText,
  });

  String text;
  Color color;
  String? subText;
  bool? isLoadingIcon;
  Map<String, String>? nameArgs;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isLoadingIcon == false
            ? const CommonNull()
            : const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              ),
        CommonText(
          text: text,
          fontSize: defaultFontSize - 2,
          color: color,
          nameArgs: nameArgs,
          decoration: TextDecoration.none,
        ),
        CommonSpace(height: 3),
        subText != null
            ? CommonText(
                text: subText!,
                fontSize: defaultFontSize - 5,
                color: color,
                nameArgs: nameArgs,
              )
            : const CommonNull(),
      ],
    );
  }
}
