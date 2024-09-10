import 'package:flutter/cupertino.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';

class CommonRichText extends StatelessWidget {
  CommonRichText({
    super.key,
    required this.startText,
    required this.targetText,
    required this.targetTextColor,
    required this.endText,
  });

  String startText, targetText, endText;
  Color targetTextColor;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(
            text: startText,
            style: const TextStyle(fontSize: defaultFontSize - 1),
          ),
          TextSpan(
            text: targetText,
            style: TextStyle(
              color: targetTextColor,
              fontSize: defaultFontSize - 1,
            ),
          ),
          TextSpan(
            text: endText,
            style: const TextStyle(fontSize: defaultFontSize - 1),
          ),
        ],
      ),
    );
  }
}
