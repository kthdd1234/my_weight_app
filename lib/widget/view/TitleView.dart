import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_weight_app/common/CommonSvg.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/util/constant.dart';
import 'package:my_weight_app/util/final.dart';

class TitleView extends StatelessWidget {
  TitleView({
    super.key,
    required this.title,
    required this.isView,
    required this.onView,
  });

  String title;
  bool isView;
  Function() onView;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isView ? 10 : 0),
      child: Row(
        children: [
          CommonText(text: title, fontSize: defaultFontSize - 2),
          const Spacer(),
          InkWell(
            onTap: onView,
            child: Icon(
              isView
                  ? Icons.keyboard_arrow_down_rounded
                  : Icons.keyboard_arrow_right_rounded,
              color: grey.s400,
            ),
          ),
        ],
      ),
    );
  }
}
