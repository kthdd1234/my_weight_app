import 'package:flutter/cupertino.dart';
import 'package:my_weight_app/common/CommonContainer.dart';
import 'package:my_weight_app/common/CommonText.dart';
import 'package:my_weight_app/util/final.dart';
import 'package:my_weight_app/widget/view/TitleView.dart';

class DiaryContainer extends StatelessWidget {
  DiaryContainer({super.key, required this.onView});

  Function(bool isView) onView;

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      outerPadding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          TitleView(title: '일기', isView: true, onView: onView),
          CommonContainer(
            height: 50,
            isAddShadow: true,
            child: CommonText(text: '+ 일기 쓰기', color: grey.s400),
          )
        ],
      ),
    );
  }
}
