import 'package:flutter/cupertino.dart';
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
  Function(bool isView) onView;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isView ? 10 : 0),
      child: Row(
        children: [
          CommonText(text: title, fontSize: defaultFontSize - 2),
          const Spacer(),
          CommonSvg(
            name: isView ? 'dir-down-bold' : 'dir-right',
            onTap: () => onView(!isView),
            width: 13,
            color: grey.original,
            padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
          )
        ],
      ),
    );
  }
}
